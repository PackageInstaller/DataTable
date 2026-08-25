local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BESetGlobalVariable, Super = System.NewClass("BESetGlobalVariable", BattleEffectServer)

function BESetGlobalVariable:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESetGlobalVariable:DoEffect()
  Super.DoEffect(self)
  local argKey = self.params[1]
  local argValue = self.params[2]
  if not argKey then
    return false
  end
  self.battleEngine:SetGlobalVariable(argKey, argValue)
  return true
end

return BESetGlobalVariable
