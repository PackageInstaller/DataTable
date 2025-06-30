-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/battleend/battleendtriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local BattleEndTriggerController = class("BattleEndTriggerController", TriggerControllerBase)
local BattleEndTrigger = require("logic.scene.luaevent.trigger.basic.battleend.battleendtrigger")
BattleEndTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleEndTriggerController
  ((BattleEndTriggerController.super).Ctor)(self, ...)
end

BattleEndTriggerController.CreateTriggerInstance = function(self, id, eventid, battleid, expected, instant)
  -- function num : 0_1 , upvalues : BattleEndTrigger
  return (BattleEndTrigger.Create)("battleend", id, eventid, battleid, expected, instant)
end

BattleEndTriggerController.OnBattleEnd = function(self, info)
  -- function num : 0_2
  self:CheckImpl(function(v)
    -- function num : 0_2_0
    do return v:IsInstant() == "Instant" or v:IsInstant() == true end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, info)
end

BattleEndTriggerController.OnReturnFromBattle = function(self, info)
  -- function num : 0_3
  self:CheckImpl(function(v)
    -- function num : 0_3_0
    do return v:IsInstant() == "BeforeReturn" end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, info)
end

BattleEndTriggerController.OnBattleRewardEnd = function(self, info)
  -- function num : 0_4
  self:CheckImpl(function(v)
    -- function num : 0_4_0
    do return not v:IsInstant() or v:IsInstant() == "AfterReturn" end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
, info)
end

return BattleEndTriggerController

