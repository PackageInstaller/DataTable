local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          Enable = true,
          Type = 17,
          Timeout = 0.0
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 4,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 1103011,
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

          TaskGroupId = 1103,
          Type = 21,
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

      NoPassCamera = 1,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = true,
      PassCamera = 1,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
      Actions = empty,
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Direction = 4,
          Type = 51,
          Timeout = 0.0
        },
        {

          Direction = 2,
          Type = 51,
          Timeout = 0.0
        },
        {

          GroupId = 1103014,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1103015,
          Type = 27,
          Timeout = 0.0
        },
        {

          NPCName = "NPC3",
          Type = 93,
          Timeout = 0.0
        },
        {

          Group = 1103013,
          Type = 65,
          Timeout = 0.0
        },
        {

          NPCName = "NPC2",
          Type = 93,
          Timeout = 0.0
        },
        {

          Group = 1103012,
          Type = 65,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 35,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "tips1",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 905100305,
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
            },
            {

              AreaName = "tip2",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "tip3",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips2",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 905100305,
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
            },
            {

              AreaName = "tip1",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "tip3",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          Key = "tips3",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              StoryId = 905100305,
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
            },
            {

              AreaName = "tip1",
              RemoveForever = false,
              Type = 9,
              Timeout = 0.0
            },
            {

              AreaName = "tip2",
              RemoveForever = false,
              Type = 9,
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

      EventName = "clear",
      Actions = {
        {

          StoryId = 905100301,
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
        },
        {

          Key = "shouldCreate",
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
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交互1",
      Actions = {
        {

          CustomEventName = "交互1失败",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "交互1成功",
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

      EventName = "交互1成功",
      Actions = {
        {

          NPCName = "NPC1",
          Type = 93,
          Timeout = 0.0
        },
        {

          Group = 1103011,
          Type = 65,
          Timeout = 0.0
        },
        {

          StoryId = 904100301,
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
        },
        {

          isVictory = true,
          isPopConfirmTips = false,
          Type = 20,
          Timeout = 0.0
        },
        {

          Tips = "获得线索",
          Duration = 2.0,
          IsOpen = true,
          Type = 94,
          Timeout = 0.0
        },
        {

          TaskId = 110301,
          Type = 5,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "inBattle",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "交互1失败",
      Actions = {
        {

          StoryId = 905100304,
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "inBattle",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交互2",
      Actions = {
        {

          CustomEventName = "交互2失败",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "交互2成功",
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

      EventName = "交互2成功",
      Actions = {
        {

          NPCName = "NPC2",
          Type = 93,
          Timeout = 0.0
        },
        {

          Group = 1103012,
          Type = 65,
          Timeout = 0.0
        },
        {

          StoryId = 905100303,
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
          Timeout = 1.0,
          TimeoutKey = "otkZPpfL"
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
                Id = 1103012,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear2",
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

          Key = "inBattle",
          SyncValType = 2,
          Value = true,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0,
          TimeoutKey = "VqvwnOff"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "inBattle",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "交互2失败",
      Actions = {
        {

          StoryId = 905100304,
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "inBattle",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "交互3",
      Actions = {
        {

          CustomEventName = "交互3失败",
          Type = 19,
          Timeout = 0.0
        },
        {

          CustomEventName = "交互3成功",
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

      EventName = "交互3成功",
      Actions = {
        {

          NPCName = "NPC3",
          Type = 93,
          Timeout = 0.0
        },
        {

          Group = 1103013,
          Type = 65,
          Timeout = 0.0
        },
        {

          StoryId = 905100303,
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
          Timeout = 1.0,
          TimeoutKey = "cQPvaEfh"
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
                Id = 1103012,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "clear2",
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

          Key = "inBattle",
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
      Type = 9,
      ConditionVariable = "inBattle",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "交互3失败",
      Actions = {
        {

          StoryId = 905100304,
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
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "inBattle",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "create_clue",
      Actions = {
        {

          Key = "shouldCreate",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          GroupId = 1103011,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1103012,
          Type = 27,
          Timeout = 0.0
        },
        {

          GroupId = 1103013,
          Type = 27,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "NPC1",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638869861101184282,
          IsRemove = false,
          CustomEventName = "交互1",
          Type = 92,
          Timeout = 2.5,
          TimeoutKey = "kbRbZWNp"
        },
        {

          PosKey = "M2",
          NPCName = "NPC2",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638869861101204216,
          IsRemove = false,
          CustomEventName = "交互2",
          Type = 92,
          Timeout = 2.5,
          TimeoutKey = "BJHkaikN"
        },
        {

          PosKey = "M3",
          NPCName = "NPC3",
          NpcParams = {
            InteractionArea = 3.3,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638869861101194253,
          IsRemove = false,
          CustomEventName = "交互3",
          Type = 92,
          Timeout = 2.5,
          TimeoutKey = "dxqGADPO"
        },
        {

          StoryId = 904100302,
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
          Timeout = 2.5,
          TimeoutKey = "xLoDbTnc"
        }
      },
      FinishMarkVariable = "",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "shouldCreate",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "clear2",
      Actions = {
        {

          Key = "inBattle",
          SyncValType = 2,
          Value = false,
          selectIdx = 2,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
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
    EventCount = 3,
    MonsterCount = 10,
    MonsterInfo = {
      [ 20105701 ] = 2,
      [ 20205601 ] = 6,
      [ 20105501 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}