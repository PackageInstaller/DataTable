local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEResetDrawDeckPVP, Super = System.NewClass("BEResetDrawDeckPVP", BattleEffectServer)

function BEResetDrawDeckPVP:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEResetDrawDeckPVP:DoEffect()
  Super.DoEffect(self)
  local camp = self.cmdServer:GetCasterCamp()
  self.battleEngine.cardMgr:GenerateDrawDeck(camp)
  return true
end

return BEResetDrawDeckPVP
