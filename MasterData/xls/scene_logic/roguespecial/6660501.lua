local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 1031401,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031401,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/Plat1_",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/Plat2_",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          IsOpen = false,
          Type = 79,
          Timeout = 0.0
        },
        {

          IsSkip = false,
          Type = 36,
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

          Tips = "991",
          Duration = 3.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/LaserRoomPlatform",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          PosKey = "center",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 0.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          CustomEventName = "机关开启",
          Type = 19,
          Timeout = 0.0,
          TimeoutKey = "kjMdxsHX"
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

          TimelineName = "laser_cam",
          Type = 7,
          Timeout = 0.0
        },
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          Group = 1031004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1031003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1031002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1031001,
          Type = 65,
          Timeout = 0.0
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          Camera = 1031001,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "fjTvTaDM"
        },
        {

          Type = 34,
          Timeout = 0.0
        },
        {

          Type = 34,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "endend",
      ValidInTower = true,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "end",
      Actions = {
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 1.5,
          TimeoutKey = "clvbtUMk"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "机关开启",
      Actions = {
        {

          ObjName = "/Root/Level/T1/R3/PlatGroup",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          GroupId = 1031001,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "NHovhmNv"
        },
        {

          GroupId = 1031002,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "dTFTzVuf"
        },
        {

          GroupId = 1031003,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "vOhKnJBs"
        },
        {

          GroupId = 1031004,
          Type = 27,
          Timeout = 2.0,
          TimeoutKey = "tiQxBfFr"
        },
        {

          PlatName = "plat1",
          IsMove = true,
          Anim = "LaserAnimation1",
          IsAutoSave = true,
          Type = 18,
          Timeout = 5.0,
          TimeoutKey = "KqlIBeZA"
        },
        {

          PlatName = "plat3",
          IsMove = true,
          Anim = "LaserAnimation3",
          IsAutoSave = true,
          Type = 18,
          Timeout = 5.0,
          TimeoutKey = "VhMZoody"
        },
        {

          PlatName = "plat2",
          IsMove = true,
          Anim = "LaserAnimation2",
          IsAutoSave = true,
          Type = 18,
          Timeout = 5.0,
          TimeoutKey = "dMCxceRU"
        },
        {

          PlatName = "plat4",
          IsMove = true,
          Anim = "LaserAnimation4",
          IsAutoSave = true,
          Type = 18,
          Timeout = 5.0,
          TimeoutKey = "SyuUoopk"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "2",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 100310401,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "end",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 32.0,
          TimeoutKey = "crwQVfWK"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          ObjName = "/Root/Scene/sc03_zone_04/sc03_area_04_pre/sc03_area_04_11_mod",
          Visible = true,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/T1/R3/PlatGroup",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "laser_cam",
          Type = 7,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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
    MonsterCount = 1,
    MonsterInfo = {
      [ 20101301 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}