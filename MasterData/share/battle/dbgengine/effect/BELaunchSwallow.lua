local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BELaunchSwallow, Super = System.NewClass("BELaunchSwallow", BattleEffectServer)
local BP = bc.BattleProperty

function BELaunchSwallow:DoEffect()
  Super.DoEffect(self)
  local executeCmdId = self.params[1]
  local swallowNum = self.params[2] or 1
  local effectMaxNum = 999
  if not executeCmdId or not self.cmdServer then
    return false
  end
  local DT = self.battleEngine.battleDT
  local fromDeck = bc.CardDeck.HandDeck
  local targetDeck = bc.CardDeck.SwallowDeck
  local embyroApiCfg = DT.BattleApi.EmbryoCard
  local embyroId = embyroApiCfg.Data
  local embyroDoubleApiCfg = DT.BattleApi.EmbryoCardDouble
  local embyroDoubleId = embyroDoubleApiCfg.Data
  local embyroCardList = self.battleEngine.cardMgr:GetCardListByDeckAndID(fromDeck, embyroId)
  local embyroCardUidList = {}
  local swallow = false
  local embyroDoubleCardList = self.battleEngine.cardMgr:GetCardListByDeckAndID(fromDeck, embyroDoubleId)
  for _, double in ipairs(embyroDoubleCardList) do
    table.insert(embyroCardList, double)
  end
  local caster = self.battleEngine:GetObj(self.effectConfig.castRoleUid)
  if caster:IsRoleType(bc.RoleType.Awaker) then
    local unlimitEffectNum = caster:GetProperty(BP.unlimit_swallow)
    if unlimitEffectNum and unlimitEffectNum > 0 then
      effectMaxNum = unlimitEffectNum
      swallowNum = #embyroCardList
    end
  end
  local leftEffectNum = effectMaxNum
  for i = 1, swallowNum do
    local card = embyroCardList[i]
    if not card then
      break
    end
    swallow = true
    table.insert(embyroCardUidList, card.uid)
    local changeData = {
      casterRoleUid = self.cmdServer.castRoleUid,
      targetDeck = targetDeck
    }
    self.battleEngine.cardMgr:MoveCardToDeck(card, changeData)
    if leftEffectNum <= 0 then
      break
    end
    local baseTimes = 1
    if card.tid == embyroDoubleId then
      baseTimes = 2
    end
    local times = baseTimes
    if leftEffectNum < times then
      times = leftEffectNum
    end
    for j = 1, times do
      local childCmdServer = self.cmdServer:CreateChildCmdServer()
      local effectList = childCmdServer:GenerateEffectList(executeCmdId)
      for _, effectObj in ipairs(effectList) do
        effectObj:PreTrigger(self.cmdServer.triggerData)
      end
      self:__FireLaunchSwallow()
    end
    leftEffectNum = leftEffectNum - times
    if leftEffectNum <= 0 then
      break
    end
  end
  if not swallow then
    return false
  end
  local data = {
    effectType = self.effectConfig.effectType,
    cardUidList = embyroCardUidList
  }
  self.battleEngine.recordMgr:OnDoEffect(data)
  local roleUid = self.cmdServer.castRoleUid
  self.battleEngine.recordMgr:OnFloatingText(roleUid, "Float_Tip_BloodDevour", bc.FloatingTextType.PositiveTextAndIcon)
  return true
end

function BELaunchSwallow:__HasBreedBloodSpecialJob()
  if not self.battleEngine or not self.battleEngine.roleMgr then
    return false
  end
  local roleMgr = self.battleEngine.roleMgr
  if not roleMgr or not roleMgr.GetSpecialSchoolAwakerNum then
    return false
  end
  local num = roleMgr:GetSpecialSchoolAwakerNum("NewBloodSchoolAwakerList")
  return num and num > 0
end

function BELaunchSwallow:__FireLaunchSwallow()
  if not self:IsTriggerBST() then
    return
  end
  local castRoleUid = self.cmdServer.castRoleUid
  local castCardUid = self.cmdServer.cardUid
  local eventData = {castRoleUid = castRoleUid, castCardUid = castCardUid}
  self.battleEngine:CreateEventEffect(BattleLogicEvent.LaunchSwallow, eventData)
end

return BELaunchSwallow
