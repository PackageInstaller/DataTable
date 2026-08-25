local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEDrawCard, Super = System.NewClass("BEDrawCard", BattleEffectServer)

function BEDrawCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEDrawCard:DoEffect()
  Super.DoEffect(self)
  local drawNum = math.ceil(self.params[1] or 1)
  local reason = bc.CardDeckReason.BattleEffect
  local realDrawNum = self.battleEngine.cardMgr:DrawCards(drawNum, reason)
  self.cmdServer:AddStats(bc.StatsKey.DrawCardCount, realDrawNum)
  return true
end

return BEDrawCard
