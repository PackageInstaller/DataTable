-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/gamescene.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSceneManager = (((CS.PixelNeko).P1).Scene).GameSceneManager
local Scene = require("logic.scene.scene")
local GameScene = {}
local _scenes = {}
GameScene.LoadScene = function(tag, assetbundle, sceneName, isSingle)
  -- function num : 0_0 , upvalues : _scenes, Scene, _ENV
  if _scenes[sceneName] then
    return false
  else
    local scene = (Scene.Create)(tag, assetbundle, sceneName, isSingle)
    scene:Load()
    if isSingle then
      _scenes = {}
    else
      for k,scene in pairs(_scenes) do
        if scene._tag == tag then
          scene:UnLoad()
          _scenes[k] = nil
          break
        end
      end
    end
    do
      _scenes[sceneName] = scene
      do return true end
    end
  end
end

GameScene.SetSceneActive = function(tag)
  -- function num : 0_1 , upvalues : _ENV, _scenes, GameScene
  for k,scene in pairs(_scenes) do
    if scene._tag == tag then
      scene:SetActive(true)
    else
      scene:SetActive(false)
    end
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneActivceChanged, GameScene, _scenes)
end

GameScene.SetSceneRootGameObjectActive = function(tag, active)
  -- function num : 0_2 , upvalues : _ENV, _scenes
  for k,scene in pairs(_scenes) do
    if scene._tag == tag then
      scene:SetRootGameObjectActive(active)
    end
  end
end

GameScene.LoadDungeon = function(assetbundle, sceneName, isSingle)
  -- function num : 0_3 , upvalues : GameScene
  (GameScene.LoadScene)("Dungeon", assetbundle, sceneName, isSingle)
end

GameScene.LoadBattle = function(assetbundle, sceneName, isSingle)
  -- function num : 0_4 , upvalues : GameScene
  (GameScene.LoadScene)("Battle", assetbundle, sceneName, isSingle)
end

GameScene.LoadStoryScene = function(assetbundle, sceneName, isSingle)
  -- function num : 0_5 , upvalues : GameScene
  (GameScene.LoadScene)("Story", assetbundle, sceneName, isSingle)
end

GameScene.LoadInGame = function()
  -- function num : 0_6 , upvalues : _ENV
  local sceneController = (SceneManager.LoadScene)(30000, true, true, true, true, true)
end

GameScene.LoadBaseGuideScene = function()
  -- function num : 0_7 , upvalues : _ENV
  return (SceneManager.LoadScene)(20006, true, true, true, true, false)
end

GameScene.LoadFirstScene = function()
  -- function num : 0_8 , upvalues : _ENV
  return (SceneManager.LoadScene)(30002, true, true, true, true, false)
end

GameScene.LoadForewordDungeon = function()
  -- function num : 0_9 , upvalues : _ENV
  return (SceneManager.LoadScene)(11000, true, true, true, true, true)
end

GameScene.LoadGenDungeon = function()
  -- function num : 0_10 , upvalues : _ENV
  (LuaAudioManager.PlayBGM)(2)
  ;
  (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
  ;
  (DialogManager.CreateSingletonDialog)("dungeon.settingmenu")
  local TopDownRef = require("logic.scene.gendungeonscene.gendungeonsceneref")
  local topdownref = (TopDownRef.Create)("scenes.gendungeontest.unityassetbundle", "GenDungeonTest")
  topdownref:LoadScene(true, true, true)
  local BattleSceneRef = require("logic.scene.battlescene.battlesceneref")
  local battleSceneRef = (BattleSceneRef.Create)("scenes.behaviactest.unityassetbundle", "BehaviacTest")
  battleSceneRef:LoadScene(false, false, false)
end

GameScene.LoadTestBattleScene = function(battleId)
  -- function num : 0_11 , upvalues : _ENV
  if not battleId then
    battleId = 1001
  end
  local record = ((BeanManager.GetTableByName)("battle.cbattleinfo")):GetRecorder(battleId)
  return (SceneManager.LoadScene)(record.sceneID, true, true, true, true, true)
end

GameScene.LoadNewTestBattleScene = function(battleId)
  -- function num : 0_12 , upvalues : _ENV
  local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
  local record = CBattleInfoTable:GetRecorder(battleId)
  local controller = (SceneManager.LoadScene)(record.sceneID, true, true, true, true, true)
  controller:CallMethodAsync(controller.StartLocalBattle, battleId)
end

GameScene.LoadBaseFirstBattleScene = function(battleId)
  -- function num : 0_13 , upvalues : _ENV
  local record = ((BeanManager.GetTableByName)("battle.cbattleinfo")):GetRecorder(battleId)
end

GameScene.LoadEditScene = function()
  -- function num : 0_14 , upvalues : GameScene
  (GameScene.LoadStoryScene)("scenes.firstscene.unityassetbundle", "FirstSceneForEditForBuild", true)
  ;
  (GameScene.SetSceneActive)("Story")
end

GameScene.LoadBaseScene = function()
  -- function num : 0_15 , upvalues : _ENV
  return (SceneManager.LoadScene)(30001, true, true, true, true, true)
end

GameScene.LoadTunnelScene = function()
  -- function num : 0_16 , upvalues : _ENV
  return (SceneManager.LoadScene)(20009, true, true, true, true, false)
end

GameScene.LoadTrapScene = function(id)
  -- function num : 0_17 , upvalues : _ENV
  local controller = (SceneManager.LoadScene)(id, true, true, true)
  return controller
end

GameScene.OnFirstSceneEnd = function(self)
  -- function num : 0_18 , upvalues : _ENV
  LogInfo("GameScene", "初章结束")
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centerdungeon")
  local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 11000
  csend.lineupId = 1
  LogInfoFormat("GameScene", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
  local jsonStr = (JSON.encode)({eventName = "1"})
  ;
  (ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA)(jsonStr)
end

;
(LuaNotificationCenter.AddObserver)(GameScene, GameScene.OnFirstSceneEnd, Common.n_FirstSceneEnd, nil)
return GameScene

