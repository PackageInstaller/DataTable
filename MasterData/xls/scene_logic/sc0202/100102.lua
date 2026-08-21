return
{
  Events = {
    {

      Actions = {
        {

          Seconds = 2.0,
          Type = 50,
          Timeout = 0.0,
          TimeoutKey = "0"
        },
        {

          Type = 48,
          Timeout = 2.0,
          TimeoutKey = "1"
        },
        {

          RefreshCfg = {
            Weight = 100,
            MonsterLockEnemyCount = 0,
            MonsterGroupId = 0,
            MonsterWave = 3,
            MonsterCount = 9,
            SendWave = false,
            WaveStyle = 0,
            WallObjPath = "",
            EndPerform = true,
            Conditions = {
              {
                RefreshCondition = 0,
                Id = 100201,
                param = 0,
                Name = "全部杀死",
                CustomEventName = "",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 100202,
                param = 0,
                Name = "全部杀死",
                Timeout = 0.0,
                AIGroupId = 0,
                AIGroup = 0,
                AIDiffcultyTag = 0
              },
              {
                RefreshCondition = 0,
                Id = 100203,
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
          Timeout = 2.0,
          TimeoutKey = "2"
        }
      },
      ValidInTower = false,
      Type = 0,
      ConditionVariable = "",
      IsNotCondition = false,
      IsForeverVariable = false
    },
    {

      NoPassCamera = 102,
      NoPassCameraIsNewConfig = false,
      NoPassForceDepressCameraMode = false,
      PassCamera = 102,
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

          ObjName = "Scene/04_SL/sc01_area_04/Building/sc01_area_04_pre/Prop/sc01_prp_13a_pre(156)",
          Visible = false,
          IsAutoSave = true,
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

          ObjName = "Scene/04_SL/sc01_area_04/Building/sc01_area_04_pre/Prop/sc01_prp_13a_pre(155)",
          Visible = false,
          IsAutoSave = true,
          SaveType = 0,
          Type = 13,
          Timeout = 0.0
        },
        {

          SkillLevel = 1,
          TowerValid = false,
          Type = 45,
          Timeout = 0.0
        },
        {

          ObjName = "LevelObj/battle_kqq_fx/elite1",
          Visible = true,
          IsAutoSave = true,
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

          Type = 12,
          Timeout = 0.0
        },
        {

          Type = 49,
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

      EventName = "1",
      Actions = {
        {

          GroupId = 100201,
          Type = 27,
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
    [ 1 ] = {
      Name = "杀死所有怪物"
    }
  },
  MonsterCountInfo = {
    EventCount = 1,
    MonsterCount = 9,
    MonsterInfo = {
      [ 20101501 ] = 6,
      [ 20102901 ] = 2,
      [ 20101101001 ] = 1
    }
  },
  mDefaultStartTime = false,
  mDefaultEndTime = false
}