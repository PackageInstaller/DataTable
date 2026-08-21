local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 10,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 1,
                Id = 101511,
                param = 1,
                Name = "剩余",
                Timeout = 0.0,
                AIGroupId = 100,
                AIGroup = 1,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 101512,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 100,
                AIGroup = 1,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 5.0,
          TimeoutKey = "OlNVKAdr"
        },
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          SkillLevel = 2,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          TipsId = 20151,
          Visible = true,
          Flip = true,
          Type = 15,
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

      NoPassCamera = 101501,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = false,
      PassCamera = 101501,
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

          Type = 48,
          Timeout = 5.0,
          TimeoutKey = "hXvSXZrM"
        },
        {

          Enable = true,
          Type = 120,
          Timeout = 5.0,
          TimeoutKey = "fuTGwIzH"
        },
        {

          ObjName = "/Root/LevelObj/Fx_1001008_henji",
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

      Actions = empty,
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          GroupId = 20151,
          Type = 42,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 18,
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
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 10,
    MonsterInfo = {
      [ 20101501 ] = 5,
      [ 20101401 ] = 3,
      [ 20101201 ] = 2
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = true
}