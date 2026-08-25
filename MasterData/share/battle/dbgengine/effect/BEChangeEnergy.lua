local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeEnergy, Super = System.NewClass("BEChangeEnergy", BattleEffectServer)

function BEChangeEnergy:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeEnergy:Dispose()
  Super.Dispose(self)
end

function BEChangeEnergy:DoEffect()
  Super.DoEffect(self)
  local casterCamp = self.cmdServer:GetCasterCamp()
  local value = self.params[1] or 0
  local player = self.battleEngine.roleMgr:GetPlayer(casterCamp)
  if 0 == value then
    return true
  end
  local reason = bc.PropertyChangeReason.AttrModify
  local extraData = self:GetPropertyChangeSource(reason)
  local preValue = player:GetProperty(bc.BattleProperty.energy)
  local newValue = player:ChangeProperty(bc.BattleProperty.energy, value, extraData)
  local deltaValue = newValue - preValue
  local overflowValue = value > 0 and value - (newValue - preValue) or 0
  local eventData = {
    castRoleUid = self.cmdServer and self.cmdServer.castRoleUid,
    castCardUid = self.cmdServer and self.cmdServer.cardUid,
    targetRoleUid = player.uid,
    castValue = value,
    overflowValue = overflowValue,
    deltaValue = deltaValue,
    curValue = newValue,
    realCost = value
  }
  local eventType = value > 0 and BattleLogicEvent.GainEnergy or BattleLogicEvent.ConsumeEnergy
  eventData.castValue = math.abs(value)
  self.battleEngine:CreateEventEffect(eventType, eventData)
  if overflowValue > 0 then
    self.battleEngine:CreateEventEffect(BattleLogicEvent.OverFlowEnergy, eventData)
  end
  return true
end

return BEChangeEnergy
