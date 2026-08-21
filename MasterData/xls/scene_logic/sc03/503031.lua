local empty = {}
return
{
  Events = {
    {

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

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 7,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          IsSkip = true,
          Type = 36,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 120,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall2",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
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

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = empty,
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "laser",
          IsRemoveAfterEnter = true,
          IsRemoveForever = true,
          Actions = {
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 12,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 7010401,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 1002,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 7010401,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 1002,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  },
                  {
                    RefreshCondition = 0,
                    Id = 7010403,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 1002,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.5,
              TimeoutKey = "QMwiYjZU"
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
              Timeout = 1.0,
              TimeoutKey = "aFoAEArQ"
            },
            {

              Camera = 1031401,
              IsNewConfig = false,
              IsForceDepressCameraMode = true,
              Type = 11,
              Timeout = 0.0
            },
            {

              PlatName = "plat4",
              IsMove = true,
              Anim = "LaserAnimation4",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "nWsKRsCH"
            },
            {

              PlatName = "plat2",
              IsMove = true,
              Anim = "LaserAnimation2",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "fGIDbKyR"
            },
            {

              PlatName = "plat3",
              IsMove = true,
              Anim = "LaserAnimation3",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "bKUQbRBO"
            },
            {

              PlatName = "plat1",
              IsMove = true,
              Anim = "LaserAnimation1",
              IsAutoSave = true,
              Type = 18,
              Timeout = 5.0,
              TimeoutKey = "FpkmFfAU"
            },
            {

              GroupId = 1031004,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "FygVnACV"
            },
            {

              GroupId = 1031003,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "vgbrJBcu"
            },
            {

              GroupId = 1031002,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "ETfvjXqb"
            },
            {

              GroupId = 1031001,
              Type = 27,
              Timeout = 2.0,
              TimeoutKey = "hBaGvBuV"
            },
            {

              ObjName = "/Root/Level/T1/R3/PlatGroup",
              Visible = true,
              IsAutoSave = true,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              Type = 14,
              Timeout = 0.0
            },
            {

              Type = 61,
              Timeout = 0.0
            },
            {

              Type = 60,
              Timeout = 0.5,
              TimeoutKey = "bzoYzepm"
            },
            {

              Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomWall2",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
              Timeout = 0.0
            },
            {

              Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomPlat",
              Rewind = 0.0,
              IsSaveState = false,
              Type = 56,
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

          Key = "enter",
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 4,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          KeyName = "tp3",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
        },
        {

          Group = 1031001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1031002,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1031003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 1031004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Path = "/Root/Level/T1/future2-3/TL-S3T1/TL-LaserRoomPlat",
          Rewind = 0.0,
          IsSaveState = false,
          Type = 56,
          Timeout = 0.0
        },
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          Camera = 102,
          IsNewConfig = true,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 1.0,
          TimeoutKey = "hvsrKCUh"
        }
      },
      ValidInTower = false,
      Type = 7,
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
  FinishiConditionDict = {
    [ 1 ] = {
      Name = "1.杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 12,
    MonsterInfo = {
      [ 20101501 ] = 8,
      [ 20103201 ] = 4
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}