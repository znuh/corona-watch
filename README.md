# corona-watch
monitoring the german corona-warn-app server data

1) git submodule init
2) git submodule update
3) install the following lua packages (e.g. via luarocks): lua-cjson, lua-protobuf
 
* app_config.lua fetches the most recent app config from server and compares against previously fetched config

example:
```
> lua app_config.lua 
> cat app_config/1592344486.txt
    appVersion.android.latest.major= 0
    appVersion.android.latest.minor= 8
    appVersion.android.latest.patch= 3
    appVersion.android.min.major= 0
    appVersion.android.min.minor= 8
    appVersion.android.min.patch= 0
    appVersion.ios.latest.major= 0
    appVersion.ios.latest.minor= 8
    appVersion.ios.latest.patch= 2
    appVersion.ios.min.major= 0
    appVersion.ios.min.minor= 5
    appVersion.ios.min.patch= 0
  attenuationDuration.defaultBucketOffset= 0
  attenuationDuration.riskScoreNormalizationDivisor= 25
   attenuationDuration.thresholds.lower= 55
   attenuationDuration.thresholds.upper= 63
   attenuationDuration.weights.high= 0
   attenuationDuration.weights.low= 1
   attenuationDuration.weights.mid= 0.5
   exposureConfig.attenuation.gt_10_le_15_dbm= LOWEST
   exposureConfig.attenuation.gt_15_le_27_dbm= LOWEST
   exposureConfig.attenuation.gt_27_le_33_dbm= LOWEST
   exposureConfig.attenuation.gt_33_le_51_dbm= LOWEST
   exposureConfig.attenuation.gt_51_le_63_dbm= LOWEST
   exposureConfig.attenuation.gt_63_le_73_dbm= LOWEST
   exposureConfig.attenuation.gt_73_dbm= INVALID
   exposureConfig.attenuation.lt_10_dbm= LOWEST
  exposureConfig.attenuationWeight= 50
   exposureConfig.daysSinceLastExposure.ge_0_lt_2_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_10_lt_12_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_12_lt_14_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_14_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_2_lt_4_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_4_lt_6_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_6_lt_8_days= MEDIUM_HIGH
   exposureConfig.daysSinceLastExposure.ge_8_lt_10_days= MEDIUM_HIGH
  exposureConfig.daysWeight= 20
   exposureConfig.duration.eq_0_min= INVALID
   exposureConfig.duration.gt_0_le_5_min= INVALID
   exposureConfig.duration.gt_10_le_15_min= LOWEST
   exposureConfig.duration.gt_15_le_20_min= LOWEST
   exposureConfig.duration.gt_20_le_25_min= LOWEST
   exposureConfig.duration.gt_25_le_30_min= LOWEST
   exposureConfig.duration.gt_30_min= LOWEST
   exposureConfig.duration.gt_5_le_10_min= INVALID
  exposureConfig.durationWeight= 50
   exposureConfig.transmission.appDefined_1= LOWEST
   exposureConfig.transmission.appDefined_2= LOW
   exposureConfig.transmission.appDefined_3= LOW_MEDIUM
   exposureConfig.transmission.appDefined_4= MEDIUM
   exposureConfig.transmission.appDefined_5= MEDIUM_HIGH
   exposureConfig.transmission.appDefined_6= HIGH
   exposureConfig.transmission.appDefined_7= VERY_HIGH
   exposureConfig.transmission.appDefined_8= HIGHEST
  exposureConfig.transmissionWeight= 50
 minRiskScore= 11
    riskScoreClasses.risk_classes.1.label= LOW
    riskScoreClasses.risk_classes.1.max= 15
    riskScoreClasses.risk_classes.1.min= 0
    riskScoreClasses.risk_classes.1.url= https://www.coronawarn.app
    riskScoreClasses.risk_classes.2.label= HIGH
    riskScoreClasses.risk_classes.2.max= 72
    riskScoreClasses.risk_classes.2.min= 15
    riskScoreClasses.risk_classes.2.url= https://www.coronawarn.app
> lua app_config.lua 
config unchanged
```

* diagnosis_keys.lua is still WIP - no keys on the server yet
