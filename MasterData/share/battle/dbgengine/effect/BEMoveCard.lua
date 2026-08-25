local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEMoveCard, Super = System.NewClass("BEMoveCard", BattleEffectServer)

function BEMoveCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEMoveCard:DoEffect()
  Super.DoEffect(self)
  local to = self.params[1]
  local show = self.params[3] or 0
  local targetDeck = to:_GetDeckName()
  local discardCount = 0
  for _, card in ipairs(self.targets) do
    if card.deck == bc.CardDeck.HandDeck and card:GetProperty(bc.BattleProperty.Forcedretention) > 0 then
    else
      local fromDeck = card.deck
      local changeData = {
        casterRoleUid = self.cmdServer.castRoleUid,
        targetDeck = targetDeck,
        camp = to:GetCamp(),
        targetPos = self.params[2],
        show = show
      }
      self.battleEngine.cardMgr:MoveCardToDeck(card, changeData)
      if fromDeck == bc.CardDeck.HandDeck and targetDeck == bc.CardDeck.GraveyardDeck then
        discardCount = discardCount + 1
      end
    end
  end
  if self.cmdServer and discardCount > 0 then
    self.cmdServer:AddStats(bc.StatsKey.DiscardedCardCount, discardCount)
  end
  return true
end

return BEMoveCard
