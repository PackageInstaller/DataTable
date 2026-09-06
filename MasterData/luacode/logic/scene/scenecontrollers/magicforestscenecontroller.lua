local EventTriggerHelper = CS.PixelNeko.P1.TimeLine.EventTriggerHelper
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local MagicForestSceneController = class("MagicForestSceneController", SceneController)

local function HandleRockerMove(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  if userInfo.axisVector.x > 0 then
    self._sceneRef:GetMagicforestScenePlayerMove().Dir = 1
  elseif userInfo.axisVector.x < 0 then
    self._sceneRef:GetMagicforestScenePlayerMove().Dir = -1
  else
    self._sceneRef:GetMagicforestScenePlayerMove().Dir = 0
  end
end

local function HandleRockerStop(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  self._sceneRef:GetMagicforestScenePlayerMove().Dir = 0
end

function MagicForestSceneController:Ctor(sceneRef)
  MagicForestSceneController.super.Ctor(self, sceneRef)
end

function MagicForestSceneController:Init()
  MagicForestSceneController.super.Init(self)
  LuaAudioManager.PlayBGM(113)
  local obj = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._sceneRef:GetRootGameObject(), "TimeLine")
  EventTriggerHelper.AddGraphStopListener(CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._sceneRef:GetRootGameObject(), "TimeLine"), self.OnTriggerBehaviourPlay, self)
  LuaNotificationCenter.AddObserver(self, HandleRockerMove, Common.n_RockerMove, nil)
  LuaNotificationCenter.AddObserver(self, HandleRockerStop, Common.n_RockerEnd, nil)
end

function MagicForestSceneController:OnTriggerBehaviourPlay(doubleValue, longValue, stringValue, objectValue)
  if stringValue == "walkStartW1" then
    self._sceneRef:GetMagicforestScenePlayerMove().enabled = true
    local dialog = DialogManager.GetDialog("dungeon.rockerdialog")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    else
      DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
    end
  end
end

function MagicForestSceneController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
end

return MagicForestSceneController
