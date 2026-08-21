local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "qian_dark",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "nightSwitch",
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
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 113,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 113,
      PassCameraIsNewConfig = false,
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
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 2,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17014,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.1,
          TimeoutKey = "EeGekfnI"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 3,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 17015,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "qb2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.1,
          TimeoutKey = "XtKvNJOL"
        },
        {

          ObjName = "SceneObj31705",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_04/Prop_04/sc05_prp_55a_pre (16)/sc05_prp_55a_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_04/Prop_04/sc05_prp_55a_pre (15)/sc05_prp_55a_02_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_04/Prop_04/sc05_prp_55a_pre (17)/sc05_prp_55a_02_mod",
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

      ConditionActions = {
        {

          Key = "Z1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              Target = "0_17015_0",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17015_1",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            },
            {

              Target = "0_17015_2",
              MagicId = 40104404,
              Level = 0,
              Type = 16,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "crystal_clear",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2217804,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              Key = "crystal_clear",
              SyncValType = 2,
              Value = true,
              selectIdx = 2,
              ValidInTower = false,
              IsTmpVariable = false,
              Type = 23,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60e_pre (2)/sc05_prp_60e_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "NWVcOSDg"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60e_pre (2)/collider_01",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "SvUOKcIU"
            },
            {

              ObjName = "/Root/Scene/Zone_04/Collison_04/wall",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "dIFVyuTP"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60a_pre (2)/sc05_prp_60a_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "klOlBUmy"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60a_pre (2)/collider_01",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "yubvrQPj"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60b_pre (1)/sc05_prp_60b_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "ZzojPBHG"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60b_pre (1)/collider_01",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "TEJBblwM"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60d_pre (2)/sc05_prp_60d_mod",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "FBeYCGjB"
            },
            {

              ObjName = "/Root/Change_/Change_Bright/Level/QHW_Bright/sc05_prp_60d_pre (2)/collider_01",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "abDrDNqu"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2217805,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              ObjName = "/GroupCtrlObj/SceneObj31705/sc05_prp_20a_pre (1)",
              Visible = false,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "NDBDtnnB"
            },
            {

              ObjName = "/GroupCtrlObj/SceneObj31705/sc05_prp_20a_pre (3)",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 1.0,
              TimeoutKey = "oJjdTVjr"
            },
            {

              isVictory = true,
              isPopConfirmTips = false,
              Type = 20,
              Timeout = 1.0,
              TimeoutKey = "ctDRVqEA"
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 301721,
          Actions = {
            {

              StoryId = 2217804,
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
            }
          },
          ValidInTower = false
        },
        {

          NPCId = 301722,
          Actions = {
            {

              StoryId = 2217805,
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

      Actions = {
        {

          Direction = 2,
          Type = 51,
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

      EventName = "qb",
      Actions = {
        {

          PosKey = "M1",
          Rotation = 0,
          NPCId = 301721,
          NPCName = "水晶清除",
          Type = 0,
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

      EventName = "qb2",
      Actions = {
        {

          PosKey = "M2",
          Rotation = 0,
          NPCId = 301722,
          NPCName = "路障清除",
          Type = 0,
          Timeout = 0.0
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
  MonsterCountInfo = {
    EventCount = 2,
    MonsterCount = 5,
    MonsterInfo = {
      [ 20204301 ] = 2,
      [ 20204401 ] = 1,
      [ 20204601 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}