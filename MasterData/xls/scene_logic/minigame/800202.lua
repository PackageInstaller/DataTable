local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupId = 800201,
          Type = 27,
          Timeout = 0.1,
          TimeoutKey = "ZJvHGvFN"
        },
        {

          GroupId = 800202,
          Type = 27,
          Timeout = 0.5,
          TimeoutKey = "TBmXDzQx"
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

          Key = "end_time",
          SyncValType = 1,
          Value = 45.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Seconds = 45,
          Text = "限时清怪",
          EventName = "时间结束",
          Type = 66,
          Timeout = 1.0,
          TimeoutKey = "bBnsNYZb"
        },
        {

          GroupId = 800202,
          Type = 42,
          Timeout = 1.5,
          TimeoutKey = "VoizgEph"
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
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = false,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
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

      Actions = {
        {

          Key = "create_gap_time",
          SyncValType = 1,
          Value = 0.5,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "point_gap_time",
          SyncValType = 1,
          Value = 2.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "start_enemy_amout",
          SyncValType = 1,
          Value = 3.0,
          selectIdx = 1,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "max_enemy_amount",
          SyncValType = 1,
          Value = 6.0,
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

          Key = "no_warning",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          Key = "item_cd",
          SyncValType = 1,
          Value = 12.0,
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

          TimelineName = "timeline_BattingBoomer",
          Fadein = 0.0,
          Fadeout = 2.0,
          IsCanSkip = false,
          NotPauseLua = true,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = true,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.7,
          TimeoutKey = "jIGJAyzF"
        },
        {

          FadeIn = 0.0,
          Hold = 1.0,
          FadeOut = 0.0,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_wall_BattingBommer",
          IsPlay = true,
          Type = 110,
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

          ObjName = "/Root/LevelObj/RogueSpecial/BattingBoomer",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_0405/prop/sc02_prp_15a_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc02_zone_0405/prop/sc02_prp_15c_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/RogueSpecial/BattingBoomer/Column2",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/RogueSpecial/BattingBoomer/Column1",
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

      Actions = {
        {

          TimelineName = "timeline_BattingBoomer",
          Type = 7,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_wall_BattingBommer",
          IsPlay = false,
          Type = 110,
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

      Actions = {
        {

          UIName = "fight",
          ObjectName = "Btn_skill8",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill4",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill5",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Btn_skill7",
          IsShow = true,
          Type = 32,
          Timeout = 0.0
        },
        {

          UIName = "fight",
          ObjectName = "Bar",
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

      EventName = "时间结束",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.5,
          TimeoutKey = "YEtqTvsT"
        },
        {

          Tips = "984",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
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
  mDefaultStartTime = false,
  mDefaultEndTime = false
}