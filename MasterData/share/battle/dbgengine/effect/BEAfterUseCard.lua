local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleRenderEvent = require("Battle.DbgEngine.Event.BattleRenderEvent")
local BEAfterUseCard, Super = System.NewClass("BEAfterUseCard", BattleEffectServer)

function BEAfterUseCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEAfterUseCard:Dispose()
  Super.Dispose(self)
end

function BEAfterUseCard:DoEffect()
  Super.DoEffect(self)
  local cardUid = self.effectConfig.cardUid
  local curCard = self.battleEngine:GetObj(cardUid)
  if not curCard then
    return false
  end
  curCard:ClearCmdServerStats()
  local targetDeck = self.effectConfig.TargetCardDeck
  if not targetDeck then
    local consume = curCard:GetProperty(bc.BattleProperty.consume)
    if curCard:CardTypeMatch(bc.SkillType.Card_Awake) then
      targetDeck = bc.CardDeck.AwakeDeck
    elseif consume and consume > 0 then
      targetDeck = bc.CardDeck.ConsumedDeck
    elseif curCard:IsFromAttachPost() then
      targetDeck = bc.CardDeck.ConsumedDeck
    else
      targetDeck = bc.CardDeck.GraveyardDeck
    end
  end
  local camp = self.effectConfig.camp
  self.battleEngine.recordMgr:OnAfterUseCard(cardUid, targetDeck, nil, camp)
  local changeData = {
    castRoleUid = self.effectConfig.castRoleUid,
    changeReason = bc.CardDeckReason.Use,
    targetDeck = targetDeck,
    camp = camp
  }
  self.battleEngine.cardMgr:MoveCardToDeck(curCard, changeData)
  if self.cmdServer then
    local usedCardStats = self.cmdServer:GetStats(bc.StatsKey.UsedCardCount) or {}
    usedCardStats[curCard.tid] = (usedCardStats[curCard.tid] or 0) + 1
    self.cmdServer:AddStats(bc.StatsKey.UsedCardCount, usedCardStats)
    if curCard:CardTypeMatch(bc.SkillType.Card_Strike) then
      self.cmdServer:AddStats(bc.StatsKey.StrikeCardUsedCount, 1)
    end
  end
  self:__FireAfterUseCard(targetDeck)
  self:__SendAfterAttachPostAction()
  return true
end

function BEAfterUseCard:__FireAfterUseCard(targetDeck)
  if not self:IsTriggerBST() then
    return
  end
  local cardUid = self.effectConfig.cardUid
  local castRoleUid = self.effectConfig.castRoleUid
  local camp = self.effectConfig.camp
  local eventData = {
    deck = targetDeck,
    cardUid = cardUid,
    castRoleUid = castRoleUid,
    camp = camp
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterUseCard, eventData)
end

function BEAfterUseCard:EffectEnd()
  Super.EffectEnd(self)
  local cardUid = self.effectConfig.cardUid
  local curCard = self.battleEngine:GetObj(cardUid)
  if curCard then
    curCard:ClearDamageTargets()
  end
  self.battleEngine:SetCurCard(nil)
  local actionType = bc.ActionType.UseCard
  self.battleEngine.roleMgr:AfterAction(actionType)
end

function BEAfterUseCard:__SendAfterAttachPostAction()
  local cardUid = self.effectConfig.cardUid
  local curCard = self.battleEngine:GetObj(cardUid)
  if not curCard or not curCard:IsFromAttachPost() then
    return
  end
  local attachEventData = {
    executorUid = curCard:GetOwnerUid(),
    cmdServerUid = curCard.cmdServer.uid,
    skillTid = curCard.data.tid
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterAttachPostAction, attachEventData)
end

return BEAfterUseCard
