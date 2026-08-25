local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BERevertChangedCard, Super = System.NewClass("BERevertChangedCard", BattleEffectServer)

function BERevertChangedCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERevertChangedCard:DoEffect()
  Super.DoEffect(self)
  if 0 == #self.targets then
    return false
  end
  local revertType = self.params and self.params[1] or bc.RevertType.SavedOrigin
  for _, card in ipairs(self.targets) do
    card:RevertChange(revertType)
  end
  return true
end

return BERevertChangedCard
