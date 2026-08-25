local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleCmdCardListExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdCardListExp")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BP = bc.BattleProperty
local BattleCardMgrServer, Super = System.NewClass("BattleCardMgrServer", BattleEngineComponent)
BattleCardMgrServer.CheckDeckMaxFunc = {
  [bc.CardDeck.HandDeck] = function(cardMgr)
    return #cardMgr.data.cardData[bc.CardDeck.HandDeck] >= cardMgr:GetMaxHandDeckNum()
  end,
  [bc.CardDeck.DimensionDeck] = function(cardMgr)
    local player = cardMgr.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    local slotMax = player:GetProperty(BP.dimension_slot)
    return slotMax <= #cardMgr.data.cardData[bc.CardDeck.DimensionDeck]
  end,
  [bc.CardDeck.MonsterDimensionDeck] = function(cardMgr)
    local slotMax = cardMgr.battleEngine.roleMgr:GetMonsterDimensionMax()
    return slotMax <= #cardMgr.data.cardData[bc.CardDeck.MonsterDimensionDeck]
  end
}

function BattleCardMgrServer:ctor(battleEngine)
  Super.ctor(self, battleEngine)
end

function BattleCardMgrServer:ctorData()
  local data = Super.ctorData(self)
  data.cardData = {}
  data.allCardMap = {}
  data.totalShuffleTimes = 0
  data.awakerSlotCardLevels = {}
  data.drawCardNum = bc.BattleAttrConst.DrawCardNum
  data.enternalCards = {}
  data.destroyedCards = {}
  data.highlightCards = {}
  data.show_history = {}
  data.origin_history = {}
  data.copy_history = {}
  for _, v in pairs(bc.CardDeck) do
    data.cardData[v] = {}
  end
  return data
end

function BattleCardMgrServer:GetCardListByDeck(deck)
  return self.data.cardData[deck] or {}
end

function BattleCardMgrServer:GetAllCardList()
  return self.data.cardData
end

function BattleCardMgrServer:GetHandCardUidList()
  local cardList = self.data.cardData[bc.CardDeck.HandDeck]
  local uidList = {}
  for _, card in ipairs(cardList) do
    table.insert(uidList, card)
  end
  return uidList
end

function BattleCardMgrServer:GetCardListByDeckAndID(deck, id)
  local ret = {}
  for _, uid in ipairs(self.data.cardData[deck]) do
    local card = self:GetCardByUid(uid)
    if card.tid == id then
      table.insert(ret, card)
    end
  end
  return ret
end

function BattleCardMgrServer:GetCardUidsByDeck(deck)
  local list = {}
  for _, card in ipairs(self.data.cardData[deck] or {}) do
    table.insert(list, card)
  end
  return list
end

function BattleCardMgrServer:GetCardByUid(cardUid)
  local card = self.battleEngine:GetObj(cardUid)
  if System.is(card, BattleCardServer) then
    return card
  end
  return nil
end

function BattleCardMgrServer:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutBegin, self.OnBeforeBoutBegin, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFDrawCards, self.OnBFDrawCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFDiscardCards, self.OnBFDiscardCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleEnd, self.OnBattleEnd, self)
end

function BattleCardMgrServer:OnBeforeBoutBegin()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 then
    local copy_history = self.data.copy_history
    local origin_history = self.data.origin_history
    table.insert(copy_history, {})
    table.insert(origin_history, {})
    if #copy_history > 9 then
      table.remove(copy_history, 1)
    end
    if #origin_history > 9 then
      table.remove(origin_history, 1)
    end
  end
end

function BattleCardMgrServer:ChangeDrawCardNum(changeValue)
  self.data.drawCardNum = self.data.drawCardNum + changeValue
end

function BattleCardMgrServer:OnBFDrawCards()
  self.data.highlightCards = {}
  local isExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  if self.battleEngine.boutMgr.camp == bc.BattleCamp.Camp1 and not isExtraBout then
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    local drawCardNumAttr = player:GetProperty("draw_card_num")
    local drawCardNum = drawCardNumAttr + self.data.drawCardNum
    self:DrawCards(drawCardNum)
  end
  if isExtraBout then
    local handUidList = {}
    local comsumeUidList = {}
    local curHandCount = #self.data.cardData[bc.CardDeck.HandDeck]
    local maxHandCount = self:GetMaxHandDeckNum()
    local removeDimensionList = {}
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    local changeData = {
      changeReason = bc.CardDeckReason.ExtraBout,
      castRoleUid = player.uid
    }
    for index, uid in ipairs(self.data.cardData[bc.CardDeck.DimensionDeck]) do
      local card = self:GetCardByUid(uid)
      table.insert(removeDimensionList, card.uid)
      if maxHandCount >= curHandCount + index then
        table.insert(self.data.cardData[bc.CardDeck.HandDeck], card.uid)
        card:ChangeCardDeck(bc.CardDeck.HandDeck, changeData)
        table.insert(handUidList, card.uid)
      else
        table.insert(self.data.cardData[bc.CardDeck.ConsumedDeck], card.uid)
        card:ChangeCardDeck(bc.CardDeck.ConsumedDeck, changeData)
        table.insert(comsumeUidList, card.uid)
      end
    end
    self.data.cardData[bc.CardDeck.DimensionDeck] = {}
    local eventData = {cardUidList = removeDimensionList}
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardRemoveDimension, eventData)
    self.battleEngine.recordMgr:OnChangeCardListDeck(handUidList, bc.CardDeck.DimensionDeck, bc.CardDeck.HandDeck, nil, bc.CardDeckReason.ExtraBout, bc.BattleCamp.Camp1)
    if next(comsumeUidList) ~= nil then
      self.battleEngine.recordMgr:OnChangeCardListDeck(comsumeUidList, bc.CardDeck.DimensionDeck, bc.CardDeck.ConsumedDeck, nil, bc.CardDeckReason.ExtraBout, bc.BattleCamp.Camp1)
    end
  end
end

function BattleCardMgrServer:OnBFDiscardCards()
  self.discardCount = 0
  self.consumeCount = 0
  if self.battleEngine.boutMgr.camp == bc.BattleCamp.Camp1 then
    local discardCount, consumeCount = self:DiscardAllCards()
    self.discardCount = discardCount
    self.consumeCount = consumeCount
    self.highlightList = {}
  end
end

function BattleCardMgrServer:InsertHistory(cardUid, roleUid, skillToCard)
  if cardUid or skillToCard then
    if #self.data.show_history >= bc.MaxHistory then
      table.remove(self.data.show_history, 1)
    end
    local data
    if cardUid then
      local card = self:GetCardByUid(cardUid)
      if card then
        data = card:Serialize()
      end
    elseif skillToCard then
      data = skillToCard
    end
    if data then
      table.insert(self.data.show_history, data)
      self.battleEngine.recordMgr:OnInsertHistory(data)
    end
  end
end

function BattleCardMgrServer:InsertBoutHistory(cardUid)
  local card = self.battleEngine:GetObj(cardUid)
  if not card then
    return
  end
  local copy_history = self.data.copy_history
  local origin_history = self.data.origin_history
  local specialOwnerUid = card.specialOwner and card.specialOwner.uid
  local cardTypes = card:GetType()
  local cardHistoryInfo = {
    card.tid,
    card.level,
    card.camp,
    specialOwnerUid,
    card.data.performSkillId,
    cardTypes
  }
  table.insert(copy_history[#copy_history], cardHistoryInfo)
  table.insert(origin_history[#origin_history], cardUid)
end

function BattleCardMgrServer:CheckHistoryCardParam(historyType, cardTypes, endNum, beginNum)
  local historyList
  if historyType == bc.HistoryType.Origin then
    historyList = self.data.origin_history
  elseif historyType == bc.HistoryType.Copy then
    historyList = self.data.copy_history
  end
  if type(cardTypes) == "string" then
    cardTypes = {cardTypes}
  end
  endNum = endNum or 0
  beginNum = beginNum or 0
  if endNum > beginNum then
    self.battleEngine:Error("获取PVE历史卡牌参数有误，参数2比参数3大", endNum, beginNum)
    endNum = beginNum
  end
  return historyList, cardTypes, endNum, beginNum
end

function BattleCardMgrServer:GetHistoryCard(value, historyType)
  if historyType == bc.HistoryType.Origin then
    do return self.battleEngine.GetObj, self.battleEngine end
    return self.battleEngine.GetObj, self.battleEngine, value, nil, nil, nil, nil, nil
  end
  if historyType == bc.HistoryType.Copy then
    local owner = self.battleEngine:GetObj(value[4])
    local cardTypes = value[6]
    local addConfig = {
      camp = value[3],
      owner = owner,
      performSkillId = value[5],
      cardTypes = cardTypes
    }
    local cards = self:AddNewCard({
      {
        tid = value[1],
        level = value[2]
      }
    }, bc.CardDeck.NoneDeck, addConfig)
    return cards[1]
  end
end

function BattleCardMgrServer:GetBoutHistoryCard(historyType, cardTypes, endNum, beginNum, needNum, skipSameID, exceptCardTypes, exceptStateTids)
  local historyList
  historyList, cardTypes, endNum, beginNum = self:CheckHistoryCardParam(historyType, cardTypes, endNum, beginNum)
  local length = #historyList
  local beginIdx = math.max(0, length - beginNum)
  local endIdx = math.max(0, length - endNum)
  local ret = {}
  local getUids = {}
  local getIds = {}
  local stateMgr = self.battleEngine.stateMgr
  local needStateFilter = exceptStateTids and 0 ~= exceptStateTids
  if needStateFilter and type(exceptStateTids) ~= "table" then
    exceptStateTids = {exceptStateTids}
  end
  for i = endIdx, beginIdx, -1 do
    if needNum <= 0 then
      break
    end
    local list = historyList[i]
    if not list then
      break
    end
    for j = #list, 1, -1 do
      if needNum <= 0 then
        break
      end
      local value = list[j]
      if getUids[value] and historyType == bc.HistoryType.Origin then
      else
        local card = self:GetHistoryCard(value, historyType)
        if not card then
        elseif 1 == skipSameID and getIds[card.tid] then
        else
          local typeMatched = card:CardTypeMatch(cardTypes)
          local exceptMatched = card:CardTypeMatch(exceptCardTypes)
          if typeMatched and not exceptMatched then
            if needStateFilter then
              local hasAnyState = stateMgr:HasStateByStateIds(card.uid, exceptStateTids)
              if hasAnyState then
            end
            else
              table.insert(ret, card)
              getUids[value] = true
              getIds[card.tid] = true
              needNum = needNum - 1
            end
          end
        end
      end
    end
  end
  return ret
end

function BattleCardMgrServer:InitAllCards(cardDataList)
  for _, config in ipairs(cardDataList) do
    config.isOrigin = true
    local card = BattleCardServer(self.battleEngine, config)
    table.insert(self.data.cardData[card.deck], card.uid)
    self.data.allCardMap[card.uid] = card.uid
  end
end

function BattleCardMgrServer:AfterBattleBegin()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  for _, awaker in ipairs(player:GetAwakerList()) do
    for slot, slotCard in pairs(awaker.slots) do
      if "Slot_Super" == slot then
      else
        self.data.awakerSlotCardLevels[slotCard.tid] = slotCard.level
      end
    end
  end
end

function BattleCardMgrServer:GetCardLevelByID(id)
  if not self.data.initAwakerSlotCardLevels then
    self.data.initAwakerSlotCardLevels = true
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    for _, awaker in ipairs(player:GetAwakerList()) do
      for slot, slotCard in pairs(awaker.data.slots or {}) do
        if "Slot_Super" == slot then
        else
          self.data.awakerSlotCardLevels[slotCard.tid] = slotCard.level
        end
      end
    end
  end
  return self.data.awakerSlotCardLevels[id] or 1
end

function BattleCardMgrServer:BattleBeginShuffleCard()
  local subIndex = 1
  local deckCards = self.data.cardData[bc.CardDeck.DrawDeck]
  self:ShuffleCardsByDeck(bc.CardDeck.DrawDeck)
  for i, uid in ipairs(deckCards) do
    local card = self:GetCardByUid(uid)
    if card:GetProperty(BP.inherent) > 0 then
      local tmpCard = deckCards[subIndex]
      deckCards[subIndex] = card.uid
      deckCards[i] = tmpCard
      subIndex = subIndex + 1
    end
  end
end

function BattleCardMgrServer:UpdateCardArgs()
  local syncData = {}
  for deckName, deck in pairs(self.data.cardData) do
    if bc.CardArgsSyncDeck[deckName] then
      for _, uid in ipairs(deck) do
        print("UpdateCardArgs ", uid, deckName)
        local card = self:GetCardByUid(uid)
        local cardArgs, descArgs = card:UpdateCardArgs()
        if cardArgs then
          syncData[card.uid] = {cardArgs = cardArgs, descArgs = descArgs}
        end
      end
    end
  end
  if next(syncData) ~= nil then
    self.battleEngine.recordMgr:OnUpdateCardArgs(syncData)
  end
end

function BattleCardMgrServer:GetAllCardData()
  local cardList = {}
  for _, deck in pairs(self.data.cardData) do
    for _, uid in ipairs(deck) do
      local card = self:GetCardByUid(uid)
      if card then
        table.insert(cardList, card:Serialize())
      end
    end
  end
  return cardList
end

function BattleCardMgrServer:Serialize()
  local enternalCardList = {}
  for _, uid in ipairs(self.data.enternalCards) do
    local card = self:GetCardByUid(uid)
    table.insert(enternalCardList, card:Serialize())
  end
  local destroyCardList = {}
  for _, uid in ipairs(self.data.destroyedCards) do
    local card = self:GetCardByUid(uid)
    table.insert(destroyCardList, card:Serialize())
  end
  return {
    cardDataList = self:GetAllCardData(),
    enternalCardDataList = enternalCardList,
    destroyCardDataList = destroyCardList,
    history = self.data.history
  }
end

function BattleCardMgrServer:OnSnapShot()
  local cardDataList = {}
  local duplicateCardUidList = {}
  local notFoundCardUidList = {}
  for _, deck in pairs(self.data.cardData) do
    for _, uid in ipairs(deck) do
      duplicateCardUidList[uid] = true
    end
  end
  for _, uid in ipairs(self.data.enternalCards) do
    duplicateCardUidList[uid] = true
  end
  for _, uid in ipairs(self.data.destroyedCards) do
    duplicateCardUidList[uid] = true
  end
  for uid in pairs(duplicateCardUidList) do
    local card = self:GetCardByUid(uid)
    if card then
      table.insert(cardDataList, card:OnSnapShot())
    else
      table.insert(notFoundCardUidList, uid)
    end
  end
  table.sort(cardDataList, function(a, b)
    return a.uid < b.uid
  end)
  if next(notFoundCardUidList) then
    self.battleEngine:Warn("卡牌不存在: %s", table.tostring(notFoundCardUidList))
  end
  return {
    cardDataList = cardDataList,
    data = self.data
  }
end

function BattleCardMgrServer:OnRecover(cardData)
  if cardData.data then
    self.data = cardData.data
  end
  local oldCardMap = self.data.allCardMap
  self.data.allCardMap = {}
  local allCardMap = self.data.allCardMap
  for _, cardInfo in ipairs(cardData.cardDataList or {}) do
    local card = BattleCardServer(self.battleEngine, cardInfo)
    card:OnRecover(cardInfo)
    allCardMap[card.uid] = card.uid
    oldCardMap[card.uid] = nil
  end
  self.battleEngine:Info("卡牌恢复完成: %s 张卡 残留卡牌:%s", #(cardData.cardDataList or {}), table.tostring(oldCardMap))
end

function BattleCardMgrServer:ClearCardShuffleTag()
  for _, deck in pairs(self.data.cardData) do
    for _, uid in ipairs(deck) do
      local card = self:GetCardByUid(uid)
      if card then
        card.shuffled = false
      end
    end
  end
end

function BattleCardMgrServer:GenerateDrawDeck()
  self:ShuffleCardFromGraveyardToDeck()
end

function BattleCardMgrServer:ShuffleCardFromGraveyardToDeck()
  local shuffleCardsCount = 0
  local changeReason = bc.CardDeckReason.Shuffle
  local list = {}
  local graveyardCardUidList = {}
  for index = #self.data.cardData[bc.CardDeck.GraveyardDeck], 1, -1 do
    local uid = self.data.cardData[bc.CardDeck.GraveyardDeck][index]
    local card = self:GetCardByUid(uid)
    if card.shuffled then
    else
      table.remove(self.data.cardData[bc.CardDeck.GraveyardDeck], index)
      table.insert(list, card)
      table.insert(graveyardCardUidList, card.uid)
      shuffleCardsCount = shuffleCardsCount + 1
      card.shuffled = true
    end
  end
  if 0 == #list then
    return
  end
  BattleUtilServer.Shuffle(self.battleEngine, list)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local changeData = {
    changeReason = changeReason,
    castRoleUid = player.uid
  }
  for _, card in ipairs(list) do
    table.insert(self.data.cardData[bc.CardDeck.DrawDeck], card.uid)
    card:ChangeCardDeck(bc.CardDeck.DrawDeck, changeData)
  end
  self.data.totalShuffleTimes = self.data.totalShuffleTimes + 1
  local eventData = {
    totalShuffleTimes = self.data.totalShuffleTimes,
    shuffleCardsCount = shuffleCardsCount,
    ownerCamp = bc.BattleCamp.Camp1
  }
  self.battleEngine:CreateEventEffect(BattleLogicEvent.ShuffleCards, eventData)
  self.battleEngine.recordMgr:OnChangeCardListDeck(graveyardCardUidList, bc.CardDeck.GraveyardDeck, bc.CardDeck.DrawDeck, true, changeReason, bc.BattleCamp.Camp1)
  self.battleEngine.recordMgr:OnShuffleCard(bc.BattleCamp.Camp1)
end

function BattleCardMgrServer:DrawCards(num, changeReason)
  if num > #self.data.cardData[bc.CardDeck.DrawDeck] then
    self:GenerateDrawDeck()
  end
  local drawCardUidList = {}
  local discardCardUidList = {}
  local drawNum = num
  if drawNum > #self.data.cardData[bc.CardDeck.DrawDeck] then
    drawNum = #self.data.cardData[bc.CardDeck.DrawDeck]
  end
  local handCardNum = #self.data.cardData[bc.CardDeck.HandDeck]
  local maxHandCount = self:GetMaxHandDeckNum()
  local discardNum = 0
  if maxHandCount < handCardNum + drawNum then
    discardNum = math.min(handCardNum + drawNum - maxHandCount, drawNum)
  end
  if 0 ~= discardNum then
    drawNum = maxHandCount - handCardNum
  end
  changeReason = changeReason or bc.CardDeckReason.Draw
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local changeData = {
    changeReason = changeReason,
    castRoleUid = player.uid
  }
  for _ = 1, drawNum do
    local targetDeck = bc.CardDeck.HandDeck
    local uid = table.remove(self.data.cardData[bc.CardDeck.DrawDeck], 1)
    local card = self:GetCardByUid(uid)
    table.insert(self.data.cardData[targetDeck], uid)
    card:ChangeCardDeck(targetDeck, changeData)
    if targetDeck == bc.CardDeck.HandDeck then
      table.insert(drawCardUidList, card.uid)
    else
      table.insert(discardCardUidList, card.uid)
    end
  end
  if next(drawCardUidList) then
    self.battleEngine.recordMgr:OnChangeCardListDeck(drawCardUidList, bc.CardDeck.DrawDeck, bc.CardDeck.HandDeck, nil, changeReason, bc.BattleCamp.Camp1)
  end
  if next(discardCardUidList) then
    self.battleEngine.recordMgr:OnChangeCardListDeck(discardCardUidList, bc.CardDeck.DrawDeck, bc.CardDeck.GraveyardDeck, nil, changeReason, bc.BattleCamp.Camp1)
  end
  self.battleEngine:LogBattleWithTab("抽牌: %s", drawNum)
  self.battleEngine:LogBattleWithTab("手牌数: %s -> %s", handCardNum, #self.data.cardData[bc.CardDeck.HandDeck])
  self:PrintDebugLog()
  return drawNum
end

function BattleCardMgrServer:SetCurUseCard(card, castRoleUid)
  local castRole = self.battleEngine:GetObj(castRoleUid)
  local castRoleName = "无"
  if castRole then
    castRoleName = castRole:GetBattleLogName()
  end
  self.battleEngine:LogBattleWithTab("%s 打出卡牌: %s ", castRoleName, card:GetBattleLogName())
  self.battleEngine:SetCurCard(card.uid)
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local changeData = {
    castRoleUid = castRoleUid,
    targetDeck = bc.CardDeck.UsingDeck,
    camp = curCamp
  }
  self:MoveCardToDeck(card, changeData)
end

function BattleCardMgrServer:GetCampCardData()
  return self.data.cardData
end

function BattleCardMgrServer:DiscardAllCards()
  local discardCardUidList = {}
  local consumCardUidList = {}
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local changeReason = bc.CardDeckReason.Discard
  local changeData = {
    changeReason = changeReason,
    castRoleUid = player.uid
  }
  local keepCards = {}
  local noDiscard = player:GetProperty("no_discard_card") > 0
  for _, cardUid in ipairs(self.data.cardData[bc.CardDeck.HandDeck]) do
    local card = self.battleEngine:GetObj(cardUid)
    local nothingness = card:GetProperty(bc.BattleProperty.nothingness) > 0
    if nothingness then
      local targetDeck = bc.CardDeck.ConsumedDeck
      table.insert(consumCardUidList, card.uid)
      table.insert(self.data.cardData[targetDeck], 1, card.uid)
      card:ChangeCardDeck(targetDeck, changeData)
    else
      local forcedRetention = card:GetProperty(bc.BattleProperty.Forcedretention) > 0
      if card:GetProperty(bc.BattleProperty.reserve) > 0 or forcedRetention or noDiscard then
        table.insert(keepCards, card.uid)
      else
        local targetDeck = bc.CardDeck.GraveyardDeck
        table.insert(discardCardUidList, card.uid)
        table.insert(self.data.cardData[targetDeck], 1, card.uid)
        card:ChangeCardDeck(targetDeck, changeData)
      end
    end
  end
  self.data.cardData[bc.CardDeck.HandDeck] = keepCards
  if next(discardCardUidList) ~= nil then
    self.battleEngine.recordMgr:OnChangeCardListDeck(discardCardUidList, bc.CardDeck.HandDeck, bc.CardDeck.GraveyardDeck, nil, changeReason, bc.BattleCamp.Camp1)
  end
  if next(consumCardUidList) ~= nil then
    self.battleEngine.recordMgr:OnChangeCardListDeck(consumCardUidList, bc.CardDeck.HandDeck, bc.CardDeck.ConsumedDeck, nil, changeReason, bc.BattleCamp.Camp1)
  end
  return #discardCardUidList, #consumCardUidList
end

function BattleCardMgrServer:ShuffleCardsByDeck(cardDeck)
  BattleUtilServer.Shuffle(self.battleEngine, self.data.cardData[cardDeck])
  self:PrintDebugLog()
end

function BattleCardMgrServer:RevertCurUseCard()
  local card = self.battleEngine:GetCurCard()
  if not card then
    return
  end
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local changeData = {
    targetDeck = bc.CardDeck.HandDeck,
    camp = curCamp
  }
  self:MoveCardToDeck(card, changeData)
end

function BattleCardMgrServer:MoveCardToDeck(card, changeData)
  local targetDeck = changeData.targetDeck
  local isExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  if targetDeck == bc.CardDeck.DimensionDeck and isExtraBout then
    return
  end
  local fromDeck = card.deck
  if not self.data.cardData[fromDeck] then
    return
  end
  local reachMax = BattleCardMgrServer.CheckDeckMaxFunc[targetDeck]
  if reachMax and reachMax(self) then
    if fromDeck == bc.CardDeck.NoneDeck and targetDeck == bc.CardDeck.HandDeck then
      self.battleEngine.recordMgr:OnChangeCardListDeck({
        card.uid
      }, fromDeck, bc.CardDeck.NoneDeck, nil, changeData.changeReason, bc.BattleCamp.Camp1, changeData.show)
    elseif targetDeck == bc.CardDeck.HandDeck and (fromDeck == bc.CardDeck.DrawDeck or fromDeck == bc.CardDeck.GraveyardDeck) then
      self.battleEngine.recordMgr:OnChangeCardListDeck({
        card.uid
      }, fromDeck, fromDeck, nil, changeData.changeReason, bc.BattleCamp.Camp1, changeData.show)
    end
    if fromDeck == bc.CardDeck.DimensionDeck and targetDeck == bc.CardDeck.HandDeck then
      targetDeck = bc.CardDeck.NoneDeck
    else
      return
    end
  end
  local targetSet = self.data.cardData[targetDeck]
  if not targetSet then
    return
  end
  local oldDimensionNum = #self.data.cardData[bc.CardDeck.DimensionDeck]
  changeData = changeData or {}
  changeData.changeReason = bc.CardDeckReason.BattleEffect
  for index = #self.data.cardData[fromDeck], 1, -1 do
    if self.data.cardData[fromDeck][index] == card.uid then
      table.remove(self.data.cardData[fromDeck], index)
      break
    end
  end
  changeData.targetPos = changeData.targetPos or bc.BattleCardDeckPos.BOTTOM
  if changeData.targetPos == bc.BattleCardDeckPos.TOP then
    table.insert(targetSet, 1, card.uid)
  elseif changeData.targetPos == bc.BattleCardDeckPos.BOTTOM then
    table.insert(targetSet, card.uid)
  else
    local rand = self.battleEngine.rand:random(#targetSet + 1)
    table.insert(targetSet, rand, card.uid)
  end
  card:ChangeCardDeck(targetDeck, changeData)
  if fromDeck == bc.CardDeck.DimensionDeck then
    local eventData = {
      cardUidList = {
        card.uid
      },
      castRoleUid = changeData.castRoleUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardRemoveDimension, eventData)
  end
  if fromDeck == bc.CardDeck.DimensionDeck or targetDeck == bc.CardDeck.DimensionDeck then
    self.battleEngine:LogBattleWithTab("超维牌堆数量 %s -> %s", oldDimensionNum, #self.data.cardData[bc.CardDeck.DimensionDeck])
  end
  self.battleEngine.recordMgr:OnChangeCardListDeck({
    card.uid
  }, fromDeck, targetDeck, nil, changeData.changeReason, bc.BattleCamp.Camp1, changeData.show)
end

local BattleLogDeckNum = {
  [bc.CardDeck.HandDeck] = "手牌堆",
  [bc.CardDeck.DimensionDeck] = "超维牌堆"
}

function BattleCardMgrServer:AddNewCard(cardInfos, deck, addConfig)
  local isExtraBout = self.battleEngine.boutMgr:GetIsExtraBout()
  if deck == bc.CardDeck.DimensionDeck and isExtraBout then
    return {}
  end
  local oldNum = #self.data.cardData[deck]
  local newCards = {}
  local noneCards = {}
  local rand = self.battleEngine.rand
  for _, ci in ipairs(cardInfos) do
    local tid, level
    if tonumber(ci) then
      tid = tonumber(ci)
      level = 1
    else
      tid = ci.tid
      level = ci.level
    end
    local reachMax = BattleCardMgrServer.CheckDeckMaxFunc[deck]
    local isReachMax = reachMax and reachMax(self)
    if isReachMax and deck ~= bc.CardDeck.HandDeck then
      break
    end
    local cardInfo = {
      tid = tid,
      deck = deck,
      cardArgs = addConfig.cardArgs,
      level = level,
      runes = addConfig.runes,
      show = addConfig.show,
      enternal = addConfig.enternal,
      camp = addConfig.camp,
      owner = addConfig.owner,
      performSkillId = addConfig.performSkillId,
      cardTypes = addConfig.cardTypes
    }
    local card
    if isReachMax then
      cardInfo.deck = bc.CardDeck.NoneDeck
      card = BattleCardServer(self.battleEngine, cardInfo)
      table.insert(noneCards, card)
    else
      card = BattleCardServer(self.battleEngine, cardInfo)
      table.insert(newCards, card)
      if addConfig.enternal and addConfig.enternal ~= bc.CardEnternalType.None then
        table.insert(self.data.enternalCards, card.uid)
      end
    end
    if addConfig.handKeeperSkillParam then
      card:SetupHandKeeperData(addConfig.handKeeperSkillParam, addConfig.castRoleUid)
    end
    card.shuffled = true
    local targetSet = self.data.cardData[card.deck]
    local targetPos = addConfig.targetPos or bc.BattleCardDeckPos.BOTTOM
    if targetPos == bc.BattleCardDeckPos.TOP then
      table.insert(targetSet, 1, card.uid)
    elseif targetPos == bc.BattleCardDeckPos.BOTTOM then
      table.insert(targetSet, card.uid)
    else
      local randomPos = rand:random(1, #targetSet + 1)
      table.insert(targetSet, randomPos, card.uid)
    end
    self.data.allCardMap[card.uid] = card.uid
  end
  local cardData = {}
  local cardUids = {}
  for _, card in ipairs(newCards) do
    table.insert(cardData, card:Serialize())
    table.insert(cardUids, card.uid)
  end
  local noneCardUids = {}
  for _, card in ipairs(noneCards) do
    table.insert(cardData, card:Serialize())
    table.insert(noneCardUids, card.uid)
  end
  if BattleLogDeckNum[deck] then
    self.battleEngine:LogBattleWithTab(BattleLogDeckNum[deck] .. "数量 %s -> %s", oldNum, #self.data.cardData[deck])
  end
  self.battleEngine.recordMgr:OnAddNewCard(cardData, deck, addConfig.show, addConfig.camp)
  if #noneCardUids > 0 then
    self.battleEngine:Debug("AddNewCard noneCardUids:", table.tostring(noneCardUids))
    self.battleEngine.recordMgr:OnChangeCardListDeck(noneCardUids, bc.CardDeck.NoneDeck, bc.CardDeck.NoneDeck, nil, bc.CardDeckReason.NewCard, addConfig.camp, addConfig.show)
  end
  for _, cardUid in ipairs(cardUids) do
    local eventData = {
      cardUid = cardUid,
      oldDeck = bc.CardDeck.NoneDeck,
      newDeck = deck,
      castRoleUid = addConfig.castRoleUid,
      enternal = addConfig.enternal
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardDeckChange, eventData)
  end
  return newCards
end

function BattleCardMgrServer:GetMaxHandDeckNum()
  do return self.GetMaxDeckNum, self end
  return self.GetMaxDeckNum, self, bc.CardDeck.HandDeck
end

function BattleCardMgrServer:GetMaxDeckNum(cardDeck, owner)
  if cardDeck == bc.CardDeck.HandDeck then
    local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
    local upLimit = player:GetProperty(BP.hand_deck_limit_up)
    local awakerList = player:GetAwakerList()
    for _, awaker in ipairs(awakerList) do
      upLimit = upLimit + awaker:GetProperty(BP.hand_deck_limit_up)
    end
    local finalNum = bc.BattleAttrConst.HandCardMax + upLimit
    return finalNum
  end
  return 99999
end

function BattleCardMgrServer:GetDimensionCards()
  local dimensionCards = {}
  local skipStatePorperty = true
  for _, uid in ipairs(self.data.cardData[bc.CardDeck.DimensionDeck]) do
    local card = self:GetCardByUid(uid)
    local data = card:Serialize(skipStatePorperty)
    data.uid = nil
    data.tid = data.tid
    table.insert(dimensionCards, data)
  end
  return dimensionCards
end

function BattleCardMgrServer:InitDimensionCards(dimensionCards)
  for _, cardInfo in ipairs(dimensionCards) do
    cardInfo.uid = nil
    cardInfo.camp = bc.BattleCamp.Camp1
    local card = BattleCardServer(self.battleEngine, cardInfo)
    table.insert(self.data.cardData[card.deck], card.uid)
    self.data.allCardMap[card.uid] = card.uid
  end
end

function BattleCardMgrServer:CreateCardByID(tid, level, deck, camp)
  local cardData = {
    tid = tid,
    deck = deck,
    level = level,
    camp = camp
  }
  do return self.CreateCardByInfo, self end
  return self.CreateCardByInfo, self, cardData
end

function BattleCardMgrServer:CreateCardByInfo(cardInfo)
  cardInfo.uid = self.battleEngine:GenUid()
  local card = BattleCardServer(self.battleEngine, cardInfo)
  table.insert(self.data.cardData[cardInfo.deck], card.uid)
  self.data.allCardMap[card.uid] = card.uid
  return card
end

function BattleCardMgrServer:CreateCardsByID(slotCards, cmdParser)
  local ret = {}
  local newCardList = {}
  for _, slotCard in ipairs(slotCards) do
    local num = slotCard.num or 1
    local level = slotCard.level or 1
    local cardInfo = {
      tid = slotCard.tid,
      level = level,
      deck = bc.CardDeck.NoneDeck,
      camp = slotCard.camp,
      fromCardUid = cmdParser.cardUid
    }
    for _ = 1, num do
      local card = self:CreateCardByInfo(cardInfo)
      table.insert(ret, card)
      table.insert(newCardList, card:Serialize())
    end
  end
  self.battleEngine.recordMgr:OnAddNewCard(newCardList, bc.CardDeck.NoneDeck, true, bc.BattleCamp.Camp1)
  local exp = BattleCmdCardListExp(cmdParser, ret)
  return exp
end

function BattleCardMgrServer:GetEnternalCards()
  local ret = {}
  for _, uid in ipairs(self.data.enternalCards) do
    local card = self:GetCardByUid(uid)
    if card then
      table.insert(ret, card:Serialize())
    end
  end
  return ret
end

function BattleCardMgrServer:GetEnternalCardUids()
  local ret = {}
  for _, card in ipairs(self.data.enternalCards) do
    ret[card] = true
  end
  return ret
end

function BattleCardMgrServer:GetDestroyedCards()
  local ret = {}
  for _, uid in ipairs(self.data.destroyedCards) do
    local card = self:GetCardByUid(uid)
    if card then
      table.insert(ret, card:Serialize())
    end
  end
  return ret
end

function BattleCardMgrServer:DestroyCards(cards, castRoleUid)
  if not cards then
    return
  end
  for _, card in ipairs(cards) do
    table.insert(self.data.destroyedCards, card.uid)
    local deck = self.data.cardData[card.deck]
    if not deck then
    else
      local oldDeck = card.deck
      for i = #deck, 1, -1 do
        if deck[i] == card.uid then
          table.remove(deck, i)
          break
        end
      end
      for i = #self.data.enternalCards, 1, -1 do
        if self.data.enternalCards[i] == card.uid then
          table.remove(self.data.enternalCards, i)
        end
      end
      local changeReason = bc.CardDeckReason.BattleEffect
      local changeData = {changeReason = changeReason, castRoleUid = castRoleUid}
      card:ChangeCardDeck(bc.CardDeck.ConsumedDeck, changeData)
      self.battleEngine.recordMgr:OnChangeCardListDeck({
        card.uid
      }, oldDeck, bc.CardDeck.ConsumedDeck, nil, changeReason, bc.BattleCamp.Camp1)
    end
  end
end

function BattleCardMgrServer:ClearNoneDeckCards()
  for _, uid in ipairs(self.data.cardData[bc.CardDeck.NoneDeck]) do
    local card = self:GetCardByUid(uid)
    if card then
      card.isDeleted = true
    end
  end
  self.data.cardData[bc.CardDeck.NoneDeck] = {}
  local allCardMap = self.data.allCardMap
  for _, uid in pairs(allCardMap) do
    local card = self:GetCardByUid(uid)
    if card and card.isDeleted then
      card:Dispose()
      allCardMap[card.uid] = nil
    end
  end
end

function BattleCardMgrServer:OnBattleEnd()
  local embyroDoubleApiCfg = self.battleEngine.battleDT.BattleApi.EmbryoCardDouble
  local embyroDoubleId = embyroDoubleApiCfg.Data
  for _, uid in pairs(self.data.allCardMap) do
    local card = self:GetCardByUid(uid)
    if not card or card.tid == embyroDoubleId or card.deck == bc.CardDeck.DimensionDeck then
    elseif card.data.savedOriginData and card.tid == card.data.srcConfigId then
    else
      card:RevertChange(bc.RevertType.SavedOrigin)
    end
  end
end

function BattleCardMgrServer:CheckHandCardHighlight()
  local highlightCards = self:GetHighlightList()
  for _, uid in ipairs(self.data.cardData[bc.CardDeck.HideDeck] or {}) do
    local card = self:GetCardByUid(uid)
    if card:CheckHighlight() then
      highlightCards[uid] = true
    else
      highlightCards[uid] = nil
    end
  end
  local handCardList = self.data.cardData[bc.CardDeck.HandDeck] or {}
  local needFresh = false
  for _, uid in ipairs(handCardList) do
    local card = self:GetCardByUid(uid)
    local high_light
    if card.composeCardUids and #card.composeCardUids > 0 then
      for _, compCardUid in ipairs(card.composeCardUids) do
        if highlightCards[compCardUid] then
          high_light = true
          break
        end
      end
    elseif card:CheckHighlight() then
      high_light = true
    end
    if high_light ~= highlightCards[uid] then
      highlightCards[uid] = high_light
      needFresh = true
    end
  end
  if needFresh then
    self.battleEngine.recordMgr:SetCardHighlight(highlightCards)
  end
end

function BattleCardMgrServer:GetHighlightList()
  return self.data.highlightCards
end

function BattleCardMgrServer:RemoveHighlight(cardUid)
  self.data.highlightCards[cardUid] = nil
end

function BattleCardMgrServer:GetBattleLogCardData()
  return {
    [bc.BattleCamp.Camp1] = self.data.cardData
  }
end

function BattleCardMgrServer:PrintDebugLog()
end

return BattleCardMgrServer
