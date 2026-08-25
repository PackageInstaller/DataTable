local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEGainKeeperEnergy, Super = System.NewClass("BEGainKeeperEnergy", BattleEffectServer)

function BEGainKeeperEnergy:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEGainKeeperEnergy:DoEffect()
  Super.DoEffect(self)
  local baseKeeperEnergy = math.ceil(self.params[1])
  local times = math.ceil(self.params[2] or 1)
  local reason = bc.PropertyChangeReason.AttrModify
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local value = self.cmdServer:GetRealKeeperEnergy(baseKeeperEnergy)
  for _ = 1, times do
    local extraData = self:GetPropertyChangeSource(reason, value)
    player:ChangeProperty(BP.keeper_energy, value, extraData)
  end
  return true
end

return BEGainKeeperEnergy
