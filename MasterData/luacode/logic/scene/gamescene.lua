local GameSceneManager = CS.PixelNeko.P1.Scene.GameSceneManager
local Scene = require("logic.scene.scene")
local GameScene = {}
local _scenes = {}

function GameScene.LoadScene(tag, assetbundle, sceneName, isSingle)
  if _scenes[sceneName] then
    return false
  else
    local scene = Scene.Create(tag, assetbundle, sceneName, isSingle)
    scene:Load()
    if isSingle then
      _scenes = {}
    else
      for k, scene in pairs(_scenes) do
        if scene._tag == tag then
          scene:UnLoad()
          _scenes[k] = nil
          break
        end
      end
    end
    _scenes[sceneName] = scene
    return true
  end
end

function GameScene.SetSceneActive(tag)
  for k, scene in pairs(_scenes) do
    if scene._tag == tag then
      scene:SetActive(true)
    else
      scene:SetActive(false)
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_SceneActivceChanged, GameScene, _scenes)
end

function GameScene.SetSceneRootGameObjectActive(tag, active)
  for k, scene in pairs(_scenes) do
    if scene._tag == tag then
      scene:SetRootGameObjectActive(active)
    end
  end
end

function GameScene.LoadDungeon(assetbundle, sceneName, isSingle)
  GameScene.LoadScene("Dungeon", assetbundle, sceneName, isSingle)
end

function GameScene.LoadBattle(assetbundle, sceneName, isSingle)
  GameScene.LoadScene("Battle", assetbundle, sceneName, isSingle)
end

function GameScene.LoadStoryScene(assetbundle, sceneName, isSingle)
  GameScene.LoadScene("Story", assetbundle, sceneName, isSingle)
end

function GameScene.LoadInGame()
  local sceneController = SceneManager.LoadScene(30000, true, true, true, true, true)
end

function GameScene.LoadBaseGuideScene()
  return SceneManager.LoadScene(20006, true, true, true, true, false)
end

function GameScene.LoadFirstScene()
  return SceneManager.LoadScene(30002, true, true, true, true, false)
end

function GameScene.LoadForewordDungeon()
  return SceneManager.LoadScene(11000, true, true, true, true, true)
end

function GameScene.LoadGenDungeon()
  LuaAudioManager.PlayBGM(2)
  DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
  DialogManager.CreateSingletonDialog("dungeon.settingmenu")
  local TopDownRef = require("logic.scene.gendungeonscene.gendungeonsceneref")
  local topdownref = TopDownRef.Create("scenes.gendungeontest.unityassetbundle", "GenDungeonTest")
  topdownref:LoadScene(true, true, true)
  local BattleSceneRef = require("logic.scene.battlescene.battlesceneref")
  local battleSceneRef = BattleSceneRef.Create("scenes.behaviactest.unityassetbundle", "BehaviacTest")
  battleSceneRef:LoadScene(false, false, false)
end

function GameScene.LoadTestBattleScene(battleId)
  battleId = battleId or 1001
  local record = BeanManager.GetTableByName("battle.cbattleinfo"):GetRecorder(battleId)
  return SceneManager.LoadScene(record.sceneID, true, true, true, true, true)
end

function GameScene.LoadNewTestBattleScene(battleId)
  local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
  local record = CBattleInfoTable:GetRecorder(battleId)
  local controller = SceneManager.LoadScene(record.sceneID, true, true, true, true, true)
  controller:CallMethodAsync(controller.StartLocalBattle, battleId)
end

function GameScene.LoadBaseFirstBattleScene(battleId)
  local record = BeanManager.GetTableByName("battle.cbattleinfo"):GetRecorder(battleId)
end

function GameScene.LoadEditScene()
  GameScene.LoadStoryScene("scenes.firstscene.unityassetbundle", "FirstSceneForEditForBuild", true)
  GameScene.SetSceneActive("Story")
end

function GameScene.LoadBaseScene()
  return SceneManager.LoadScene(30001, true, true, true, true, true)
end

function GameScene.LoadTunnelScene()
  return SceneManager.LoadScene(20009, true, true, true, true, false)
end

function GameScene.LoadTrapScene(id)
  local controller = SceneManager.LoadScene(id, true, true, true)
  return controller
end

function GameScene:OnFirstSceneEnd()
  LogInfo("GameScene", "初章结束")
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centerdungeon")
  local type = LuaNetManager.CreateBean("protocol.battle.dungeontype")
  csend.dungeonType = type.SPECIAL
  csend.id = 11000
  csend.lineupId = 1
  LogInfoFormat("GameScene", "-- centerdungeon -- dungeonType = %s, id = %s ---", csend.dungeonType, csend.id)
  csend:Send()
  local jsonStr = JSON.encode({eventName = "1"})
  ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA(jsonStr)
end

LuaNotificationCenter.AddObserver(GameScene, GameScene.OnFirstSceneEnd, Common.n_FirstSceneEnd, nil)
return GameScene
