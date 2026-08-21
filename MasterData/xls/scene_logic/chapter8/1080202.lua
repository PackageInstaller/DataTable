local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Building_06/down/sc08_build_17b_pre8/sc08_build_17c_01_mod",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/10802/scene_timeline_1080202_halfOpenTimeline",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TaskId = 1080203,
          Type = 5,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Prop_06/down/sc08_prop_26a_pre10",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Prop_06/down/sc08_prop_26b_pre14",
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

      NoPassCamera = 1080202,
      NoPassCameraIsNewConfig = true,
      NoPassForceDepressCameraMode = true,
      PassCamera = 1080202,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = true,
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

          Key = "fight",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              GroupID = 2,
              Type = 86,
              Timeout = 0.0
            },
            {

              RefreshCfg = {
                Weight = 100,
                MonsterLockEnemyCount = 0,
                MonsterGroupId = 0,
                MonsterWave = 2,
                MonsterCount = 7,
                SendWave = false,
                WaveStyle = 0,
                EndPerform = false,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 10802201,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDifficultyTag = -1
                  },
                  {
                    RefreshCondition = 0,
                    Id = 10802202,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "infinite1",
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

              StoryId = 5080303,
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
          FinishMarkVariable = "",
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

          Key = "clear",
          IsRemoveAfterEnter = true,
          IsRemoveForever = false,
          Actions = {
            {

              NPCId = 10802201,
              NPCName = "传送1",
              Type = 1,
              Timeout = 0.0
            },
            {

              Type = 69,
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
                    Id = 10802203,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "leave",
                    Timeout = 0.5,
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

              FadeIn = 0.0,
              Hold = 1.0,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              CustomEventName = "tla",
              Type = 19,
              Timeout = 0.5,
              TimeoutKey = "kaRGJEnJ"
            },
            {

              CustomEventName = "tlw",
              Type = 19,
              Timeout = 0.7,
              TimeoutKey = "UuUIycaM"
            }
          },
          FinishMarkVariable = "next1",
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

          Key = "end",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = empty,
          ValidInTower = false
        }
      },
      Type = 3,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "infinite1",
      Actions = {
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 2,
            MonsterCount = 7,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = false,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 10802204,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              },
              {
                RefreshCondition = 0,
                Id = 10802206,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "infinite1",
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

          CustomEventName = "remindToLeave1",
          Type = 19,
          Timeout = 3.0,
          TimeoutKey = "UqAflXZw"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "next1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "remindToLeave1",
      Actions = {
        {

          PosKey = "clear",
          NPCName = "rCxKvdFS",
          NpcParams = {
            InteractionArea = -1.0,
            UseEffect = "Fx_Transmit3_idel|H101004",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638731449365108604,
          IsRemove = false,
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "clear",
          IsOpen = true,
          CameraStyle = 1,
          Duration = -1.0,
          StopLuaScript = true,
          BackToDefault = false,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 0.0
        },
        {

          PosKey = "clear",
          IsOpen = true,
          CameraStyle = 0,
          Duration = -1.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 2.0,
          TimeoutKey = "xaWdXGrv"
        },
        {

          StoryId = 5080304,
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
          Timeout = 0.5,
          TimeoutKey = "AAxohseD"
        },
        {

          KeyName = "clear",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "reminded1",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "reminded1",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "leave",
      Actions = {
        {

          PosKey = "leaveCmr",
          IsOpen = true,
          CameraStyle = 1,
          Duration = -1.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = false,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.0,
          TimeoutKey = "MtnzaVpd"
        },
        {

          StoryId = 4080301,
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
          Timeout = 1.2,
          TimeoutKey = "EeUrQwPH"
        },
        {

          PosKey = "true",
          NPCName = "结束门",
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
          NpcId = 638755977732836636,
          IsRemove = true,
          CustomEventName = "end",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "false",
          NPCName = "惩罚门",
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
          NpcId = 638755977738675927,
          IsRemove = true,
          CustomEventName = "punish",
          Type = 92,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Building_06/down/sc08_build_02a_pre148",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "JTLsNOMM"
        },
        {

          ObjName = "/Root/Scene/Zone_06/Building_06/down/sc08_build_02a_pre149",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 1.0,
          TimeoutKey = "FlCsXVuY"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 4080301,
          Actions = {
            {

              PosKey = "leaveCmr",
              IsOpen = true,
              CameraStyle = 0,
              Duration = -1.0,
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

              ObjName = "/Root/Scene/Zone_06/Building_06/down/sc08_build_02a_pre148",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            },
            {

              ObjName = "/Root/Scene/Zone_06/Building_06/down/sc08_build_02a_pre149",
              Visible = true,
              IsAutoSave = false,
              SaveType = 0,
              Type = 13,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 5,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "end",
      Actions = {
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          TaskId = 1080204,
          Type = 5,
          Timeout = 0.0
        },
        {

          FadeIn = 0.3,
          Hold = 0.5,
          FadeOut = 0.3,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          StoryId = 1001080302,
          EnableBlackFade = false,
          DelayDestroy = false,
          PlayFadeInTime = 0.5,
          PlayStayTime = 0.5,
          PlayFadeOutTime = 0.5,
          StopFadeInTime = 0.5,
          StopStayTime = 0.5,
          StopFadeOutTime = 0.5,
          NoSkipStory = false,
          IsSettleStory = true,
          Type = 10,
          Timeout = 0.5,
          TimeoutKey = "MSSTJoPa"
        },
        {

          Type = 71,
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

      EventName = "punish",
      Actions = {
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          NPCName = "结束门",
          Type = 93,
          Timeout = 0.0
        },
        {

          TimelineName = "timeline_802_punish",
          Fadein = 0.0,
          Fadeout = 1.0,
          IsCanSkip = true,
          NotPauseLua = false,
          IsCloseTransparent = false,
          BlackIn = 0.0,
          Hold = 0.0,
          BlackOut = 0.0,
          IsShowUI = false,
          DelayDestroy = false,
          BeforeBlackIn = 0.0,
          BeforeHold = 0.0,
          BeforeBlackOut = 0.0,
          IsWhite = false,
          Type = 6,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "NoOpen",
          Rotate = 0.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          StoryId = 5080305,
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
          Timeout = 0.5,
          TimeoutKey = "NGaNRpxr"
        },
        {

          TimelineName = "timeline_802_punish",
          Type = 7,
          Timeout = 1.5,
          TimeoutKey = "CrLgdEGZ"
        },
        {

          PosKey = "enemy",
          IsOpen = true,
          CameraStyle = 1,
          Duration = 3.0,
          StopLuaScript = false,
          BackToDefault = true,
          HideUI = true,
          HasOTSConfig = false,
          OTSCameraStyle = 0,
          OTSDuration = 0.0,
          Type = 62,
          Timeout = 1.5,
          TimeoutKey = "ygAmQDDT"
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
                Id = 10802205,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "leave2",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDifficultyTag = -1
              }
            },
          },
          Type = 8,
          Timeout = 1.5,
          TimeoutKey = "ZGAVBXsV"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "leave2",
      Actions = {
        {

          PosKey = "true",
          NPCName = "结束门2",
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
          NpcId = 638755993338148537,
          IsRemove = true,
          CustomEventName = "end",
          Type = 92,
          Timeout = 0.0
        },
        {

          KeyName = "true",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
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

      EventName = "tla",
      Actions = {
        {

          NPC = "Hero",
          Point = "down",
          Rotate = 180.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Area_06/sc08_area_06_pre/sc08_area_06a/sc08_area_06a_02",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          Type = 71,
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

      EventName = "tlw",
      Actions = {
        {

          BackToDefault = true,
          Type = 63,
          Timeout = 0.0
        },
        {

          Target = "Hero",
          Type = 38,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/Zone_06/Area_06/sc08_area_06_pre/sc08_area_06b/sc08_area_06b_02",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
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
  FinishiConditionDict = {
    [ 7 ] = {
      StoryId = 1001080302,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 4,
    MonsterCount = 21,
    MonsterInfo = {
      [ 20205501 ] = 8,
      [ 20105701 ] = 10,
      [ 20205601 ] = 2,
      [ 20105601 ] = 1
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}