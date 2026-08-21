local empty = {}
return
{
  Events = {
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

          Type = 12,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 7,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          PosKey = "NPC1",
          Rotation = 0,
          NPCId = 101103,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC2",
          Rotation = 0,
          NPCId = 101104,
          Type = 0,
          Timeout = 0.0
        },
        {

          PosKey = "NPC3",
          Rotation = 0,
          NPCId = 101201,
          Type = 0,
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

      ConditionActions = {
        {

          Key = "dialog1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 100147,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              TipsId = 100148,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 3.0,
              TimeoutKey = "LFxEHThu"
            },
            {

              TipsId = 100149,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 6.5,
              TimeoutKey = "uXeEdden"
            },
            {

              TipsId = 100150,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 9.5,
              TimeoutKey = "ftnCeGLK"
            },
            {

              TipsId = 100151,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 12.5,
              TimeoutKey = "BkeKrOaJ"
            },
            {

              TipsId = 100152,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 14.5,
              TimeoutKey = "CAwdkYdP"
            },
            {

              AreaName = "dialog1",
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

      ConditionActions = {
        {

          Key = "dialog2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              TipsId = 100153,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              Camera = 115,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          NPCId = 101103,
          Actions = {
            {

              TipsId = 100155,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              PosKey = "NPC1",
              Rotation = 0,
              NPCId = 101103,
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "ajNmprto"
            },
            {

              StoryId = 101202,
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
              TimeoutKey = "weUKkWCq"
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          NPCId = 101104,
          Actions = {
            {

              TipsId = 100156,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              PosKey = "NPC2",
              Rotation = 0,
              NPCId = 101104,
              Type = 0,
              Timeout = 1.0,
              TimeoutKey = "DQZXkaYr"
            },
            {

              TipsId = 100154,
              Visible = true,
              Flip = false,
              Type = 15,
              Timeout = 10.0,
              TimeoutKey = "VpZpqdwt"
            }
          },
          ValidInTower = false
        }
      },
      Type = 6,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          Key = "camera3",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          Key = "dialog1",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 111,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

          Key = "camera2",
          IsRemoveAfterEnter = false,
          IsRemoveForever = false,
          Actions = {
            {

              Camera = 104,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
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

      NoPassCamera = 104,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 104,
      PassCameraIsNewConfig = false,
      ForbidCameraBlend = true,
      PassForceDepressCameraMode = false,
      Actions = {
        {

          TimelineName = "scene_fx2",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "scene_fx2",
      IsNotCondition = true,
      IsForeverVariable = false
    },
    {

      Actions = {
        {

          TimelineName = "scene_fx2",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 13,
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

          TimelineName = "scene_fx2",
          IsPlay = false,
          Type = 110,
          Timeout = 0.0
        }
      },
      ValidInTower = false,
      Type = 1,
      ConditionVariable = "scene_fx2",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      ConditionActions = {
        {

          StoryId = 101202,
          Actions = {
            {

              TimelineName = "timeline_pingzhang",
              Fadein = 1.0,
              Fadeout = 1.0,
              IsCanSkip = false,
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
              Timeout = 0.0,
              TimeoutKey = ""
            },
            {

              TimelineName = "scene_fx2",
              IsPlay = false,
              Type = 110,
              Timeout = 1.0,
              TimeoutKey = "bRhqCApy"
            },
            {

              Camera = 113,
              IsNewConfig = false,
              IsForceDepressCameraMode = false,
              Type = 11,
              Timeout = 1.0,
              TimeoutKey = "NAhBPqDU"
            }
          },
          FinishMarkVariable = "scene_fx2",
          ValidInTower = false
        }
      },
      Type = 5,
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
    EndPerform = true,
    Conditions = empty,
  },
  FinishiConditionDict = {
    [ 5 ] = {
      Name = "进入房间"
    }
  },
  mDefaultStartTime = true,
  mDefaultEndTime = true
}