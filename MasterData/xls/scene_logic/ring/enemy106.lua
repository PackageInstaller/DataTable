local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Camera = 20108101,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
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
            WallObjPath = "emptywall",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 21401,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        },
        {

          NPCId = 50008,
          NPCName = "重铸机关",
          Type = 1,
          Timeout = 0.0
        },
        {

          SkillLevel = 3,
          TowerValid = false,
          Type = 45,
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

      NoPassCamera = 20108101,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 20108101,
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

          Point = "center",
          Type = 3,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/12_WZSQ/sc01_area_12/center/Prop/12_ position(2)/sc01_prp_29a_pre(2)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 1,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/LevelObj/air_block_obj",
          Visible = true,
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear",
      Actions = {
        {

          Target = "God",
          MagicId = 200110601,
          Level = 0,
          Type = 16,
          Timeout = 2.0,
          TimeoutKey = "kBIiUXWl"
        },
        {

          KeyName = "tp1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 2.0,
          TimeoutKey = "bCcBerpZ"
        },
        {

          PosKey = "center",
          Rotation = 0,
          NPCId = 50008,
          NPCName = "重铸机关",
          Type = 0,
          Timeout = 2.0,
          TimeoutKey = "yueFahqH"
        },
        {

          Key = "clear",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = false,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 2.0,
          TimeoutKey = "KRJdtBXX"
        }
      },
      FinishMarkVariable = "clear",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "victory",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              isVictory = true,
              isPopConfirmTips = true,
              tipsValue = "161",
              Type = 20,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "clear",
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
      [ 2010310100 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}