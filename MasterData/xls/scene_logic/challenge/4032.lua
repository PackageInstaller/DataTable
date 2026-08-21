local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Key = "on",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          StatisticsIndex = 1,
          StatisticsType = 0,
          ManualCount = 50,
          FinishNotAdd = true,
          ChangeRoomReset = true,
          EventName = "qb",
          UnitIdStr = "",
          Type = 99,
          Timeout = 0.0
        },
        {

          Enable = true,
          Type = 120,
          Timeout = 0.0
        },
        {

          Type = 49,
          Timeout = 0.0
        },
        {

          CustomEventName = "start",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "fSzrOEQY"
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          Tips = "962",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 1.0,
          TimeoutKey = "wGTPcNNH"
        },
        {

          ObjName = "/Root/Change_/Change_Bright/Zone_04/wall (3)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Change_/Change_Bright/Zone_04/wall (4)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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

      EventName = "m2",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032002,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m3",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "win2",
      Actions = {
        {

          Key = "win2",
          AddType = 0,
          Type = 115,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "p2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "m3",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032003,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m1",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong2",
      Actions = {
        {

          GroupId = 403203,
          Type = 27,
          Timeout = 15.0,
          TimeoutKey = "KpJMrsrr"
        },
        {

          CustomEventName = "chong1",
          Type = 19,
          Timeout = 15.0,
          TimeoutKey = "EUHWcVZN"
        },
        {

          Group = 403203,
          Type = 65,
          Timeout = 14.5,
          TimeoutKey = "rhfamSKO"
        },
        {

          Tips = "963",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 13.0,
          TimeoutKey = "hXNbYgFf"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m5",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032005,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m6",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m7",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032007,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m8",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m8",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032008,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m9",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "chong1",
      Actions = {
        {

          GroupId = 403203,
          Type = 27,
          Timeout = 15.0,
          TimeoutKey = "qmWFNGjv"
        },
        {

          CustomEventName = "chong2",
          Type = 19,
          Timeout = 15.0,
          TimeoutKey = "IYVVWgUX"
        },
        {

          Group = 403203,
          Type = 65,
          Timeout = 14.5,
          TimeoutKey = "KrjuqVQv"
        },
        {

          Tips = "963",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 13.0,
          TimeoutKey = "XRIWYYKU"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m1",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032001,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m6",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032006,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m4",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m10",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032010,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m11",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "m11",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032011,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m7",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "start",
      Actions = {
        {

          Type = 48,
          Timeout = 0.0
        },
        {

          CustomEventName = "chong1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m1",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m2",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m3",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m4",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m5",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m6",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m7",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "m10",
          Type = 19,
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

      EventName = "m4",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032004,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m5",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "qb",
      Actions = {
        {

          Key = "on",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          Group = 403203,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032001,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032003,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032004,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032005,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032006,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032007,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032008,
          Type = 65,
          Timeout = 0.0
        },
        {

          Group = 4032002,
          Type = 65,
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

      EventName = "m9",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 4032009,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "m10",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "on",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Target = "Hero",
          MagicId = 399933,
          Level = 1,
          Type = 16,
          Timeout = 0.0
        },
        {

          Type = 69,
          Timeout = 2.0,
          TimeoutKey = "utrBfuZl"
        }
      },
      ValidInTower = false,
      Type = 35,
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
    EventCount = 11,
    MonsterCount = 11,
    MonsterInfo = {
      [ 20204301 ] = 3,
      [ 20204601 ] = 2,
      [ 20204401 ] = 1,
      [ 20304302 ] = 3,
      [ 20304402 ] = 2
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}