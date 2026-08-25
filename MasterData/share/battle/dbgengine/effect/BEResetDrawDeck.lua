local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEResetDrawDeck, Super = System.NewClass("BEResetDrawDeck", BattleEffectServer)

function BEResetDrawDeck:DoEffect()
  Super.DoEffect(self)
  self.battleEngine.cardMgr:GenerateDrawDeck()
  return true
end

return BEResetDrawDeck
