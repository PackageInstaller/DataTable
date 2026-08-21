local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RandomCount = 1,
          RandomMonsterCfgList = {
            {
              Weight = 100,
              MonsterLockEnemyCount = 0,
              MonsterGroupId = 0,
              MonsterWave = 2,
              MonsterCount = 7,
              SendWave = false,
              WaveStyle = 0,
              EndPerform = true,
              Conditions = {
                {
                  RefreshCondition = 0,
                  Id = 21101,
                  param = 0,
                  Name = "全部杀死",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                },
                {
                  RefreshCondition = 0,
                  Id = 21102,
                  param = 0,
                  Name = "全部杀死",
                  CustomEventName = "1",
                  Timeout = 0.0,
                  AIGroupId = 0,
                  AIGroup = 0,
                  AIDiffcultyTag = 0
                }
              },
            }
          },
          Type = 84,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          MagicId = 100010108,
          Level = 0,
          Type = 16,
          Timeout = 1.0,
          TimeoutKey = "nXDlItyE"
        },
        {

          Tips = "985",
          Duration = 7.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.0,
          TimeoutKey = "MiHuveqW"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
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

      ConditionActions = {
        {

          GroupId = 1002,
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
      Type = 8,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "1",
      Actions = {
        {

          GroupId = 1002,
          Type = 42,
          Timeout = 1.0,
          TimeoutKey = "BBFZFQqY"
        },
        {

          Type = 22,
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
    EventCount = 1,
    MonsterCount = 0,
    MonsterInfo = empty,
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}