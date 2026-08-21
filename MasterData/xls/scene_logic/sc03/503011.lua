return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "/Root/Level/T1/R1/sc03_01_anim_01",
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

          Tips = "1009",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 120,
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

      NoPassCamera = 1031001,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 1031001,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          KeyName = "drop",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        }
      },
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

          Key = "CAM1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              Type = 71,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 3,
                MonsterCount = 17,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 7010101,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 7010102,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 7010102,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  }
                },
              },
              Type = 8,
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

      Actions = {
        {

          Type = 12,
          Timeout = 0.0
        },
        {

          KeyName = "tp2",
          IsOpen = true,
          IsContinue = false,
          Type = 70,
          Timeout = 0.0
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
    MonsterCount = 17,
    MonsterInfo = {
      [ 20101501 ] = 12,
      [ 20101401 ] = 5
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}