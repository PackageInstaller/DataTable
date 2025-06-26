local state = BaseState:New(BattleState.InitScene)

-- 场景加载后设置光照
local function InitSceneSetting(battleComp) --设置场景的光照
     local skyBoxPath = "Skybox/"..battleComp.zScene.SkyBox.."/"..battleComp.zScene.SkyBox..".mat"; --设置天空盒
     local RenderSettings = CS.UnityEngine.RenderSettings;
     RenderSettings.skybox = ResourcesManager:GetInstance():CoLoadAsync(skyBoxPath,typeof(Material));
     local ambientMode = battleComp.zScene.SourceMode
     RenderSettings.ambientMode = ambientMode;

     if ambientMode == 0 then -- Skybox  --设置环境光
          RenderSettings.ambientIntensity = battleComp.zScene.IntensityMultiplier;
     elseif ambientMode == 1 then -- Gradient
          local skyColor = battleComp.zScene.SkyColor;
          local equatorColor = battleComp.zScene.EquatorColor;
          local groundColor = battleComp.zScene.GroundColor;
          RenderSettings.ambientSkyColor = Color.New(skyColor[1],skyColor[2],skyColor[3],1);
          RenderSettings.ambientEquatorColor = Color.New(equatorColor[1],equatorColor[2],equatorColor[3],1);
          RenderSettings.ambientGroundColor = Color.New(groundColor[1],groundColor[2],groundColor[3],1);
     elseif ambientMode == 3 then -- Color
          local ambientColor = battleComp.zScene.AmbientColor;
          RenderSettings.ambientLight = Color.New(ambientColor[1],ambientColor[2],ambientColor[3],1);
     end

     if battleComp.zScene.IsActiveFog == 1 then --设置雾化
          RenderSettings.fog = true;
          local fogMode = battleComp.zScene.FogMode;
          local fogColor = battleComp.zScene.FogColor;
          RenderSettings.fogColor = Color.New(fogColor[1],fogColor[2],fogColor[3],1)
          RenderSettings.fogMode = fogMode;
          if fogMode == 1 then
               RenderSettings.fogStartDistance = battleComp.zScene.FogStart;
               RenderSettings.fogEndDistance = battleComp.zScene.FogEnd;
          elseif fogMode == 2 or fogMode == 3 then
               RenderSettings.fogDensity = battleComp.zScene.FogDensity;
          end
     end
     CS.UnityEngine.DynamicGI.UpdateEnvironment();
end

-- 加载场景
local function CoGenScene(battleComp)
     battleComp.scene_root = GameObjectPool:GetInstance():CoGetGameObjectAsync(battleComp.scene_res_path)
     battleComp.scene_root.transform:SetParent(GameObject.Find("SceneRoot").transform)
     battleComp.scene_root.transform.localPosition = Vector3.zero
     table.csenu(battleComp.scene_root:GetComponentsInChildren(typeof(Transform)),function (v)
          v.gameObject.layer = battleComp.MapLayer
     end)
     InitSceneSetting(battleComp)
end

--初始化己方单位
local function CoGenCards(battleComp, isPlayer)
     local againstComponent = Game.Scene:GetComponent("AgainstComponent")
     local formation = isPlayer and againstComponent.PlayerFormation or againstComponent.EnemyPlayerFormation
     againstComponent.EnemyUnits = {}
     local formationPosList = {}
     for i = 1, 6 do
          table.insert(formationPosList,false)
     end

     for _, unit in ipairs(formation.units) do
          local unitData = {}
          unitData.isMonster = false
          unitData.unit = unit
          unitData.batchNum = 1
          local ssUnit = BattleUtil.GenSsUnit(battleComp, unitData, isPlayer)
          table.insert(againstComponent.EnemyUnits, ssUnit)
          formationPosList[unit.formation_postion] = true
     end
     if formation.support_unit ~= nil and #formation.units < 6 then
          local supportPos = 1
          for i = 1, 6 do
               if formationPosList[i] == false then
                    supportPos = i
                    break
               end
          end

          local unitData = {}
          unitData.isMonster = false
          unitData.unit = formation.support_unit
          unitData.unit.formation_postion = supportPos
          unitData.batchNum = 1
          local ssUnit = BattleUtil.GenSsUnit(battleComp, unitData, isPlayer)
          table.insert(againstComponent.EnemyUnits, ssUnit)
     elseif formation.support_unit ~= nil and #formation.units == 6 then
          formation.isUsesupport = false
          local unitData = {}
          unitData.isMonster = false
          unitData.unit = formation.support_unit
          unitData.unit.formation_postion = 6
          
          local ssunit = BattleUtil.CreateUnit(unitData.unit.character_id, unitData.unit.skin)
          ssunit.gameObject:SetActive(false)
     end
end

local function CoGenEnemy(battleComp)
     local against_component = Game.Scene:GetComponent("AgainstComponent")
     if against_component.LevelType == LevelType.LevelTypeArena then
          CoGenCards(battleComp, false)
     end
end

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     -- 等待加载 --
     local needLoadNum = 5
     -- loading window --
     local window = UIManager:GetInstance():GetWindow(UIWindowNames.UILoading)
     local model = window.Model
     local kk = 1 - model.value
     kk = kk / needLoadNum

     local gen = function()
          model.value = model.value + kk
     end
     
     -- 加载地图 --
     CoGenScene(state.battleComp)
     print("load scene")
     gen()
     
     -- 添加其它战斗组件 --
     Game.Scene:AddComponent("BattleCameraComponent")
     Game.Scene:AddComponent("BattleUIComponent")
     Game.Scene:AddComponent("MatrixComponent")
     Game.Scene:AddComponent("PlayerBattleComponent")
     Game.Scene:AddComponent("BattleSsUnitUIComponent")
     gen()
     print("add component")
     
     -- 添加玩家 --
     CoGenCards(state.battleComp, true) -- 添加战斗各类组件，初始话已方单位
     gen()
     print("CoGenCards")
     
     -- 生成敌方玩家 --
     CoGenEnemy(state.battleComp)
     gen()
     print("Loaded ~~~~~~~~~:"..Time.time)
     coroutine.waitforseconds(0.2)
     -- 进入战斗 --
     state.battleComp.fsm:Switch(BattleState.BattleStart)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state