local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BERemoveGlobalVariable, Super = System.NewClass("BERemoveGlobalVariable", BattleEffectServer)

function BERemoveGlobalVariable:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERemoveGlobalVariable:DoEffect()
  Super.DoEffect(self)
  local argKey = self.params[1]
  self.battleEngine:RemoveGlobalVariable(argKey)
  return true
end

return BERemoveGlobalVariable
