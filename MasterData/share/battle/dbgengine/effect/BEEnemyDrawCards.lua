local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEEnemyDrawCards, Super = System.NewClass("BEEnemyDrawCards", BattleEffectServer)

function BEEnemyDrawCards:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEEnemyDrawCards:DoEffect()
  Super.DoEffect(self)
  local drawNum = math.ceil(self.params[1] or 1)
  local camp = self.cmdServer:GetCasterCamp()
  local enemyCamp = bc.BattleCamp:GetEnemyCamp(camp)
  local reason = bc.CardDeckReason.BattleEffect
  self.battleEngine.cardMgr:DrawCards(drawNum, reason, enemyCamp)
  return true
end

return BEEnemyDrawCards
