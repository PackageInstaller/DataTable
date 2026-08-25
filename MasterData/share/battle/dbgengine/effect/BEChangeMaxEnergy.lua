local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEChangeMaxEnergy, Super = System.NewClass("BEChangeMaxEnergy", BattleEffectServer)

function BEChangeMaxEnergy:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeMaxEnergy:Dispose()
  Super.Dispose(self)
end

function BEChangeMaxEnergy:DoEffect()
  Super.DoEffect(self)
  local casterCamp = self.cmdServer:GetCasterCamp()
  local value = self.params[1] or 0
  local player = self.battleEngine.roleMgr:GetPlayer(casterCamp)
  local reason = bc.PropertyChangeReason.AttrModify
  local extraData = self:GetPropertyChangeSource(reason)
  if 0 ~= value then
    player.property:ChangeProperty(bc.BattleProperty.max_energy, value, extraData)
  end
  return true
end

return BEChangeMaxEnergy
