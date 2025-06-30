-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/storybattlescenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewBattleSceneController = require("logic.scene.scenecontrollers.newbattlescenecontroller")
local StroyBattleSceneController = class("StroyBattleSceneController", NewBattleSceneController)
StroyBattleSceneController.Init = function(self)
  -- function num : 0_0 , upvalues : StroyBattleSceneController, _ENV
  ((StroyBattleSceneController.super).Init)(self)
  ;
  (((((CS.PixelNeko).P1).TimeLine).EventTriggerHelper).AddTriggerBehaviourPlayListener)((self._sceneRef)._triggerTimeLine, self.OnTriggerBehaviourPlay, self)
end

StroyBattleSceneController.OnTriggerBehaviourPlay = function(self, doubleValue, longValue, stringValue, objectValue)
  -- function num : 0_1 , upvalues : _ENV, StroyBattleSceneController
  if stringValue == "BattleStart" then
    local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
    ;
    ((StroyBattleSceneController.super).OnSBattleStart)(self, protocol)
  end
end

StroyBattleSceneController.OnSBattleStart = function(self, protocol)
  -- function num : 0_2
end

StroyBattleSceneController.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : StroyBattleSceneController
  ((StroyBattleSceneController.super).OnDestroy)(self)
end

return StroyBattleSceneController

