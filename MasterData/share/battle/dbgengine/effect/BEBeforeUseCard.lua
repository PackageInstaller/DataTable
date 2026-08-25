local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local ForceConsumeMode = bc.ForceConsumeMode
local BEBeforeUseCard, Super = System.NewClass("BEBeforeUseCard", BattleEffectServer)

function BEBeforeUseCard:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEBeforeUseCard:Dispose()
  Super.Dispose(self)
end

function BEBeforeUseCard:DoEffect()
  Super.DoEffect(self)
  local cardUid = self.effectConfig.cardUid
  local card = self.battleEngine:GetObj(cardUid)
  if not card then
    self.battleEngine:Error("使用卡牌前执行失败：找不到卡牌", cardUid)
    return false
  end
  self.battleEngine.cardMgr:InsertHistory(cardUid)
  self.battleEngine.cardMgr:InsertBoutHistory(cardUid)
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local castRoleUid = self.effectConfig.castRoleUid
  local cost = card:GetUseCost()
  local data = {
    cardUid = cardUid,
    deck = card.deck,
    castRoleUid = castRoleUid,
    castCardUid = cardUid,
    castValue = cost
  }
  self:__CostEnergy(card, data)
  self.battleEngine.recordMgr:OnUseCard(cardUid, curCamp)
  self:__FireBeforeUseCard(data)
  return true
end

function BEBeforeUseCard:__CostEnergy(card, data)
  local cost = data.castValue
  local castRoleUid = self.effectConfig.castRoleUid
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
  local attachPostParam = self.cmdServer:IsAttachPost()
  local consumeMode = ForceConsumeMode.FullPay
  if self.cmdServer:HasMemberValue("ForceConsumeMode") then
    consumeMode = tonumber(self.cmdServer:GetMemberValue("ForceConsumeMode")) or ForceConsumeMode.FullPay
  end
  local isForcePlayCard = self.cmdServer:HasMemberValue("ForceConsumeMode")
  local energyBefore = player:GetProperty(bc.BattleProperty.energy) or 0
  local realCost = 0
  local branch = "normal"
  if attachPostParam then
    branch = "attach_post"
    self.cmdServer.cmdParser:SetMemberValue("SkillIgnoreCost", 1)
    data.castValue = 0
    card.realCost = 0
  elseif isForcePlayCard and card:IsXCost() then
    branch = "force_x_variable_cost"
    self.cmdServer.cmdParser:SetMemberValue("SkillIgnoreCost", nil)
    local resolvedCost = card:ResolveVariableConsumeCost(energyBefore)
    realCost = player:ConsumeEnergy(resolvedCost, data, castRoleUid)
    data.castValue = realCost
    card.realCost = realCost
    card:AddConsumeEnergyStats(realCost)
  elseif consumeMode == ForceConsumeMode.IgnoreCost then
    branch = "force_free"
    self.cmdServer.cmdParser:SetMemberValue("SkillIgnoreCost", 1)
    data.castValue = 0
    card.realCost = 0
  elseif consumeMode == ForceConsumeMode.PartialPay then
    branch = "force_partial"
    self.cmdServer.cmdParser:SetMemberValue("SkillIgnoreCost", nil)
    local energy = player:GetProperty(bc.BattleProperty.energy) or 0
    local partialCost = cost
    if card:IsXCost() then
      partialCost = card:ResolveVariableConsumeCost(energy)
    else
      partialCost = math.min(energy, partialCost)
    end
    realCost = player:ConsumeEnergy(partialCost, data, castRoleUid)
    data.castValue = realCost
    card.realCost = realCost
    card:AddConsumeEnergyStats(realCost)
  elseif not player:EnergyEnough(cost) and card:AllowIgnoreCost() then
    branch = "allow_ignore_cost"
    self.cmdServer.cmdParser:SetMemberValue("SkillIgnoreCost", 1)
    data.castValue = 0
    card.realCost = 0
  else
    self.cmdServer.cmdParser:SetMemberValue("SkillIgnoreCost", nil)
    local consumeCost = cost
    if card:IsXCost() then
      local energy = player:GetProperty(bc.BattleProperty.energy) or 0
      consumeCost = card:ResolveVariableConsumeCost(energy)
    end
    realCost = player:ConsumeEnergy(consumeCost, data, castRoleUid)
    card.realCost = realCost
    card:AddConsumeEnergyStats(realCost)
  end
  local energyAfter = player:GetProperty(bc.BattleProperty.energy) or 0
  self.battleEngine:DebugS("[BEBeforeUseCard] cost_result {cardUid} {consumeMode} {branch} {baseCost} {realCost} {energyBefore} {energyAfter}", card.uid, consumeMode, branch, cost, realCost, energyBefore, energyAfter)
  self.cmdServer:SetMemberValue("ForceConsumeMode", nil)
end

function BEBeforeUseCard:__FireBeforeUseCard(data)
  if not self:IsTriggerBST() then
    return
  end
  local beforeEffectType = bc.BattleEffectType.BESendEvent
  local beforeEffectConfig = {
    effectType = beforeEffectType,
    eventId = BattleLogicEvent.BeforeUseCard,
    eventData = data
  }
  self.battleEngine.effectMgr:CreateEffect(beforeEffectConfig)
end

return BEBeforeUseCard
