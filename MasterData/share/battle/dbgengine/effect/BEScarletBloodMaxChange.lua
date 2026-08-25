local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEScarletBloodMaxChange, Super = System.NewClass("BEScarletBloodMaxChange", BattleEffectServer)

function BEScarletBloodMaxChange:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BEScarletBloodMaxChange:DoEffect()
  Super.DoEffect(self)
  local changedValue = self.params[1] or 0
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local reason = bc.PropertyChangeReason.AttrModify
  local extraData = self:GetPropertyChangeSource(reason)
  player:ChangeProperty(bc.BattleProperty.scarlet_blood_count, changedValue, extraData)
  return true
end

return BEScarletBloodMaxChange
