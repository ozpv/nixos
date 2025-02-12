{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    
    profiles.ozpv = {
      userChrome = '' 
        :root[tabsintitlebar][sizemode="normal"]{
          --uc-window-drag-space-width: 24px;
        }
        :root[uidensity="compact"]{
          --tab-block-margin: 2px !important;
        }
        
        #navigator-toolbox{
          --uc-navigationbar-width: 40vw;
          --uc-toolbar-height: 40px;
          --uc-urlbar-min-width: 50vw;
        }
        
        #scrollbutton-up,
        #scrollbutton-down{ border-block-width: 2px !important; }
        
        :root[uidensity="compact"] #navigator-toolbox{ --uc-toolbar-height: 34px; }
        :root[uidensity="touch"] #navigator-toolbox{ --uc-toolbar-height: 44px; }
        
        @media screen and (max-width: 1500px){
            #urlbar-container{
              min-width: 300px !important;
              flex-shrink: 1 !important;
            }
        }
        
        #TabsToolbar{
          margin-left: var(--uc-navigationbar-width);
          --tabs-navbar-shadow-size: 0px;
        }
        #tabbrowser-tabs{
          --tab-min-height: calc(var(--uc-toolbar-height) - 2 * var(--tab-block-margin,0px)) !important;
        }
        
        .titlebar-spacer[type="pre-tabs"]{ display: none }
        
        #navigator-toolbox > #nav-bar{
          margin-right:calc(100vw - var(--uc-navigationbar-width));
          margin-top: calc(0px - var(--uc-toolbar-height));
        }
        
        :root[tabsintitlebar="true"] #nav-bar{ padding-left: var(--uc-window-drag-space-width) !important }
        
        @media (-moz-gtk-csd-reversed-placement),
               (-moz-platform: macos){
          .titlebar-buttonbox-container{
            position: fixed;
            display: flex;
            left: 0px;
            z-index: 3;
            height: var(--uc-toolbar-height);
            align-items: center
          }
          :root[tabsintitlebar="true"] #nav-bar{ padding-inline: calc(var(--uc-window-drag-space-width,0px) + 84px) 0px !important; }
        }
        @media (-moz-platform: macos){
          :root[tabsintitlebar="true"] #nav-bar{ padding-inline: calc(var(--uc-window-drag-space-width,0px) + 72px) 0px !important; }
        }
        
        .tab-close-button{ margin-top: 0 !important }
        
        #urlbar[open]:focus-within{ min-width: var(--uc-urlbar-min-width,none) !important; }
        
        #urlbar-container:not(:hover) .urlbar-history-dropmarker{ margin-inline-start: -28px; }
        
        #customization-panelWrapper > .panel-arrowbox > .panel-arrow{ margin-inline-end: initial !important; }
      '';

      settings = {
        # enable userChrome.css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # settings that might actually break things...
        "webgl.disabled" = true;
        "webgl.renderer-string-override" = " ";
        "webgl.vendor-string-override" = " ";
        "dom.disable_open_during_load" = true;
        "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";
        # "dom.popup_allowed_events" = "change click dblclick auxclick mousedown mouseup pointerdown pointerup notificationclick reset submit touchend contextmenu";

        "app.normandy.api_url" = "";
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "beacon.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.aboutConfig.showWarning" = false;
        "browser.cache.offline.enable" = false;
        "browser.contentblocking.category" = "strict";
        "browser.crashReports.unsubmittedCheck.autoSubmit" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "browser.disableResetPrompt" = true;
        "browser.fixup.alternate.enabled" = false;
        "browser.formfill.enable" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.enabled" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.ping-centre.telemetry" = false;
        "browser.region.network.url" = "";
        "browser.region.update.enabled" = false;
        "browser.safebrowsing.appRepURL" = "";
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.provider.google4.gethashURL" = "";
        "browser.safebrowsing.provider.google4.updateURL" = "";
        "browser.safebrowsing.provider.google.gethashURL" = "";
        "browser.safebrowsing.provider.google.updateURL" = "";
        "browser.search.suggest.enabled" = false;
        "browser.selfsupport.url" = "";
        "browser.send_pings" = false;
        "browser.sessionstore.privacy_level" = 0;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.startup.page" = 0;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.tabs.firefox-view" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.quicksuggest.scenario" = "history";
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.urlbar.trimURLs" = false;
        "browser.display.use_system_colors" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.startup.blankWindow" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "device.sensors.ambientLight.enabled" = false;
        "device.sensors.enabled" = false;
        "device.sensors.motion.enabled" = false;
        "device.sensors.orientation.enabled" = false;
        "device.sensors.proximity.enabled" = false;
        "dom.battery.enabled" = false;
        "dom.event.clipboardevents.enabled" = false;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "dom.webaudio.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "experiments.supported" = false;
        "extensions.blocklist.enabled" = false;
        "extensions.enabledScopes" = 5;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.available" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.greasemonkey.stats.optedin" = false;
        "extensions.greasemonkey.stats.url" = "";
        "extensions.pocket.enabled" = false;
        "extensions.Screenshots.disabled" = true;
        "extensions.shield-recipe-client.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "extensions.webservice.discoverURL" = "";
        "extensions.webextensions.restrictedDomains" = "";
        "extensions.postDownloadThirdPartyPrompt" = false;
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocat";
        "geo.provider.ms-windows-location" = false;
        "geo.provider.use_gpsd" = false;
        "geo.provider.use_geoclue" = false;
        "intl.accept_languages" = "en-US, en";
        "javascript.use_us_english_locale" = true;
        "keyword.enabled" = true;
        "media.autoplay.default" = 5;
        "media.autoplay.enabled" = false;
        "media.eme.enabled" = false;
        "media.gmp-widevinecdm.enabled" = false;
        "media.navigator.enabled" = true;
        "media.peerconnection.enabled" = false;
        "media.peerconnection.ice.proxy_only_if_behind_prox" = true;
        "media.peerconnection.ice.default_address_only" = true;
        "media.peerconnection.ice.no_host" = true;
        "media.video_stats.enabled" = false;
        "network.IDN_show_punycode" = true;
        "network.allow-experiments" = false;
        "network.captive-portal-service.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "network.cookie.lifetimePolicy" = 2;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.file.disable_unc_paths" = true;
        "network.gio.supported-protocols" = "";
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "network.http.referer.spoofSource" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.prefetch-next" = false;
        "network.trr.mode" = 5;
        "pdfjs.enableScripting" = false;
        "permissions.manager.defaultsUrl" = "";
        "privacy.sanitize.sanitizeOnShutdown" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.sitesettings" = true;
        "privacy.sanitize.timeSpan" = 0;
        "privacy.donottrackheader.enabled" = true;
        "privacy.donottrackheader.value" = 1;
        "privacy.firstparty.isolate" = true;
        "privacy.partition.serviceWorkers" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
        "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = true;
        "privacy.query_stripping" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "privacy.window.maxInnerWidth" = 1600;
        "privacy.window.maxInnerHeight" = 900;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "security.ssl.disable_session_identifiers" = true;
        "services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
        "signon.autofillForms" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.cachedClientID" = "";
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
      };
    };
  };
}
