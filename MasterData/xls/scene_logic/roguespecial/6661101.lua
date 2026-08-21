local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "retreat_time",
          SyncValType = 1,
          Value = 3.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "set_can_searched",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "max_phase",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_target_num_phase1",
          SyncValType = 1,
          Value = 5.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "time_phase1",
          SyncValType = 1,
          Value = 20.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_target_num_phase2",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "time_phase2",
          SyncValType = 1,
          Value = 17.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "奖励1",
          Type = 19,
          Timeout = 26.5,
          TimeoutKey = "FQcfSRYq"
        },
        {

          Key = "max_target_num_phase3",
          SyncValType = 1,
          Value = 5.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "time_phase3",
          SyncValType = 1,
          Value = 20.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_target_num_phase4",
          SyncValType = 1,
          Value = 0.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "time_phase3",
          SyncValType = 1,
          Value = 17.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "奖励2",
          Type = 19,
          Timeout = 64.0,
          TimeoutKey = "hqHqowDS"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "width",
          SyncValType = 1,
          Value = 4.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "length",
          SyncValType = 1,
          Value = 4.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "gap_time",
          SyncValType = 1,
          Value = 4.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "start_target_num",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "loop_speed",
          SyncValType = 1,
          Value = 10.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "cross_speed",
          SyncValType = 1,
          Value = 10.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Tips = "995",
          Duration = 3.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          Seconds = 75,
          Text = "剩余时间",
          Type = 66,
          Timeout = 1.5,
          TimeoutKey = "ZKvpxVdn"
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 76.5,
          TimeoutKey = "PhgycbrF"
        },
        {

          TaskGroupId = 66611,
          Type = 21,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(125)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/sc03_bld_30b_pre(5)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(103)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(104)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(105)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/sc03_bld_30b_pre(6)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(161)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(162)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(163)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(142)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(143)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/01/sc03_bld_30a_pre(144)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/Building/sc03_bld_37a_pre(4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc03_zone_06/sc03_area_06_pre/sc03_cpn_06_ground_01",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 66611,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 66611,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          Target = "Hero",
          MagicId = 4032098,
          Level = 0,
          Type = 16,
          Timeout = 0.0
        },
        {

          Key = "cancel_born_skill",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 0,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 0,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Level/RogueSpecial/TargetPractice-Grid",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          CustomEventName = "开局过渡",
          Type = 19,
          Timeout = 1.5,
          TimeoutKey = "acYvHdYS"
        },
        {

          GroupId = 6661100,
          Type = 27,
          Timeout = 1.5,
          TimeoutKey = "jsCuLqoe"
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "一排排顺序 测试用",
      Actions = {
        {

          GroupId = 6661101,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661102,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "UYbsVWkv"
        },
        {

          GroupId = 6661103,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "lTBisHer"
        },
        {

          GroupId = 6661104,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "tJsvrCpv"
        },
        {

          GroupId = 6661105,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "zSWdQddh"
        },
        {

          GroupId = 6661106,
          Type = 27,
          Timeout = 5.0,
          TimeoutKey = "SkYymZRU"
        },
        {

          GroupId = 6661107,
          Type = 27,
          Timeout = 6.0,
          TimeoutKey = "RQIpTIkA"
        },
        {

          GroupId = 6661108,
          Type = 27,
          Timeout = 7.0,
          TimeoutKey = "RCusRevT"
        },
        {

          GroupId = 6661109,
          Type = 27,
          Timeout = 8.0,
          TimeoutKey = "CewhfVbb"
        },
        {

          GroupId = 6661110,
          Type = 27,
          Timeout = 9.0,
          TimeoutKey = "VDSebwRP"
        },
        {

          GroupId = 6661111,
          Type = 27,
          Timeout = 10.0,
          TimeoutKey = "rrlpJSju"
        },
        {

          GroupId = 6661112,
          Type = 27,
          Timeout = 11.0,
          TimeoutKey = "yVrZwLgv"
        },
        {

          GroupId = 6661113,
          Type = 27,
          Timeout = 12.0,
          TimeoutKey = "FuTDNfNx"
        },
        {

          GroupId = 6661114,
          Type = 27,
          Timeout = 13.0,
          TimeoutKey = "DhOiZPwc"
        },
        {

          GroupId = 6661115,
          Type = 27,
          Timeout = 14.0,
          TimeoutKey = "MdJwJjFA"
        },
        {

          GroupId = 6661116,
          Type = 27,
          Timeout = 15.0,
          TimeoutKey = "kziAoDVK"
        },
        {

          CustomEventName = "一排排顺序 测试用",
          Type = 19,
          Timeout = 16.0,
          TimeoutKey = "JbpIDufZ"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "奖励1",
      Actions = {
        {

          Key = "retreat_time",
          SyncValType = 1,
          Value = 7.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 6661101,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661102,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "hWPgEqWP"
        },
        {

          GroupId = 6661105,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "PqTqfYXS"
        },
        {

          GroupId = 6661106,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "LSaOpnyn"
        },
        {

          GroupId = 6661111,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "YOtGecIX"
        },
        {

          GroupId = 6661112,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "uFUdnaFg"
        },
        {

          GroupId = 6661115,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "mfGCOfAL"
        },
        {

          GroupId = 6661116,
          Type = 27,
          Timeout = 0.0,
          TimeoutKey = "RFIAhmGC"
        },
        {

          GroupId = 6661103,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "ILqSaHJY"
        },
        {

          GroupId = 6661104,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "NuYZkPuv"
        },
        {

          GroupId = 6661107,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "ARjPgpul"
        },
        {

          GroupId = 6661108,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "LEpGsorE"
        },
        {

          GroupId = 6661109,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "mTeyfTkr"
        },
        {

          GroupId = 6661110,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "lCxNBGdL"
        },
        {

          GroupId = 6661113,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "xAIaPzMC"
        },
        {

          GroupId = 6661114,
          Type = 27,
          Timeout = 7.5,
          TimeoutKey = "RnBQxazT"
        },
        {

          Key = "retreat_time",
          SyncValType = 1,
          Value = 3.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 8.0,
          TimeoutKey = "ozJIBZWK"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "奖励2",
      Actions = {
        {

          Key = "retreat_time",
          SyncValType = 1,
          Value = 7.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 6661101,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 6661102,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "cIzuqqxX"
        },
        {

          GroupId = 6661105,
          Type = 27,
          Timeout = 1.0,
          TimeoutKey = "IYwLXaTD"
        },
        {

          GroupId = 6661103,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "MPKauEZG"
        },
        {

          GroupId = 6661106,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "DwiwZyPg"
        },
        {

          GroupId = 6661109,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "bjRdUSVR"
        },
        {

          GroupId = 6661104,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "asodpiio"
        },
        {

          GroupId = 6661107,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "YWYndPhn"
        },
        {

          GroupId = 6661110,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "ddRyllgH"
        },
        {

          GroupId = 6661113,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "AhpzGucn"
        },
        {

          GroupId = 6661114,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "pwKOHGNf"
        },
        {

          GroupId = 6661108,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "MQUIvGDK"
        },
        {

          GroupId = 6661111,
          Type = 27,
          Timeout = 4.0,
          TimeoutKey = "ZlTZUyrg"
        },
        {

          GroupId = 6661112,
          Type = 27,
          Timeout = 5.0,
          TimeoutKey = "xGtLmggT"
        },
        {

          GroupId = 6661115,
          Type = 27,
          Timeout = 5.0,
          TimeoutKey = "jfQpmCLu"
        },
        {

          GroupId = 6661116,
          Type = 27,
          Timeout = 6.0,
          TimeoutKey = "UiZXDzFx"
        },
        {

          Key = "retreat_time",
          SyncValType = 1,
          Value = 3.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 7.0,
          TimeoutKey = "vdTSrqXR"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "开局过渡",
      Actions = {
        {

          GroupId = 6661106,
          Type = 27,
          Timeout = 1.5,
          TimeoutKey = "kqVxKqWK"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterLockEnemyCount = 0,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true
  },
  FinishiConditionDict = empty,
  mDefaultStartTime = false,
  mDefaultEndTime = false
}