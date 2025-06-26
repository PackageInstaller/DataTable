-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/magicforestscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventTriggerHelper = (((CS.PixelNeko).P1).TimeLine).EventTriggerHelper
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local MagicForestSceneController = class("MagicForestSceneController", SceneController)
local HandleRockerMove = function(self, notification)
  -- function num : 0_0
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  if (userInfo.axisVector).x > 0 then
    ((self._sceneRef):GetMagicforestScenePlayerMove()).Dir = 1
  else
    if (userInfo.axisVector).x < 0 then
      ((self._sceneRef):GetMagicforestScenePlayerMove()).Dir = -1
    else
      ;
      ((self._sceneRef):GetMagicforestScenePlayerMove()).Dir = 0
    end
  end
end

local HandleRockerStop = function(self, notification)
  -- function num : 0_1
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  ;
  ((self._sceneRef):GetMagicforestScenePlayerMove()).Dir = 0
end

MagicForestSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_2 , upvalues : MagicForestSceneController
  ((MagicForestSceneController.super).Ctor)(self, sceneRef)
end

MagicForestSceneController.Init = function(self)
  -- function num : 0_3 , upvalues : MagicForestSceneController, _ENV, EventTriggerHelper, HandleRockerMove, HandleRockerStop
  ((MagicForestSceneController.super).Init)(self)
  ;
  (LuaAudioManager.PlayBGM)(113)
  local obj = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self._sceneRef):GetRootGameObject(), "TimeLine")
  ;
  (EventTriggerHelper.AddGraphStopListener)(((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self._sceneRef):GetRootGameObject(), "TimeLine"), self.OnTriggerBehaviourPlay, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleRockerStop, Common.n_RockerEnd, nil)
end

MagicForestSceneController.OnTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_4 , upvalues : _ENV
  if stringValue == "walkStartW1" then
    ((self._sceneRef):GetMagicforestScenePlayerMove()).enabled = true
    local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dialog then
      (dialog:GetRootWindow()):SetActive(true)
    else
      ;
      (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
    end
  end
end

MagicForestSceneController.OnDestroy = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
end

return MagicForestSceneController

