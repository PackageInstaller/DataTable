local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local BattleEndTriggerController = class("BattleEndTriggerController", TriggerControllerBase)
local BattleEndTrigger = require("logic.scene.luaevent.trigger.basic.battleend.battleendtrigger")

function BattleEndTriggerController:Ctor(...)
  BattleEndTriggerController.super.Ctor(self, ...)
end

function BattleEndTriggerController:CreateTriggerInstance(id, eventid, battleid, expected, instant)
  return BattleEndTrigger.Create("battleend", id, eventid, battleid, expected, instant)
end

function BattleEndTriggerController:OnBattleEnd(info)
  self:CheckImpl(function(v)
    return v:IsInstant() == "Instant" or v:IsInstant() == true
  end, info)
end

function BattleEndTriggerController:OnReturnFromBattle(info)
  self:CheckImpl(function(v)
    return v:IsInstant() == "BeforeReturn"
  end, info)
end

function BattleEndTriggerController:OnBattleRewardEnd(info)
  self:CheckImpl(function(v)
    return not v:IsInstant() or v:IsInstant() == "AfterReturn"
  end, info)
end

return BattleEndTriggerController
