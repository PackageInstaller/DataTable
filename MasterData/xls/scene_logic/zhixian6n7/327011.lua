return
{
  Events = {
    {

      Actions = {
        {

          TimelineName = "scene_timeline_32701_brifing",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_32701_brifing2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_timeline_32701_brifingLichi",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          PosKey = "M1",
          NPCName = "阿紫",
          NpcParams = {
            InteractionArea = 2.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638652063822876080,
          IsRemove = true,
          CustomEventName = "needForMedicine",
          Type = 92,
          Timeout = 0.0
        },
        {

          PosKey = "M2",
          NPCName = "荔枝1",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "",
            IsHasAction = false,
            LongPress = false,
            LongPressTime = 0.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638652069064023739,
          IsRemove = true,
          CustomEventName = "complain",
          Type = 92,
          Timeout = 0.0
        },
        {

          GroupID = 1,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 2,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 3,
          Type = 86,
          Timeout = 0.0
        },
        {

          GroupID = 4,
          Type = 86,
          Timeout = 0.0
        },
        {

          KeyName = "M1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          TaskGroupId = 32701,
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

      NoPassCamera = 118,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 118,
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

          ObjName = "/Root/Scene/sc06_area_06/prop/sc06_prop_14_pre (10)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_06/prop/sc06_prop_14_pre (11)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_06/prop/sc06_prop_14_pre (29)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_06/prop/sc06_prop_14_pre (24)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Level/Level_02/327",
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

      Actions = {
        {

          Key = "cleaned1",
          SyncValType = 0,
          Value = "",
          selectIdx = 0,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "cleaned1F",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "cleaned1",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "cleaned2",
          SyncValType = 0,
          Value = "",
          selectIdx = 0,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "cleaned2F",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "cleaned2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          Key = "cleaned3",
          SyncValType = 0,
          Value = "",
          selectIdx = 0,
          ValidInTower = true,
          IsTmpVariable = false,
          Type = 23,
          Timeout = 0.0
        },
        {

          CustomEventName = "cleaned3F",
          Type = 19,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 2,
      ConditionVariable = "cleaned3",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 2227101,
          Actions = {
            {

              PosKey = "M2",
              NPCName = "荔枝2",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638652122164698660,
              IsRemove = true,
              CustomEventName = "findMedicine",
              Type = 92,
              Timeout = 0.1,
              TimeoutKey = "dFXdpqjp"
            },
            {

              PosKey = "M3",
              NPCName = "鸟1",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "",
                IsHasAction = false,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638652122164748660,
              IsRemove = true,
              CustomEventName = "exclaim",
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "M2",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 3270106,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2227102,
          Actions = {
            {

              PosKey = "medicine",
              NPCName = "清醒药",
              NpcParams = {
                InteractionArea = 3.0,
                UseEffect = "Fx_Investigate|H101004",
                IsHasAction = true,
                LongPress = false,
                LongPressTime = 0.0,
                LongPressStop = true,
                LongPressPause = false,
                PressCD = 0.5
              },
              Rotation = 0,
              NpcId = 638652125829261636,
              IsRemove = true,
              CustomEventName = "pickUpMedicine",
              Type = 92,
              Timeout = 0.0
            },
            {

              KeyName = "medicine",
              IsOpen = true,
              IsContinue = true,
              Type = 70,
              Timeout = 0.0
            },
            {

              TaskId = 3270101,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2227103,
          Actions = {
            {

              TimelineName = "timeline_32701_BvS",
              Fadein = 0.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.0,
              Hold = 0.0,
              BlackOut = 0.0,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.5,
              BeforeHold = 0.5,
              BeforeBlackOut = 0.5,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            },
            {

              TimelineName = "scene_timeline_32701_brifing3",
              IsPlay = false,
              Type = 110,
              Timeout = 0.6,
              TimeoutKey = "frwwliTI"
            },
            {

              StoryId = 2227104,
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
              Timeout = 5.0,
              TimeoutKey = "COcQUgWQ"
            },
            {

              NPC = "Hero",
              Point = "M4",
              Rotate = -45.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.6,
              TimeoutKey = "EMlyUPWD"
            },
            {

              TimelineName = "scene_timeline_32701_brifingLichi",
              IsPlay = false,
              Type = 110,
              Timeout = 0.6,
              TimeoutKey = "spnvezGp"
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2227104,
          Actions = {
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0
            },
            {

              TimelineName = "timeline_32701_BvS",
              Type = 7,
              Timeout = 0.6,
              TimeoutKey = "BEBTtijK"
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 32701105,
                    param = 0,
                    Name = "全部杀死",
                    CustomEventName = "getTask",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.7,
              TimeoutKey = "OdgPIDLQ"
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
                EndPerform = true,
                Conditions = {
                  {
                    RefreshCondition = 0,
                    Id = 32701106,
                    param = 0,
                    Name = "全部杀死",
                    Timeout = 0.0,
                    AIGroupId = 0,
                    AIGroup = 0,
                    AIDiffcultyTag = 0
                  }
                },
              },
              Type = 8,
              Timeout = 0.7,
              TimeoutKey = "kpZgtPdg"
            },
            {

              TaskId = 3270103,
              Type = 5,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2227105,
          Actions = {
            {

              TimelineName = "timeline_32701_musicLichiCmr",
              Type = 7,
              Timeout = 0.0
            },
            {

              FadeIn = 0.5,
              Hold = 0.5,
              FadeOut = 0.5,
              IsWhite = false,
              Type = 59,
              Timeout = 0.0,
              TimeoutKey = "xVNlyWlA"
            },
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 0.6,
              TimeoutKey = "GxFVklsy"
            },
            {

              NPC = "Hero",
              Point = "taskBegin",
              Rotate = -15.0,
              TransmitTime = 0.0,
              Type = 26,
              Timeout = 0.6,
              TimeoutKey = "wDBMbEJR"
            },
            {

              Target = "Hero",
              MagicId = 3270101,
              Level = 0,
              Type = 16,
              Timeout = 0.9,
              TimeoutKey = "ShavtEtI"
            },
            {

              TimelineName = "scene_timeline_32701_Crowd",
              IsPlay = true,
              Type = 110,
              Timeout = 0.7,
              TimeoutKey = "OjLLLXah"
            },
            {

              TimelineName = "scene_timeline_32701_brifing",
              IsPlay = false,
              Type = 110,
              Timeout = 0.7,
              TimeoutKey = "mTDWPAQS"
            },
            {

              TimelineName = "scene_timeline_32701_brifing4",
              IsPlay = false,
              Type = 110,
              Timeout = 0.7,
              TimeoutKey = "NqayQndx"
            },
            {

              CustomEventName = "snake1",
              Type = 19,
              Timeout = 0.8,
              TimeoutKey = "xWPEcAVs"
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

      EventName = "findMedicine",
      Actions = {
        {

          StoryId = 2227102,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "snake1End",
      Actions = {
        {

          GroupID = 2,
          Type = 87,
          Timeout = 0.0
        },
        {

          KeyName = "guide1",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupId = 32701101,
          Type = 27,
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

      EventName = "pickUpMedicine",
      Actions = {
        {

          NPCName = "鸟1",
          Type = 93,
          Timeout = 0.0
        },
        {

          PosKey = "M3",
          NPCName = "鸟2",
          NpcParams = {
            InteractionArea = 3.0,
            UseEffect = "Fx_Investigate|H101004",
            IsHasAction = false,
            LongPress = true,
            LongPressTime = 1.0,
            LongPressStop = true,
            LongPressPause = false,
            PressCD = 0.5
          },
          Rotation = 0,
          NpcId = 638652118180096445,
          IsRemove = true,
          CustomEventName = "wakeUp",
          Type = 92,
          Timeout = 0.0
        },
        {

          KeyName = "M3",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          TaskId = 3270102,
          Type = 5,
          Timeout = 0.0
        },
        {

          ObjName = "/Root/Scene/sc06_area_06/prop/sc06_prop_30_pre (15)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.3,
          TimeoutKey = "PSKQUHNB"
        },
        {

          ObjName = "/Root/Scene/sc06_area_06/prop/sc06_prop_30_pre (13)",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.3,
          TimeoutKey = "NSqqjBjo"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "cleaned1F",
      Actions = {
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
                Id = 32701102,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "snake2End",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        },
        {

          StoryId = 3227102,
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

          Camera = 104,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "cleaned1F",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "cleaned1F",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "snake4End",
      Actions = {
        {

          FadeIn = 0.5,
          Hold = 1.0,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "M4",
          Rotate = 150.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.6,
          TimeoutKey = "UjVEFJAV"
        },
        {

          TimelineName = "scene_timeline_32701_brifingLichi",
          IsPlay = true,
          Type = 110,
          Timeout = 0.6,
          TimeoutKey = "QijRZeRd"
        },
        {

          TimelineName = "scene_timeline_32701_brifing4",
          IsPlay = true,
          Type = 110,
          Timeout = 0.8,
          TimeoutKey = "HyaJbJRJ"
        },
        {

          TimelineName = "scene_timeline_32701_brifing",
          IsPlay = true,
          Type = 110,
          Timeout = 0.8,
          TimeoutKey = "TDpVJQvD"
        },
        {

          TimelineName = "scene_timeline_32701_Crowd",
          IsPlay = false,
          Type = 110,
          Timeout = 0.8,
          TimeoutKey = "yYRxjFZA"
        },
        {

          StoryId = 2227106,
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
          Timeout = 2.0,
          TimeoutKey = "PCPuNrjl"
        },
        {

          Target = "Hero",
          MagicId = 3270101,
          Type = 103,
          Timeout = 0.6,
          TimeoutKey = "cpKAGnEu"
        },
        {

          Type = 69,
          Timeout = 0.6,
          TimeoutKey = "tEUzaVfK"
        },
        {

          TaskId = 3270105,
          Type = 5,
          Timeout = 0.0
        },
        {

          Type = 71,
          Timeout = 1.0,
          TimeoutKey = "OmcaIObP"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "complain",
      Actions = {
        {

          StoryId = 2227107,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "wakeUp",
      Actions = {
        {

          TimelineName = "scene_timeline_32701_brifing2",
          IsPlay = false,
          Type = 110,
          Timeout = 0.05,
          TimeoutKey = "TnMPybVL"
        },
        {

          TimelineName = "scene_timeline_32701_brifing3",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          StoryId = 2227103,
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
          Timeout = 4.0,
          TimeoutKey = "OaZBmPSR"
        },
        {

          Type = 71,
          Timeout = 0.0
        },
        {

          Type = 61,
          Timeout = 0.0
        },
        {

          Type = 60,
          Timeout = 4.0,
          TimeoutKey = "pDelPPhu"
        }
      },
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "snake2End",
      Actions = {
        {

          GroupID = 3,
          Type = 87,
          Timeout = 0.0
        },
        {

          Camera = 113,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          KeyName = "guide2",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupId = 32701102,
          Type = 27,
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

      EventName = "snake3End",
      Actions = {
        {

          GroupID = 4,
          Type = 87,
          Timeout = 0.0
        },
        {

          Camera = 211,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        },
        {

          KeyName = "guide3",
          IsOpen = true,
          IsContinue = true,
          Type = 70,
          Timeout = 0.0
        },
        {

          GroupId = 32701103,
          Type = 27,
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

      EventName = "cleaned2F",
      Actions = {
        {

          StoryId = 3227103,
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
                Id = 32701103,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "snake3End",
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
      FinishMarkVariable = "cleaned2F",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "cleaned2F",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "getTask",
      Actions = {
        {

          FadeIn = 0.5,
          Hold = 0.5,
          FadeOut = 0.5,
          IsWhite = false,
          Type = 59,
          Timeout = 0.0
        },
        {

          NPC = "Hero",
          Point = "M4",
          Rotate = 150.0,
          TransmitTime = 0.0,
          Type = 26,
          Timeout = 0.6,
          TimeoutKey = "WownmtVR"
        },
        {

          StoryId = 2227105,
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

          TimelineName = "scene_timeline_32701_brifing4",
          IsPlay = true,
          Type = 110,
          Timeout = 0.7,
          TimeoutKey = "IgaFPAxK"
        },
        {

          Type = 69,
          Timeout = 0.7,
          TimeoutKey = "sZCcVtah"
        },
        {

          TimelineName = "scene_timeline_32701_musicLichi",
          IsPlay = true,
          Type = 110,
          Timeout = 0.9,
          TimeoutKey = "MKXEFskH"
        },
        {

          TaskId = 3270104,
          Type = 5,
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

      EventName = "cleaned3F",
      Actions = {
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
                Id = 32701104,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "snake4End",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        },
        {

          StoryId = 3227104,
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

          Camera = 118,
          IsNewConfig = false,
          IsForceDepressCameraMode = false,
          Type = 11,
          Timeout = 0.0
        }
      },
      FinishMarkVariable = "cleaned3F",
      ValidInTower = false,
      Type = 9,
      ConditionVariable = "cleaned3F",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      EventName = "exclaim",
      Actions = {
        {

          StoryId = 2227108,
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "snake1",
      Actions = {
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
                Id = 32701101,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "snake1End",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              }
            },
          },
          Type = 8,
          Timeout = 0.0
        },
        {

          StoryId = 3227101,
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

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 1,
            MonsterCount = 1,
            SendWave = false,
            WaveStyle = 0,
            EndPerform = true,
            ActionTag = "吹雾鸟",
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 32701107,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
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
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      EventName = "needForMedicine",
      Actions = {
        {

          StoryId = 2227101,
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

          NPCName = "荔枝1",
          Type = 93,
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

      ConditionActions = {
        {

          StoryId = 2227105,
          StepId = 10,
          Actions = {
            {

              TimelineName = "timeline_32701_musicLichiCmr",
              Fadein = 1.0,
              Fadeout = 0.0,
              IsCanSkip = false,
              NotPauseLua = false,
              IsCloseTransparent = false,
              BlackIn = 0.2,
              Hold = 0.8,
              BlackOut = 0.3,
              IsShowUI = false,
              DelayDestroy = false,
              BeforeBlackIn = 0.0,
              BeforeHold = 0.0,
              BeforeBlackOut = 0.0,
              IsWhite = false,
              Type = 6,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        },
        {

          StoryId = 2227105,
          StepId = 11,
          Actions = {
            {

              TimelineName = "timeline_32701_musicLichiCmr",
              Type = 7,
              Timeout = 0.0
            }
          },
          ValidInTower = false
        }
      },
      Type = 12,
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
      StoryId = 2227106,
      Name = "6.剧情开始"
    }
  },
  MonsterCountInfo = {
    EventCount = 7,
    MonsterCount = 19,
    MonsterInfo = {
      [ 20204901 ] = 17,
      [ 20104605 ] = 2
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}