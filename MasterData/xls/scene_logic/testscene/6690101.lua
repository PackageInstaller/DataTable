local empty = {}
return
{
  Events = {
    {

      NoPassCamera = 111,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 111,
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

      ConditionActions = {
        {

          Key = "overlap1-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "进入区域overlap1-1",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "overlap1-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "进入区域overlap1-2",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "overlap2-1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "进入区域overlap2-1",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "overlap2-2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Tips = "进入区域overlap2-2",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
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

          Key = "overlap1-1",
          Actions = {
            {

              Tips = "离开区域overlap1-1",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "overlap1-2",
          Actions = {
            {

              Tips = "离开区域overlap1-2",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "overlap2-1",
          Actions = {
            {

              Tips = "离开区域overlap2-1",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "overlap2-2",
          Actions = {
            {

              Tips = "离开区域overlap2-2",
              Duration = 2.0,
              IsOpen = true,
              Type = 94,
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
  mDefaultStartTime = true,
  mDefaultEndTime = true
}