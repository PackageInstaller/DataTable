local System = require("System.System")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BattleCmdCardListExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdCardListExp")
local BattleCardMgrServerPVP, Super = System.NewClass("BattleCardMgrServerPVP", BattleEngineComponent)
BattleCardMgrServerPVP.CheckDeckMaxFunc = {
  [bc.CardDeck.HandDeck] = function(cardMgr, camp)
    local cardData = cardMgr:GetCampCardData(camp)
    return #cardData[bc.CardDeck.HandDeck] >= cardMgr:GetMaxHandDeckNum(camp)
  end
}

function BattleCardMgrServerPVP:ctor(battleEngine)
  Super.ctor(self, battleEngine)
end

function BattleCardMgrServerPVP:ctorData()
  local data = Super.ctorData(self)
  data.totalShuffleTimes = 0
  data.camp1CardData = {}
  data.camp2CardData = {}
  data.allCardMap = {}
  data.highlightCards = {}
  data.boutShuffledTimes = {}
  data.history = {}
  data.drawCardNum = bc.BattleAttrConst.DrawCardNum
  data.camp1CardTids = {}
  data.camp2CardTids = {}
  data.camp1WeaponCards = {}
  data.camp2WeaponCards = {}
  data.camp1KeeperCards = {}
  data.camp2KeeperCards = {}
  for _, v in pairs(bc.CardDeck) do
    data.camp1CardData[v] = {}
    data.camp2CardData[v] = {}
  end
  return data
end

function BattleCardMgrServerPVP:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeDrawCards, self.OnBFBeforeDrawCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFDrawCards, self.OnBFDrawCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFDiscardCards, self.OnBFDiscardCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChange, self)
end

function BattleCardMgrServerPVP:Dispose()
  Super.Dispose(self)
  self.data.camp1CardData = nil
  self.data.camp2CardData = nil
end

function BattleCardMgrServerPVP:GetCampCardData(camp)
  if camp == bc.BattleCamp.Camp1 then
    return self.data.camp1CardData
  elseif camp == bc.BattleCamp.Camp2 then
    return self.data.camp2CardData
  end
end

function BattleCardMgrServerPVP:GetCampCardTids(camp)
  if camp == bc.BattleCamp.Camp1 then
    return self.data.camp1CardTids
  elseif camp == bc.BattleCamp.Camp2 then
    return self.data.camp2CardTids
  end
end

function BattleCardMgrServerPVP:GetCampWeaponCards(camp)
  if camp == bc.BattleCamp.Camp1 then
    return self.data.camp1WeaponCards
  elseif camp == bc.BattleCamp.Camp2 then
    return self.data.camp2WeaponCards
  end
end

function BattleCardMgrServerPVP:GetCampKeeperCards(camp)
  if camp == bc.BattleCamp.Camp1 then
    return self.data.camp1KeeperCards
  elseif camp == bc.BattleCamp.Camp2 then
    return self.data.camp2KeeperCards
  end
end

function BattleCardMgrServerPVP:InsertHistory(cardUid, roleUid, skillToCard)
  if cardUid or skillToCard then
    if #self.data.history >= bc.MaxHistory then
      table.remove(self.data.history, 1)
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
      table.insert(self.data.history, data)
      self.battleEngine.recordMgr:OnInsertHistory(data)
    end
  end
end

function BattleCardMgrServerPVP:GetEnternalCardUids()
  return {}
end

function BattleCardMgrServerPVP:GetDimensionCards()
  return {}
end

function BattleCardMgrServerPVP:GetEnternalCards()
  return {}
end

function BattleCardMgrServerPVP:GetDestroyedCards()
  return {}
end

function BattleCardMgrServerPVP:GetSelectInitCard(camp)
  local cardData = self:GetCampCardData(camp)
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  local fromDeck = bc.CardDeck.DrawDeck
  local targetDeck = bc.CardDeck.SelectInitDeck
  local reason = bc.CardDeckReason.SelectInit
  BattleUtilServer.Shuffle(self.battleEngine, cardData[fromDeck])
  local ret = {}
  for i = 1, 5 do
    local uid = table.remove(cardData[fromDeck], 1)
    local card = self.battleEngine:GetObj(uid)
    if not card then
    else
      local changeData = {
        castRoleUid = player.uid,
        targetDeck = targetDeck,
        camp = camp
      }
      card:ChangeCardDeck(targetDeck, changeData)
      table.insert(cardData[targetDeck], card.uid)
      table.insert(ret, card.uid)
    end
  end
  self.battleEngine.recordMgr:OnChangeCardListDeck(ret, fromDeck, targetDeck, nil, reason, camp)
  return ret
end

function BattleCardMgrServerPVP:DiscardInitCard(camp, selectUids)
  local cardData = self:GetCampCardData(camp)
  if 0 == #selectUids then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  local reason = bc.CardDeckReason.SelectInit
  local selectInitDeckList = cardData[bc.CardDeck.SelectInitDeck]
  local drawDeckList = cardData[bc.CardDeck.DrawDeck]
  local newInitCardList = {}
  for i = 1, #selectUids do
    local newUid = table.remove(drawDeckList, 1)
    local newInitCard = self:GetCardByUid(newUid)
    if not newInitCard then
      break
    end
    local changeData = {
      castRoleUid = player.uid,
      targetDeck = bc.CardDeck.SelectInitDeck,
      camp = camp
    }
    newInitCard:ChangeCardDeck(bc.CardDeck.SelectInitDeck, changeData)
    table.insert(selectInitDeckList, newUid)
    table.insert(newInitCardList, newUid)
  end
  self.battleEngine.recordMgr:OnChangeCardListDeck(newInitCardList, bc.CardDeck.DrawDeck, bc.CardDeck.SelectInitDeck, nil, reason, camp)
  for i = 1, #selectUids do
    local oldUid = selectUids[i]
    local oldInitCard = self:GetCardByUid(oldUid)
    local changeOldData = {
      castRoleUid = player.uid,
      targetDeck = bc.CardDeck.DrawDeck,
      camp = camp
    }
    oldInitCard:ChangeCardDeck(bc.CardDeck.DrawDeck, changeOldData)
    table.insert(drawDeckList, oldUid)
    for pos, uid in ipairs(selectInitDeckList) do
      if uid == oldUid then
        table.remove(selectInitDeckList, pos)
        break
      end
    end
  end
  self.battleEngine.recordMgr:OnChangeCardListDeck(selectUids, bc.CardDeck.SelectInitDeck, bc.CardDeck.DrawDeck, nil, reason, camp)
  BattleUtilServer.Shuffle(self.battleEngine, drawDeckList)
end

function BattleCardMgrServerPVP:MoveSelectInitCard(camp)
  local cardData = self:GetCampCardData(camp)
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  local fromDeck = bc.CardDeck.SelectInitDeck
  local targetDeck = bc.CardDeck.HandDeck
  local length = #cardData[fromDeck]
  if 0 == length then
    return
  end
  local reason = bc.CardDeckReason.SelectInit
  local ret = {}
  for _ = 1, length do
    local uid = table.remove(cardData[fromDeck], 1)
    local card = self.battleEngine:GetObj(uid)
    local changeData = {
      castRoleUid = player.uid,
      targetDeck = targetDeck,
      camp = camp
    }
    card:ChangeCardDeck(targetDeck, changeData)
    table.insert(cardData[targetDeck], card.uid)
    table.insert(ret, card.uid)
  end
  self.battleEngine.recordMgr:OnChangeCardListDeck(ret, fromDeck, targetDeck, nil, reason, camp)
  local evData = {cardUids = ret, camp = camp}
  self.battleEngine:CreateEventEffect(BattleLogicEvent.AfterSelectInitCard, evData)
end

function BattleCardMgrServerPVP:OnBFBeforeDrawCards()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  self:ClearCardShuffleTag(curCamp)
  local curBout = self.battleEngine.boutMgr:GetBoutNum()
  if 1 ~= curBout then
    self:CheckGenerateDrawDeck(5, curCamp)
  end
end

function BattleCardMgrServerPVP:ChangeDrawCardNum(changeValue)
  self.data.drawCardNum = self.data.drawCardNum + changeValue
end

function BattleCardMgrServerPVP:OnBFDrawCards()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local curBout = self.battleEngine.boutMgr:GetBoutNum()
  if 1 ~= curBout or self.battleEngine:IsPVPTraining() then
    local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
    local drawCardNumAttr = player and player:GetProperty("draw_card_num") or 0
    local drawCardNum = self.data.drawCardNum + drawCardNumAttr
    self:DrawCards(drawCardNum, bc.CardDeckReason.Draw, curCamp)
  end
  self:ClearCardShuffleTag(curCamp)
end

function BattleCardMgrServerPVP:GenerateDrawDeck(camp)
  local curCamp = camp or self.battleEngine.boutMgr:GetCurCamp()
  local boutShuffledTimes = self.data.boutShuffledTimes[curCamp] or 0
  if boutShuffledTimes >= 1 then
    return
  end
  local cardData = self:GetCampCardData(curCamp)
  self.data.boutShuffledTimes[curCamp] = boutShuffledTimes + 1
  local newCards = {}
  local showList = {}
  local campCardTids = self:GetCampCardTids(curCamp)
  local weaponCards = self:GetCampWeaponCards(curCamp)
  local keeperCards = self:GetCampKeeperCards(curCamp)
  for _, tid in pairs(campCardTids) do
    local cardCfg = self.battleEngine.battleDT.Skill[tid]
    local awakerTid = cardCfg.AwakerID
    local awaker = self.battleEngine.roleMgr:GetAwakerByTid(awakerTid, curCamp)
    if awaker and awaker:IsDead() then
    elseif false == weaponCards[tid] then
    else
      if true == weaponCards[tid] then
        weaponCards[tid] = false
      end
      if false == keeperCards[tid] then
      else
        if true == keeperCards[tid] then
          keeperCards[tid] = false
        end
        local cardInfo = {
          uid = self.battleEngine:GenUid(),
          tid = tid,
          level = 1,
          deck = bc.CardDeck.DrawDeck,
          camp = curCamp
        }
        local card = BattleCardServer(self.battleEngine, cardInfo)
        table.insert(newCards, card.uid)
        table.insert(showList, card:Serialize())
      end
    end
  end
  BattleUtilServer.Shuffle(self.battleEngine, newCards)
  for _, uid in ipairs(newCards) do
    table.insert(cardData[bc.CardDeck.DrawDeck], uid)
  end
  self.battleEngine.recordMgr:OnAddNewCard(showList, bc.CardDeck.DrawDeck, false, curCamp)
  self.battleEngine.recordMgr:OnShuffleCard(curCamp)
  local eventData = {
    totalShuffleTimes = self.data.totalShuffleTimes,
    ownerCamp = curCamp
  }
  self.battleEngine.eventMgr:SendEvent(BattleLogicEvent.ShuffleCards, eventData)
end

function BattleCardMgrServerPVP:GetMaxHandDeckNum(camp)
  do return self.GetMaxDeckNum, self, bc.CardDeck.HandDeck end
  return self.GetMaxDeckNum, self, bc.CardDeck.HandDeck, camp
end

function BattleCardMgrServerPVP:GetMaxDeckNum(cardDeck, camp)
  if cardDeck == bc.CardDeck.HandDeck then
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
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

function BattleCardMgrServerPVP:CheckGenerateDrawDeck(num, camp)
  local curCamp = camp or self.battleEngine.boutMgr:GetCurCamp()
  local cardData = self:GetCampCardData(curCamp)
  local drawCardUidList = {}
  local handCardNum = #cardData[bc.CardDeck.HandDeck]
  local maxHandCount = self:GetMaxHandDeckNum(curCamp)
  if maxHandCount < handCardNum + num then
    num = maxHandCount - handCardNum
  end
  if num > #cardData[bc.CardDeck.DrawDeck] then
    self:GenerateDrawDeck(curCamp)
  end
end

function BattleCardMgrServerPVP:DrawCards(num, changeReason, camp)
  local curCamp = camp or self.battleEngine.boutMgr:GetCurCamp()
  local cardData = self:GetCampCardData(curCamp)
  local drawCardUidList = {}
  local handCardNum = #cardData[bc.CardDeck.HandDeck]
  local maxHandCount = self:GetMaxHandDeckNum(curCamp)
  if maxHandCount < handCardNum + num then
    num = maxHandCount - handCardNum
  end
  if num > #cardData[bc.CardDeck.DrawDeck] then
    self:GenerateDrawDeck(curCamp)
  end
  if num > #cardData[bc.CardDeck.DrawDeck] then
    num = #cardData[bc.CardDeck.DrawDeck]
  end
  changeReason = changeReason or bc.CardDeckReason.Draw
  local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
  local changeData = {
    changeReason = changeReason,
    castRoleUid = player.uid
  }
  for _ = 1, num do
    local targetDeck = bc.CardDeck.HandDeck
    local fromDeck = bc.CardDeck.DrawDeck
    local uid = table.remove(cardData[fromDeck], 1)
    local card = self.battleEngine:GetObj(uid)
    table.insert(cardData[targetDeck], uid)
    card:ChangeCardDeck(targetDeck, changeData)
    table.insert(drawCardUidList, uid)
  end
  if next(drawCardUidList) then
    self.battleEngine.recordMgr:OnChangeCardListDeck(drawCardUidList, bc.CardDeck.DrawDeck, bc.CardDeck.HandDeck, nil, changeReason, curCamp)
  end
  self.battleEngine:LogBattleWithTab("抽牌: %s", num)
  self.battleEngine:LogBattleWithTab("手牌数: %s -> %s", handCardNum, #cardData[bc.CardDeck.HandDeck])
  return num
end

function BattleCardMgrServerPVP:OnBFDiscardCards()
end

function BattleCardMgrServerPVP:InitAllCards(cardDataList)
  for _, cardInfo in ipairs(cardDataList) do
    local cardData = self:GetCampCardData(cardInfo.camp)
    if not cardData then
    else
      local card = BattleCardServer(self.battleEngine, cardInfo)
      local campCardTids = self:GetCampCardTids(cardInfo.camp)
      table.insert(campCardTids, card.tid)
      local skillCfg = self.battleEngine.battleDT.Skill[card.tid]
      if table.contains(skillCfg.Type, bc.SkillType.Card_Weapon) then
        local weaponCards = self:GetCampWeaponCards(cardInfo.camp)
        weaponCards[card.tid] = false
      end
      if table.contains(skillCfg.Type, bc.SkillType.Card_KeeperSkill) then
        local keeperCards = self:GetCampKeeperCards(cardInfo.camp)
        keeperCards[card.tid] = false
      end
      table.insert(cardData[card.deck], card.uid)
      self.data.allCardMap[card.uid] = card.uid
    end
  end
end

function BattleCardMgrServerPVP:GetAllCardData()
  local camp1CardDatas = {}
  for _, list in pairs(self.data.camp1CardData) do
    for _, uid in ipairs(list) do
      local card = self.battleEngine:GetObj(uid)
      table.insert(camp1CardDatas, card:Serialize())
    end
  end
  print("GetAllCardData", table.tostring(self.data.camp1CardData), table.tostring(camp1CardDatas))
  local camp2CardDatas = {}
  for _, list in pairs(self.data.camp2CardData) do
    for _, uid in ipairs(list) do
      local card = self.battleEngine:GetObj(uid)
      table.insert(camp2CardDatas, card:Serialize())
    end
  end
  print("GetAllCardData", table.tostring(self.data.camp2CardData), table.tostring(camp2CardDatas))
  return {
    [bc.BattleCamp.Camp1] = camp1CardDatas,
    [bc.BattleCamp.Camp2] = camp2CardDatas
  }
end

function BattleCardMgrServerPVP:Serialize()
  return {
    cardDataList = self:GetAllCardData(),
    history = self.data.history
  }
end

function BattleCardMgrServerPVP:UpdateCardArgs()
  local syncData = {}
  for _, cardData in ipairs({
    self.data.camp1CardData,
    self.data.camp2CardData
  }) do
    for deckName, deck in pairs(cardData) do
      if bc.CardArgsSyncDeckPVP[deckName] then
        for _, uid in ipairs(deck) do
          local card = self:GetCardByUid(uid)
          local cardArgs, descArgs = card:UpdateCardArgs()
          if cardArgs then
            syncData[card.uid] = {cardArgs = cardArgs, descArgs = descArgs}
          end
        end
      end
    end
  end
  if next(syncData) ~= nil then
    self.battleEngine.recordMgr:OnUpdateCardArgs(syncData)
  end
end

function BattleCardMgrServerPVP:ClearCardShuffleTag(camp)
  self.data.boutShuffledTimes[camp] = 0
end

function BattleCardMgrServerPVP:GetCardByUid(uid)
  do return self.battleEngine.GetObj, self.battleEngine end
  return self.battleEngine.GetObj, self.battleEngine, uid
end

function BattleCardMgrServerPVP:SetCurUseCard(card, castRoleUid)
  local castRole = self.battleEngine:GetObj(castRoleUid)
  local castRoleName = "无"
  if castRole then
    castRoleName = castRole:GetBattleLogName()
  end
  self.battleEngine:LogBattleWithTab("%s 打出卡牌: %s ", castRoleName, card:GetBattleLogName())
  self.battleEngine.roleMgr:SetCurCaster(castRoleUid)
  self.battleEngine:SetCurCard(card.uid)
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local changeData = {
    castRoleUid = castRoleUid,
    targetDeck = bc.CardDeck.UsingDeck,
    camp = curCamp
  }
  self:MoveCardToDeck(card, changeData)
end

function BattleCardMgrServerPVP:RevertCurUseCard()
  local card = self.battleEngine:GetCurCard()
  if not card then
    self.battleEngine:Warn("取消使用卡牌失敗：找不到卡牌", cardUid)
    return
  end
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local changeData = {
    targetDeck = bc.CardDeck.HandDeck,
    camp = curCamp
  }
  self:MoveCardToDeck(card, changeData)
end

function BattleCardMgrServerPVP:MoveCardToDeck(card, changeData)
  local cardData = self:GetCampCardData(changeData.camp)
  local targetDeck = changeData.targetDeck
  local targetSet = cardData[targetDeck]
  if not targetSet then
    return
  end
  local fromDeck = card.deck
  if not cardData[fromDeck] then
    return
  end
  local reachMax = BattleCardMgrServerPVP.CheckDeckMaxFunc[targetDeck]
  if reachMax and reachMax(self, changeData.camp) then
    if fromDeck == bc.CardDeck.NoneDeck and targetDeck == bc.CardDeck.HandDeck then
      self.battleEngine.recordMgr:OnChangeCardListDeck({
        card.uid
      }, fromDeck, bc.CardDeck.NoneDeck, nil, changeData.changeReason, changeData.camp, changeData.show)
    elseif targetDeck == bc.CardDeck.HandDeck and (fromDeck == bc.CardDeck.DrawDeck or fromDeck == bc.CardDeck.GraveyardDeck) then
      self.battleEngine.recordMgr:OnChangeCardListDeck({
        card.uid
      }, fromDeck, fromDeck, nil, changeData.changeReason, changeData.camp, changeData.show)
    elseif fromDeck == bc.CardDeck.HandDeck and targetDeck == bc.CardDeck.GraveyardDeck then
      self.battleEngine.recordMgr:OnChangeCardListDeck({
        card.uid
      }, fromDeck, targetDeck, nil, changeData.changeReason, changeData.camp, changeData.show)
    end
    return
  end
  changeData = changeData or {}
  changeData.changeReason = bc.CardDeckReason.BattleEffect
  for index = #cardData[fromDeck], 1, -1 do
    if cardData[fromDeck][index] == card.uid then
      table.remove(cardData[fromDeck], index)
      break
    end
  end
  changeData.targetPos = changeData.targetPos or bc.BattleCardDeckPos.BOTTOM
  if changeData.targetPos == bc.BattleCardDeckPos.TOP then
    table.insert(targetSet, 1, card.uid)
  elseif changeData.targetPos == bc.BattleCardDeckPos.BOTTOM then
    table.insert(targetSet, card.uid)
  else
    local randomPos = self.battleEngine.rand:random(1, #targetSet + 1)
    table.insert(targetSet, randomPos, card.uid)
  end
  card:ChangeCardDeck(targetDeck, changeData)
  self.battleEngine.recordMgr:OnChangeCardListDeck({
    card.uid
  }, fromDeck, targetDeck, nil, changeData.changeReason, changeData.camp, changeData.show)
end

function BattleCardMgrServerPVP:GetHandCardUidList(camp)
  local cardData = self:GetCampCardData(camp)
  local cardList = cardData[bc.CardDeck.HandDeck]
  local uidList = {}
  for _, card in ipairs(cardList) do
    table.insert(uidList, card)
  end
  return uidList
end

function BattleCardMgrServerPVP:GetCardListByDeck(deck, camp)
  camp = camp or self.battleEngine.boutMgr:GetCurCamp()
  local cardData = self:GetCampCardData(camp)
  return cardData[deck] or {}
end

function BattleCardMgrServerPVP:CreateCardByID(tid, level, deck, camp)
  local cardInfo = {
    uid = self.battleEngine:GenUid(),
    tid = tid,
    deck = deck,
    level = level,
    camp = camp
  }
  local cardData = self:GetCampCardData(camp)
  local card = BattleCardServer(self.battleEngine, cardInfo)
  table.insert(cardData[deck], card.uid)
  self.data.allCardMap[card.uid] = card.uid
  return card
end

function BattleCardMgrServerPVP:CreateCardsByID(slotCards, cmdParser)
  local camp = cmdParser:GetCasterCamp()
  local ret = {}
  local newCardList = {}
  for _, slotCard in ipairs(slotCards) do
    local num = slotCard.num or 1
    local level = slotCard.level or 1
    for _ = 1, num do
      local card = self:CreateCardByID(slotCard.tid, level, bc.CardDeck.NoneDeck, camp)
      table.insert(ret, card)
      table.insert(newCardList, card:Serialize())
    end
  end
  self.battleEngine.recordMgr:OnAddNewCard(newCardList, bc.CardDeck.NoneDeck, true, camp)
  local exp = BattleCmdCardListExp(cmdParser, ret)
  return exp
end

function BattleCardMgrServerPVP:CreateTempCard(tid, level, camp, owner)
  local cardData = self:GetCampCardData(camp)
  local cardInfo = {
    uid = self.battleEngine:GenUid(),
    tid = tid,
    deck = bc.CardDeck.NoneDeck,
    level = level,
    camp = camp,
    owner = owner
  }
  local card = BattleCardServer(self.battleEngine, cardInfo)
  table.insert(cardData[bc.CardDeck.NoneDeck], card.uid)
  self.data.allCardMap[card.uid] = card.uid
  return card
end

local BattleLogDeckNum = {
  [bc.CardDeck.HandDeck] = "手牌堆",
  [bc.CardDeck.DimensionDeck] = "超维牌堆"
}

function BattleCardMgrServerPVP:AddNewCard(tids, deck, addConfig)
  local cardData = self:GetCampCardData(addConfig.camp)
  local oldNum = #cardData[deck]
  local newCards = {}
  local noneCards = {}
  local rand = self.battleEngine.rand
  for _, c in ipairs(tids) do
    local tid, level
    if tonumber(c) then
      tid = tonumber(c)
      level = 1
    else
      tid = c.tid
      level = c.level
    end
    local reachMax = BattleCardMgrServerPVP.CheckDeckMaxFunc[deck]
    local isReachMax = reachMax and reachMax(self, addConfig.camp)
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
      owner = addConfig.owner
    }
    local card
    if isReachMax then
      cardInfo.deck = bc.CardDeck.NoneDeck
      card = BattleCardServer(self.battleEngine, cardInfo)
      table.insert(noneCards, card)
    else
      card = BattleCardServer(self.battleEngine, cardInfo)
      table.insert(newCards, card)
    end
    local targetSet = cardData[card.deck]
    local targetPos = addConfig.targetPos or bc.BattleCardDeckPos.BOTTOM
    if targetPos == bc.BattleCardDeckPos.TOP then
      table.insert(targetSet, 1, card.uid)
    elseif targetPos == bc.BattleCardDeckPos.BOTTOM then
      table.insert(targetSet, card.uid)
    elseif targetPos == bc.BattleCardDeckPos.RANDOM then
      local randomPos = rand:random(1, #targetSet + 1)
      table.insert(targetSet, randomPos, card.uid)
    end
    self.data.allCardMap[card.uid] = card.uid
  end
  local newCardInfos = {}
  local cardUids = {}
  for _, card in ipairs(newCards) do
    table.insert(newCardInfos, card:Serialize())
    table.insert(cardUids, card.uid)
  end
  local noneCardUids = {}
  for _, card in ipairs(noneCards) do
    table.insert(newCardInfos, card:Serialize())
    table.insert(noneCardUids, card.uid)
  end
  if BattleLogDeckNum[deck] then
    self.battleEngine:LogBattleWithTab(BattleLogDeckNum[deck] .. "数量 %s -> %s", oldNum, #cardData[deck])
  end
  self.battleEngine.recordMgr:OnAddNewCard(newCardInfos, deck, addConfig.show, addConfig.camp)
  if #noneCardUids > 0 then
    self.battleEngine.recordMgr:OnChangeCardListDeck(noneCardUids, bc.CardDeck.NoneDeck, bc.CardDeck.NoneDeck, nil, bc.CardDeckReason.NewCard, addConfig.camp, addConfig.show)
  end
  for _, cardUid in ipairs(cardUids) do
    local eventData = {
      cardUid = cardUid,
      oldDeck = bc.CardDeck.NoneDeck,
      newDeck = deck,
      castRoleUid = addConfig.castRoleUid
    }
    self.battleEngine:CreateEventEffect(BattleLogicEvent.CardDeckChange, eventData)
  end
  return newCards
end

function BattleCardMgrServerPVP:CheckHandCardHighlight()
  local needFresh = false
  for _, camp in ipairs({
    bc.BattleCamp.Camp1,
    bc.BattleCamp.Camp2
  }) do
    local cardData = self:GetCampCardData(camp)
    local handCardList = cardData[bc.CardDeck.HandDeck] or {}
    for _, uid in ipairs(handCardList) do
      local card = self:GetCardByUid(uid)
      if card:CheckHighlight() then
        if self.data.highlightCards[card.uid] == nil then
          self.data.highlightCards[card.uid] = true
          needFresh = true
        end
      elseif self.data.highlightCards[card.uid] then
        self.data.highlightCards[card.uid] = nil
        needFresh = true
      end
    end
  end
  if needFresh then
    self.battleEngine.recordMgr:SetCardHighlight(self.data.highlightCards)
  end
end

function BattleCardMgrServerPVP:GetHighlightList()
  return self.data.highlightCards
end

function BattleCardMgrServerPVP:RemoveHighlight(cardUid)
  self.data.highlightCards[cardUid] = nil
end

function BattleCardMgrServerPVP:GetBattleLogCardData()
  return {
    [bc.BattleCamp.Camp1] = self:GetCampCardData(bc.BattleCamp.Camp1),
    [bc.BattleCamp.Camp2] = self:GetCampCardData(bc.BattleCamp.Camp2)
  }
end

function BattleCardMgrServerPVP:ClearNoneDeckCards()
  for _, camp in ipairs({
    bc.BattleCamp.Camp1,
    bc.BattleCamp.Camp2
  }) do
    local cardData = self:GetCampCardData(camp)
    for _, uid in ipairs(cardData[bc.CardDeck.NoneDeck]) do
      local card = self:GetCardByUid(uid)
      card.isDeleted = true
    end
    cardData[bc.CardDeck.NoneDeck] = {}
  end
  for _, uid in pairs(self.data.allCardMap) do
    local card = self:GetCardByUid(uid)
    if card.deck == bc.CardDeck.NoneDeck or card.isDeleted then
      card:Dispose()
      self.data.allCardMap[card.uid] = nil
    end
  end
end

function BattleCardMgrServerPVP:OnCardDeckChange(eventData)
  local oldDeck = eventData.oldDeck
  local newDeck = eventData.newDeck
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  local camp = card.camp
  local weaponCards = self:GetCampWeaponCards(camp)
  local cardTypes = card:GetType()
  if oldDeck ~= bc.CardDeck.UsingDeck and newDeck == bc.CardDeck.GraveyardDeck and table.contains(cardTypes, bc.SkillType.Card_Weapon) then
    weaponCards[card.tid] = true
  end
  local keeperCards = self:GetCampKeeperCards(camp)
  if oldDeck ~= bc.CardDeck.UsingDeck and newDeck == bc.CardDeck.GraveyardDeck and table.contains(cardTypes, bc.SkillType.Card_KeeperSkill) then
    keeperCards[card.tid] = true
  end
end

function BattleCardMgrServerPVP:InsertBoutHistory()
end

return BattleCardMgrServerPVP
