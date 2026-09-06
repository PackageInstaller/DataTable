local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local StroyBattleSceneController = class("StroyBattleSceneController", NewBattleSceneController)

function StroyBattleSceneController:Init()
  StroyBattleSceneController.super.Init(self)
  CS.PixelNeko.P1.TimeLine.EventTriggerHelper.AddTriggerBehaviourPlayListener(self._sceneRef._triggerTimeLine, self.OnTriggerBehaviourPlay, self)
end

function StroyBattleSceneController:OnTriggerBehaviourPlay(doubleValue, longValue, stringValue, objectValue)
  if stringValue == "BattleStart" then
    local protocol = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()
    StroyBattleSceneController.super.OnSBattleStart(self, protocol)
  end
end

function StroyBattleSceneController:OnSBattleStart(protocol)
end

function StroyBattleSceneController:OnDestroy()
  StroyBattleSceneController.super.OnDestroy(self)
end

return StroyBattleSceneController
