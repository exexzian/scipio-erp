package com.ilscipio.cato.common;

import static org.ofbiz.base.util.UtilGenerics.checkList;
import static org.ofbiz.base.util.UtilGenerics.checkMap;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.RandomAccessFile;
import java.io.Writer;
import java.nio.ByteBuffer;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.mail.internet.MimeMessage;

import org.ofbiz.base.metrics.Metrics;
import org.ofbiz.base.metrics.MetricsFactory;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilCodec;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.model.ModelEntity;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityDataLoader;
import org.ofbiz.entity.util.EntityQuery;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceSynchronization;
import org.ofbiz.service.ServiceUtil;
import org.ofbiz.service.mail.MimeMessageWrapper;

/**
 * Cato Common Services
 */
public class CommonServices {

    public final static String module = CommonServices.class.getName();
    public static final String resource = "CommonUiLabels";

    /**
     * Reload visual theme definitions of specified theme or all themes if not specified.
     * 
     * @param dctx The DispatchContext that this service is operating in
     * @param context Map containing the input parameters
     * @return Map with the result of the service, the output parameters
     */
    public static Map<String, Object> reloadVisualThemeResources(DispatchContext dctx, Map<String, ?> context) {
        Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        String singleVisualThemeId = (String) context.get("visualThemeId");

        try {
            List<String> visualThemeIds = new ArrayList<String>();
            if (singleVisualThemeId != null) {
                GenericValue visualTheme = delegator.findOne("VisualTheme", false, UtilMisc.toMap("visualThemeId", singleVisualThemeId));
                if (visualTheme != null) {
                    visualThemeIds.add(singleVisualThemeId);
                }
                else {
                    return ServiceUtil.returnError("Could not find visual theme " + singleVisualThemeId);
                }
            }
            else {
                List<GenericValue> visualThemes = delegator.findAll("VisualTheme", false);
                if (visualThemes != null) {
                    for(GenericValue visualTheme : visualThemes) {
                        visualThemeIds.add(visualTheme.getString("visualThemeId"));
                    }
                }
            }
            
            if (!visualThemeIds.isEmpty()) {
                int numReloaded = 0;
                for(String visualThemeId : visualThemeIds) {
            
                    List<GenericValue> themeFileValues = delegator.findByAnd("VisualThemeResource", 
                            UtilMisc.toMap("visualThemeId", visualThemeId, "resourceTypeEnumId", "VT_THEME_DATA_RES"),
                            UtilMisc.toList("sequenceId"), false);
                    
                    List<String> themeFileLocations = new ArrayList<String>();
                    if (themeFileValues != null) {
                        for(GenericValue themeFileValue : themeFileValues) {
                            String themeFileLocation = themeFileValue.getString("resourceValue");
                            if (UtilValidate.isNotEmpty(themeFileLocation)) {
                                themeFileLocations.add(themeFileLocation);
                            }
                        }
                    }
                    
                    if (UtilValidate.isNotEmpty(themeFileLocations)) {
                        delegator.removeByAnd("VisualThemeResource", UtilMisc.toMap("visualThemeId", visualThemeId));
                        // Don't do this line because technically violates foreign keys on other tables; not really needed anyway
                        //delegator.removeByAnd("VisualTheme", UtilMisc.toMap("visualThemeId", visualThemeId));
                        
                        for(String themeFileLocation : themeFileLocations) {
                            List<String> messages = new ArrayList<String>();
                            Map<String, Object> servCtx = dctx.makeValidContext("entityImport", ModelService.IN_PARAM, context);
                            servCtx.put("filename", themeFileLocation);
                            servCtx.put("isUrl", "Y");
                            servCtx.put("messages", messages);
                            Map<String, Object> servResult = dispatcher.runSync("entityImport", servCtx);
                            if (ServiceUtil.isError(servResult)) {
                                return ServiceUtil.returnError("Could not load visual theme " + visualThemeId + 
                                        " resource data " + themeFileLocations + ": " + 
                                        ServiceUtil.getErrorMessage(servResult)); 
                            }
                        }
                        numReloaded++;
                    }
                    else {
                        Debug.logWarning("Visual theme " + visualThemeId + 
                                " has no data files to reload from (VT_THEME_DATA_RES resource); skipping; " +
                                "consider updating the theme to specify VT_THEME_DATA_RES resources and " +
                                "performing an initial re-seed", visualThemeId);
                    }
                }
                
                delegator.clearCacheLine("VisualThemeResource");
                delegator.clearCacheLine("VisualTheme");
                
                final String msg = "Reloaded " + numReloaded + "/" + visualThemeIds.size() + " visual theme(s)";
                if (numReloaded >= visualThemeIds.size()) {
                    return ServiceUtil.returnSuccess(msg);
                }
                else {
                    return ServiceUtil.returnFailure(msg);
                }
            }
            else {
                return ServiceUtil.returnSuccess("No visual themes to reload");
            }
        }
        catch(Exception e) {
            final String errorMsg = "Exception trying to reload visual theme(s)";
            Debug.logError(e, errorMsg, module);
            return ServiceUtil.returnError(errorMsg + ": " + e.getMessage());
        }
    }

}
