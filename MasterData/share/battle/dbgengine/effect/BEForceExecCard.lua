local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local ForceConsumeMode = bc.ForceConsumeMode
local BEForceExecCard, Super = System.NewClass("BEForceExecCard", BattleEffectServer)

function BEForceExecCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEForceExecCard:Dispose()
  Super.Dispose(self)
end

function BEForceExecCard:DoEffect()
  Super.DoEffect(self)
  if self.cmdServer then
    self.cmdServer:SetMemberValue("ForceExecCardHasSuccess", nil)
  end
  local consumeModeRaw = self.params and self.params[1]
  local consumeMode = tonumber(consumeModeRaw)
  if not consumeMode and type(consumeModeRaw) == "string" and self.cmdServer then
    consumeMode = tonumber(self.cmdServer:GetValueByCmd(consumeModeRaw))
  end
  if consumeMode ~= ForceConsumeMode.IgnoreCost and consumeMode ~= ForceConsumeMode.PartialPay and consumeMode ~= ForceConsumeMode.FullPay then
    consumeMode = ForceConsumeMode.FullPay
  end
  local cardList = self.targets or {}
  self.battleEngine:DebugS("[BEForceExecCard] start {effectUid} {consumeMode} {consumeModeRaw} {cardCount}", self.uid, consumeMode, consumeModeRaw, #cardList)
  if 0 == #cardList then
    self.battleEngine:DebugS("[BEForceExecCard] failed {effectUid} {reason}", self.uid, "no_card")
    if self.cmdServer then
      self.cmdServer:SetMemberValue("ForceExecCardHasSuccess", false)
    end
    return false
  end
  local hasSuccess = false
  for _, card in ipairs(cardList) do
    local ret, reason = self:UseOneCard(card, consumeMode)
    if ret then
      hasSuccess = true
      self.battleEngine:DebugS("[BEForceExecCard] success {effectUid} {cardUid} {cardTid} {ownerUid} {consumeMode}", self.uid, card.uid, card.tid, card.owner and card.owner.uid, consumeMode)
    else
      self.battleEngine:DebugS("[BEForceExecCard] skip {effectUid} {cardUid} {cardTid} {reason}", self.uid, card and card.uid, card and card.tid, reason or "unknown")
    end
  end
  if self.cmdServer then
    self.cmdServer:SetMemberValue("ForceExecCardHasSuccess", hasSuccess)
  end
  self.battleEngine:DebugS("[BEForceExecCard] finish {effectUid} {hasSuccess}", self.uid, hasSuccess and 1 or 0)
  return hasSuccess
end

function BEForceExecCard:UseOneCard(card, consumeMode)
  if not card or card.isDeleted then
    return false, "card_deleted_or_nil"
  end
  local owner = card:GetOwner()
  if not owner then
    return false, "card_owner_nil"
  end
  local cardUid = card.uid
  local ret, reason = owner:CanUseCard(cardUid)
  if not ret then
    local allowNoEnergyBypass = reason == bc.CardFailedReason.NoEnergy and (consumeMode ~= ForceConsumeMode.FullPay or card:IsXCost())
    if not allowNoEnergyBypass then
      return false, string.format("can_use_card_failed_%s", reason or "nil")
    end
  end
  local cmdServer = card:GetCardCmdServer()
  if cmdServer then
    cmdServer:SetMemberValue("ForceConsumeMode", consumeMode)
  end
  self.battleEngine:DebugS("[BEForceExecCard] card_exec {cardUid} {cardTid} {ownerUid} {ownerType} {consumeMode}", card.uid, card.tid, owner.uid, owner.roleType, consumeMode)
  local chainOk = owner:AppendUseCardEffectChain(cardUid, nil)
  if not chainOk then
    if cmdServer then
      cmdServer:SetMemberValue("ForceConsumeMode", nil)
    end
    return false, "card_hard_blocked_for_play"
  end
  self.battleEngine.recordMgr:OnCardInteract(cardUid, owner.camp, "CardForceUse")
  return true, "ok"
end

return BEForceExecCard
