local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEChangeStress, Super = System.NewClass("BEChangeStress", BattleEffectServer)

function BEChangeStress:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEChangeStress:Dispose()
  Super.Dispose(self)
end

function BEChangeStress:DoEffect()
  Super.DoEffect(self)
  local value = self.params[1] or 0
  self.battleEngine:ChangeStress(value)
  local totalValue = self.battleEngine:GetStress()
  self.battleEngine.recordMgr:OnStressChange(value, totalValue)
  return true
end

return BEChangeStress
