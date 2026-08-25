local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEScarletBloodChange, Super = System.NewClass("BEScarletBloodChange", BattleEffectServer)

function BEScarletBloodChange:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEScarletBloodChange:DoEffect()
  Super.DoEffect(self)
  local changedValue = math.ceil(self.params[1] or 0)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local max = player:GetProperty(bc.BattleProperty.max_scarlet_blood_count)
  if max <= 0 then
    return false
  end
  local scarletBloodCount = player:GetProperty(bc.BattleProperty.scarlet_blood_count) or 0
  changedValue = self.cmdServer:GetShowScarletBlood(changedValue)
  scarletBloodCount = scarletBloodCount + changedValue
  local isFull = false
  local embryoCount = 0
  if max <= scarletBloodCount then
    embryoCount = math.floor(scarletBloodCount / max)
    scarletBloodCount = scarletBloodCount % max
    isFull = true
  elseif scarletBloodCount < 0 then
    scarletBloodCount = 0
  end
  local reason = bc.PropertyChangeReason.AttrModify
  local extraData = self:GetPropertyChangeSource(reason, scarletBloodCount)
  player.property:SetProperty(bc.BattleProperty.scarlet_blood_count, scarletBloodCount, extraData)
  if changedValue > 0 then
    local eventData = {
      changedValue = changedValue,
      castRoleUid = self.cmdServer and self.cmdServer.castRoleUid,
      cardUid = self.cmdServer and self.cmdServer.cardUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.GainScarletBlood, eventData)
  elseif changedValue < 0 then
    local eventData = {
      changedValue = -changedValue,
      castRoleUid = self.cmdServer and self.cmdServer.castRoleUid,
      cardUid = self.cmdServer and self.cmdServer.cardUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.ConsumeScarletBlood, eventData)
  end
  if isFull then
    local e1 = {
      changedValue = embryoCount,
      castRoleUid = self.cmdServer and self.cmdServer.castRoleUid,
      cardUid = self.cmdServer and self.cmdServer.cardUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.ScarletBloodFull, e1)
    local e2 = {
      changedValue = embryoCount * max,
      castRoleUid = self.cmdServer and self.cmdServer.castRoleUid,
      cardUid = self.cmdServer and self.cmdServer.cardUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.ConsumeScarletBlood, e2)
  end
  return true
end

return BEScarletBloodChange
