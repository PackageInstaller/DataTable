local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Intensity = 0.075,
          Type = 105,
          Timeout = 0.0
        },
        {

          StoryId = 3220306,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = false,
          IsSettleStory = false,
          Type = 10,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 14,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 20006,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 20007,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.5,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 20008,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear",
                Timeout = 0.5,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.5,
          TimeoutKey = "ETNRvAQu"
        },
        {

          GroupID = 1,
          Type = 86,
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

          ObjName = "Level/Level_02/320/32003/3200305",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04b/prop/sc06_prop_04_pre (8)/sc06_prop_09_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04b/prop/sc06_prop_04_pre (13)/sc06_prop_09_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_04/sc06_area_04b/prop/sc06_prop_04_pre (14)/sc06_prop_09_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          mIdx = 2,
          mVisible = true,
          Type = 89,
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

      NoPassCamera = 32001,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 32001,
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

      ConditionActions = {
        {

          Key = "camera",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "guide",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              PosKey = "interact",
              IsOpen = true,
              CameraStyle = 1,
              Duration = 2.0,
              StopLuaScript = false,
              BackToDefault = true,
              HideUI = false,
              HasOTSConfig = true,
              OTSCameraStyle = 0,
              OTSDuration = 2.0,
              Type = 62,
              Timeout = 0.0
            },
            {

              StoryId = 3220307,
              EnableBlackFade = false,
              DelayDestroy = false,
              PlayFadeInTime = 0.5,
              PlayStayTime = 0.5,
              PlayFadeOutTime = 0.5,
              StopFadeInTime = 0.5,
              StopStayTime = 0.5,
              StopFadeOutTime = 0.5,
              NoSkipStory = false,
              IsSettleStory = false,
              Type = 10,
              Timeout = 0.5,
              TimeoutKey = "ieRoSPWZ"
            },
            {

              PosKey = "interact",
              Rotation = 0,
              NPCId = 302011,
              NPCName = "接水管",
              Type = 0,
              Timeout = 0.5,
              TimeoutKey = "qmsUfgRe"
            },
            {

              KeyName = "interact",
              IsOpen = true,
              IsContinue = false,
              Type = 70,
              Timeout = 0.5,
              TimeoutKey = "jFNMGfmn"
            },
            {

              TaskId = 3200304,
              Type = 5,
              Timeout = 0.5,
              TimeoutKey = "MHutwgkT"
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 32001,
              IsNewConfig = true,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 302011,
          Actions = {
            {

              ObjName = "Level/Level_02/320/32003/3200305/ElectricBox/1/electricBox_warning",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/ElectricBox/1/electricBox_normal",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.1,
              TimeoutKey = "XhQjWuzL"
            },
            {

              TimelineName = "timeline_320030501",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = true,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.5,
              Hold = 0.5,
              BlackOut = 0.5,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 1.5,
              TimeoutKey = "vPKNmnfh"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/4/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.5,
              TimeoutKey = "mhGyoMCq"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/3/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.25,
              TimeoutKey = "xtqufnmz"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/2/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 3.0,
              TimeoutKey = "ccASfwcD"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/1/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 3.75,
              TimeoutKey = "QbxjKmvv"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/5/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 3.75,
              TimeoutKey = "rLMVdDeo"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/6/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 3.75,
              TimeoutKey = "wBnTElST"
            },
            {

              CustomEventName = "雾气减弱",
              Type = 19,
              Timeout = 2.0,
              TimeoutKey = "wQxHeDep"
            },
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              TaskId = 3200305,
              Type = 5,
              Timeout = 0.0
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/3-2/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 2.25,
              TimeoutKey = "ckMTfMEl"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/2-2/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 3.0,
              TimeoutKey = "SdrRrsoB"
            },
            {

              ObjName = "Level/Level_02/320/32003/3200305/Lamp/1-2/lamp_switch_on",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 3.75,
              TimeoutKey = "yuJNPGOu"
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "雾气减弱",
      Actions = {
        {

          Intensity = 0.025,
          Type = 105,
          Timeout = 2.0,
          TimeoutKey = "hQKfKDqM"
        },
        {

          Intensity = 0.0275,
          Type = 105,
          Timeout = 1.9,
          TimeoutKey = "iDJxsmHl"
        },
        {

          Intensity = 0.03,
          Type = 105,
          Timeout = 1.8,
          TimeoutKey = "cGsFIAOk"
        },
        {

          Intensity = 0.0325,
          Type = 105,
          Timeout = 1.7,
          TimeoutKey = "AYaaOmgR"
        },
        {

          Intensity = 0.035,
          Type = 105,
          Timeout = 1.6,
          TimeoutKey = "meaaHWzp"
        },
        {

          Intensity = 0.0375,
          Type = 105,
          Timeout = 1.5,
          TimeoutKey = "APKWsCJp"
        },
        {

          Intensity = 0.04,
          Type = 105,
          Timeout = 1.4,
          TimeoutKey = "HWueRxeP"
        },
        {

          Intensity = 0.0425,
          Type = 105,
          Timeout = 1.3,
          TimeoutKey = "JTohlqFI"
        },
        {

          Intensity = 0.045,
          Type = 105,
          Timeout = 1.2,
          TimeoutKey = "NPZwiPPV"
        },
        {

          Intensity = 0.0475,
          Type = 105,
          Timeout = 1.1,
          TimeoutKey = "OfYyJEiQ"
        },
        {

          Intensity = 0.05,
          Type = 105,
          Timeout = 1.0,
          TimeoutKey = "NbFYBIRx"
        },
        {

          Intensity = 0.0525,
          Type = 105,
          Timeout = 0.9,
          TimeoutKey = "GiZSSQEA"
        },
        {

          Intensity = 0.055,
          Type = 105,
          Timeout = 0.8,
          TimeoutKey = "PcvSiqTH"
        },
        {

          Intensity = 0.0575,
          Type = 105,
          Timeout = 0.7,
          TimeoutKey = "UOMxLTlK"
        },
        {

          Intensity = 0.06,
          Type = 105,
          Timeout = 0.6,
          TimeoutKey = "PQyivnDY"
        },
        {

          Intensity = 0.0625,
          Type = 105,
          Timeout = 0.5,
          TimeoutKey = "WpqQdNCg"
        },
        {

          Intensity = 0.065,
          Type = 105,
          Timeout = 0.4,
          TimeoutKey = "RPCCsYQT"
        },
        {

          Intensity = 0.0675,
          Type = 105,
          Timeout = 0.3,
          TimeoutKey = "pWVcSjCN"
        },
        {

          Intensity = 0.07,
          Type = 105,
          Timeout = 0.2,
          TimeoutKey = "eshWAIJj"
        },
        {

          Intensity = 0.0725,
          Type = 105,
          Timeout = 0.1,
          TimeoutKey = "sEVdLUoQ"
        },
        {

          Intensity = 0.075,
          Type = 105,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          GroupID = 1,
          Type = 87,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          TimelineName = "timeline_320030501",
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 10,
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
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 14,
    MonsterInfo = {
      [ 20104301 ] = 8,
      [ 20104601 ] = 5,
      [ 20104401 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}