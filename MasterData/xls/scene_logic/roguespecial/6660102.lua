local empty = {}
return
{
  Events = {
    {

      Actions = {
        {

          ObjName = "Scene/sc02_zone_13/Prop/sc02_prp_13e_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc02_zone_13/sc02_zone_13_down/Building/sc02_bld_14a_pre",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_bright/Level_1/JZ1",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/RogueSpecial/Barrage",
          Visible = true,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          TimelineName = "scene_Barrage",
          IsPlay = true,
          Type = 110,
          Timeout = 0.0
        },
        {

          ObjName = "Change_/Change_bright/Level_1/JZD",
          Visible = false,
          IsAutoSave = false,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          ObjName = "Scene/sc02_zone_13/sc02_zone_13_up",
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
      IsNotCondition = false
    },
    {

      Actions = {
        {

          GroupId = 6660101,
          Type = 27,
          Timeout = 3.0,
          TimeoutKey = "tMoiSJUw"
        },
        {

          isVictory = true,
          Type = 20,
          Timeout = 58.0,
          TimeoutKey = "bFLAoiuy"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false
    },
    {

      NoPassCamera = 66601,
      NoPassCameraIsNewConfig = true,
      PassCamera = 66601,
      PassCameraIsNewConfig = true,
      ForbidCameraBlend = true,
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
      IsNotCondition = false
    }
  },
  MonsterRefreshCfg = {
    Weight = 100,
    MonsterGroupId = 0,
    MonsterWave = 0,
    MonsterCount = 0,
    SendWave = false,
    WaveStyle = 0,
    EndPerform = true
  },
  FinishiConditionDict = empty,
}