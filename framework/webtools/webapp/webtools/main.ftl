<#--
This file is subject to the terms and conditions defined in the
files 'LICENSE' and 'NOTICE', which are part of this source
code package.
-->

    <#if !userLogin?has_content>
    <#--
      <div>${uiLabelMap.WebtoolsForSomethingInteresting}.</div>
      <br />
      <div>${uiLabelMap.WebtoolsNoteAntRunInstall}</div>
      <br />
      <div><a href="<@ofbizUrl>checkLogin</@ofbizUrl>" class="button">${uiLabelMap.CommonLogin}</a></div>
    -->     
    <#include "component://common/webcommon/login.ftl"/>
    </#if>

    <#if userLogin?has_content>
    <@alert type="info">${uiLabelMap.WebtoolsNoteAntRunInstall}</@alert>
    <@section>
        <@grid columns=4>
            <li>
              <@pul title=uiLabelMap.WebtoolsCacheDebugTools>
                <@pli><a href="<@ofbizUrl>FindUtilCache</@ofbizUrl>">${uiLabelMap.WebtoolsCacheMaintenance}</a></@pli>
                <@pli><a href="<@ofbizUrl>LogView</@ofbizUrl>">${uiLabelMap.WebtoolsViewLog}</a></@pli>
                <@pli><a href="<@ofbizUrl>ViewComponents</@ofbizUrl>">${uiLabelMap.WebtoolsViewComponents}</a></@pli>
              </@pul>  
            </li>
            <#if security.hasPermission("ARTIFACT_INFO_VIEW", request)>
            <li>
              <@pul title=uiLabelMap.WebtoolsGeneralArtifactInfoTools>
                <@pli><a href="<@ofbizUrl>ViewComponents</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsArtifactInfo}</a></@pli>
                <@pli><a href="<@ofbizUrl>entityref</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReference} - ${uiLabelMap.WebtoolsEntityReferenceInteractiveVersion}</a></@pli>
                <@pli><a href="<@ofbizUrl>ServiceList</@ofbizUrl>">${uiLabelMap.WebtoolsServiceReference}</a></@pli>
              </@pul>
            </li>
            </#if>
            <#if security.hasPermission("LABEL_MANAGER_VIEW", request)>
            <li>
              <@pul title=uiLabelMap.WebtoolsLabelManager>
                <@pli><a href="<@ofbizUrl>SearchLabels</@ofbizUrl>">${uiLabelMap.WebtoolsLabelManager}</a></@pli>
              </@pul>
            </li>
            </#if>
            <#if security.hasPermission("ENTITY_MAINT", request)>
            <li>
                <@pul title=uiLabelMap.WebtoolsEntityEngineTools>
              <@pli><a href="<@ofbizUrl>entitymaint</@ofbizUrl>">${uiLabelMap.WebtoolsEntityDataMaintenance}</a></@pli>
              <@pli><a href="<@ofbizUrl>entityref</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReference} - ${uiLabelMap.WebtoolsEntityReferenceInteractiveVersion}</a></@pli>
              <@pli><a href="<@ofbizUrl>entityref?forstatic=true</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReference} - ${uiLabelMap.WebtoolsEntityReferenceStaticVersion}</a></@pli>
              <@pli><a href="<@ofbizUrl>entityrefReport</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReferencePdf}</a></@pli>
              <@pli><a href="<@ofbizUrl>entitymaint</@ofbizUrl>">${uiLabelMap.WebtoolsEntityDataMaintenance}</a></@pli>
              <@pli><a href="<@ofbizUrl>entityref</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReference} - ${uiLabelMap.WebtoolsEntityReferenceInteractiveVersion}</a></@pli>
              <@pli><a href="<@ofbizUrl>entityref?forstatic=true</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReference} - ${uiLabelMap.WebtoolsEntityReferenceStaticVersion}</a></@pli>
              <@pli><a href="<@ofbizUrl>entityrefReport</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsEntityReferencePdf}</a></@pli>
              <@pli><a href="<@ofbizUrl>EntitySQLProcessor</@ofbizUrl>">${uiLabelMap.PageTitleEntitySQLProcessor}</a></@pli>
              <@pli><a href="<@ofbizUrl>EntitySyncStatus</@ofbizUrl>">${uiLabelMap.WebtoolsEntitySyncStatus}</a></@pli>
              <@pli><a href="<@ofbizUrl>view/ModelInduceFromDb</@ofbizUrl>" target="_blank">${uiLabelMap.WebtoolsInduceModelXMLFromDatabase}</a></@pli>
              <@pli><a href="<@ofbizUrl>EntityEoModelBundle</@ofbizUrl>">${uiLabelMap.WebtoolsExportEntityEoModelBundle}</a></@pli>
              <@pli><a href="<@ofbizUrl>view/checkdb</@ofbizUrl>">${uiLabelMap.WebtoolsCheckUpdateDatabase}</a></@pli>
              <@pli><a href="<@ofbizUrl>ConnectionPoolStatus</@ofbizUrl>">${uiLabelMap.ConnectionPoolStatus}</a></@pli>
              <#-- want to leave these out because they are only working so-so, and cause people more problems that they solve, IMHO
              <@pli><a href="<@ofbizUrl>view/EditEntity</@ofbizUrl>"  target="_blank">Edit Entity Definitions</a></@pli>
              <@pli><a href="<@ofbizUrl>ModelWriter</@ofbizUrl>" target="_blank">Generate Entity Model XML (all in one)</a></@pli>
              <@pli><a href="<@ofbizUrl>ModelWriter?savetofile=true</@ofbizUrl>" target="_blank">Save Entity Model XML to Files</a></@pli>
              -->
              <#-- not working right now anyway
              <@pli><a href="<@ofbizUrl>ModelGroupWriter</@ofbizUrl>" target="_blank">Generate Entity Group XML</a></@pli>
              <@pli><a href="<@ofbizUrl>ModelGroupWriter?savetofile=true</@ofbizUrl>" target="_blank">Save Entity Group XML to File</a></@pli>
              -->
              <#--
              <@pli><a href="<@ofbizUrl>view/tablesMySql</@ofbizUrl>">MySQL Table Creation SQL</a></@pli>
              <@pli><a href="<@ofbizUrl>view/dataMySql</@ofbizUrl>">MySQL Auto Data SQL</a></@pli>
              -->
            </@pul>
            </li>
            </#if>
            <#if security.hasPermission("SERVICE_MAINT", request)>
            <li>
                <@pul title=uiLabelMap.WebtoolsServiceEngineTools>
                  <@pli><a href="<@ofbizUrl>ServiceList</@ofbizUrl>">${uiLabelMap.WebtoolsServiceReference}</a></@pli>
                  <@pli><a href="<@ofbizUrl>scheduleJob</@ofbizUrl>">${uiLabelMap.PageTitleScheduleJob}</a></@pli>
                  <@pli><a href="<@ofbizUrl>runService</@ofbizUrl>">${uiLabelMap.PageTitleRunService}</a></@pli>
                  <@pli><a href="<@ofbizUrl>FindJob</@ofbizUrl>">${uiLabelMap.PageTitleJobList}</a></@pli>
                  <@pli><a href="<@ofbizUrl>threadList</@ofbizUrl>">${uiLabelMap.PageTitleThreadList}</a></@pli>
                  <#-- SCIPIO: 2018-08-28: TODO: REVIEW: JobManagerLock
                  <@pli><a href="<@ofbizUrl>FindJobManagerLock</@ofbizUrl>">${uiLabelMap.PageTitleJobManagerLockList}</a></@pli>-->
                  <@pli><a href="<@ofbizUrl>ServiceLog</@ofbizUrl>">${uiLabelMap.WebtoolsServiceLog}</a></@pli>
                </@pul>
            </li>
            </#if>         
            <#if security.hasPermission("DATAFILE_MAINT", request)>
            <li>
              <@pul title=uiLabelMap.WebtoolsDataFileTools>
                <@pli><a href="<@ofbizUrl>viewdatafile</@ofbizUrl>">${uiLabelMap.WebtoolsWorkWithDataFiles}</a></@pli>
              </@pul>
            </li>
            </#if>
            <li>
            <@pul title=uiLabelMap.WebtoolsMiscSetupTools>
                <#if security.hasPermission("PORTALPAGE_ADMIN", request)>
                <@pli><a href="<@ofbizUrl>FindPortalPage</@ofbizUrl>">${uiLabelMap.WebtoolsAdminPortalPage}</a></@pli>
                <@pli><a href="<@ofbizUrl>FindGeo</@ofbizUrl>">${uiLabelMap.WebtoolsGeoManagement}</a></@pli>
                <@pli><a href="<@ofbizUrl>WebtoolsLayoutDemo</@ofbizUrl>">${uiLabelMap.WebtoolsLayoutDemo}</a></@pli>
                </#if>
                <#if security.hasPermission("ENUM_STATUS_MAINT", request)>
                <#--
                <@pli><a href="<@ofbizUrl>EditEnumerationTypes</@ofbizUrl>">Edit Enumerations</a></@pli>
                <@pli><a href="<@ofbizUrl>EditStatusTypes</@ofbizUrl>">Edit Status Options</a></@pli>
                -->
                </#if>
            </@pul>
            </li>
            <li>
            <@pul title=uiLabelMap.WebtoolsPerformanceTests>
                <@pli><a href="<@ofbizUrl>EntityPerformanceTest</@ofbizUrl>">${uiLabelMap.WebtoolsEntityEngine}</a></@pli>
            </@pul>
            </li>
            <#if security.hasPermission("SERVER_STATS_VIEW", request)>
            <li>
              <@pul title=uiLabelMap.WebtoolsServerHitStatisticsTools>
                    <@pli><a href="<@ofbizUrl>StatsSinceStart</@ofbizUrl>">${uiLabelMap.WebtoolsStatsSinceServerStart}</a></@pli>
              </@pul>
            </li>
            </#if>
            <li>
            <@pul title=uiLabelMap.WebtoolsCertsX509>
                <@pli><a href="<@ofbizUrl>myCertificates</@ofbizUrl>">${uiLabelMap.WebtoolsMyCertificates}</a></@pli>
            </@pul>
            </li>
        </@grid>
    </@section>
    </#if>
