local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BEFunctionEffect, Super = System.NewClass("BEFunctionEffect", BattleEffectServer)

function BEFunctionEffect:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEFunctionEffect:Dispose()
  Super.Dispose(self)
end

function BEFunctionEffect:DoEffect()
  Super.DoEffect(self)
  local func = self.effectConfig.func
  local funcTarget = self.effectConfig.funcTarget
  local funcArgs = self.effectConfig.funcArgs
  func(funcTarget, table.unpack(funcArgs))
  return true
end

return BEFunctionEffect
