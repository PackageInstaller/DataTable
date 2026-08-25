local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeAttr, Super = System.NewClass("BEChangeAttr", BattleEffectServer)

function BEChangeAttr:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeAttr:Dispose()
  Super.Dispose(self)
end

function BEChangeAttr:GetFixValueByPropertyType(propertyType, value)
  if propertyType == BP.ulti_energy then
    value = self:CalFinalVal(value)
  end
  return value
end

function BEChangeAttr:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local propertyType = self.fixArg
  local baseValue = math.ceil(self.params[1] or 0)
  baseValue = math.ceil(self:GetFixValueByPropertyType(propertyType, baseValue))
  local reason = bc.PropertyChangeReason.AttrModify
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local extraData = self:GetPropertyChangeSource(reason)
  for _, target in ipairs(targets) do
    if (propertyType == BP.hp or propertyType == BP.max_hp) and target:HpIs0() then
    else
      local value = baseValue
      if propertyType == BP.hp and value < 0 then
        if (target:GetProperty(BP.immue_change_hp) or 0) > 0 then
          value = 0
        elseif (target:GetProperty(BP.be_change_hp_limit) or 0) > 0 then
          local maxLoseHp = target:GetProperty(BP.be_change_hp_limit)
          local loseHp = math.abs(value)
          if maxLoseHp < loseHp then
            value = -maxLoseHp
          end
        end
      end
      local preValue = target:GetProperty(propertyType)
      target.property:ChangeProperty(propertyType, value, extraData)
      local newValue = target:GetProperty(propertyType)
      local deltaValue = newValue - preValue
      local overflowValue = value > 0 and value - (newValue - preValue) or 0
      if target:is(BattleCardServer) and propertyType == bc.CardProperty.card_cost then
        local cost = target:GetCurCost()
        self.battleEngine.recordMgr:OnModifyCardCost(target.deck, target.uid, value, cost)
      end
      local castRoleUid = self.cmdServer and self.cmdServer.castRoleUid
      local castCardUid = self.cmdServer and self.cmdServer.cardUid
      local targetRoleUid, targetCardUid
      if target:is(BattleCardServer) then
        targetRoleUid = player.uid
        targetCardUid = target.uid
      else
        targetRoleUid = target.uid
      end
      local eventData = {
        castRoleUid = castRoleUid,
        castCardUid = castCardUid,
        targetRoleUid = targetRoleUid,
        targetCardUid = targetCardUid,
        castValue = value,
        overflowValue = overflowValue,
        deltaValue = deltaValue,
        cmdServerUid = self.cmdServer and self.cmdServer.uid
      }
      if propertyType == bc.AwakerProperty.ulti_energy and value > 0 then
        self.battleEngine:CreateEventEffect(BattleLogicEvent.DoUltiEnergy, eventData)
        self.battleEngine:CreateEventEffect(BattleLogicEvent.BeUltiEnergy, eventData)
      end
      if propertyType == bc.RoleProperty.death_resist and value > 0 then
        self.battleEngine:CreateEventEffect(BattleLogicEvent.GainDeathResist, eventData)
      end
      if propertyType == bc.RoleProperty.hp and deltaValue < 0 then
        self.battleEngine:CreateEventEffect(BattleLogicEvent.HpDown, eventData)
      end
      if propertyType == bc.RoleProperty.hp then
        self.battleEngine:CreateEventEffect(BattleLogicEvent.BEChangeAttrHp, eventData)
        target:CheckDeathEvent(self.cmdServer.castRoleUid, self.cmdServer.uid)
      end
      if propertyType == bc.RoleProperty.block then
        self.battleEngine:CreateEventEffect(BattleLogicEvent.BEChangeAttrBlock, eventData)
      end
    end
  end
  return true
end

return BEChangeAttr
