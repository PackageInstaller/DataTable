local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEDestroyCard, Super = System.NewClass("BEDestroyCard", BattleEffectServer)

function BEDestroyCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEDestroyCard:Dispose()
  Super.Dispose(self)
end

function BEDestroyCard:DoEffect()
  Super.DoEffect(self)
  self.battleEngine.cardMgr:DestroyCards(self.targets, self.effectConfig.castRoleUid)
  return true
end

return BEDestroyCard
