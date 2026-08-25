local System = require("System.System")
local BattleCmdBaseExpression = require("Battle.DbgEngine.Cmd.Expression.BattleCmdBaseExpression")
local bc = require("Battle.BattleConst")
local BattleCmdTargetsExp = require("Battle.DbgEngine.Cmd.Expression.BattleCmdTargetsExp")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BP = bc.BattleProperty
local BattleCmdCardListExp, Super = System.NewClass("BattleCmdCardListExp", BattleCmdBaseExpression)

function BattleCmdCardListExp:ctor(cmdParser, cardListOrCardDeck)
  Super.ctor(self)
  self.cmdParser = cmdParser
  if type(cardListOrCardDeck) == "table" then
    self.cardList = cardListOrCardDeck
  elseif type(cardListOrCardDeck) == "string" then
    self.cardDeck = cardListOrCardDeck
    self.cardList = self:_GenerateCardList(cardListOrCardDeck)
  else
    error("卡牌列表对象的参数类型不匹配" .. cardListOrCardDeck)
  end
  self:InitGetter(cmdParser.battleEngine.battleDT)
end

function BattleCmdCardListExp:_GenerateCardList(deckName)
  local camp = self.cmdParser:GetCasterCamp()
  if string.find(deckName, "Enemy") then
    camp = bc.BattleCamp:GetEnemyCamp(camp)
    deckName = string.replace(deckName, "Enemy", "", false)
    self.cardDeck = deckName
  end
  if self.cmdParser.battleEngine:IsPVE() then
    camp = bc.BattleCamp.Camp1
  end
  self.camp = camp
  local deckNameList = string.split(deckName, "And")
  local cardList = {}
  for _, cardDeck in ipairs(deckNameList) do
    local list = self.cmdParser.battleEngine.cardMgr:GetCardListByDeck(cardDeck, camp)
    for _, cardUid in ipairs(list) do
      local card = self.cmdParser.battleEngine:GetObj(cardUid)
      table.insert(cardList, card)
    end
  end
  return cardList
end

function BattleCmdCardListExp:GetCardList()
  return self.cardList
end

function BattleCmdCardListExp:_GetCardUidList()
  local ret = {}
  for _, card in ipairs(self.cardList) do
    table.insert(ret, card.uid)
  end
  return ret
end

function BattleCmdCardListExp:_GetDeckName()
  return self.cardDeck
end

local AttrFunc = {
  ID = function(card)
    if not card then
      return 0
    end
    return card.configData.ID
  end,
  CurDeck = function(card)
    if not card then
      return 0
    end
    return card.deck
  end,
  uid = function(card)
    if not card then
      return 0
    end
    return card.uid
  end,
  ConsumeEnergy = function(card)
    if not card then
      return 0
    end
    return card.realCost or 0
  end,
  TargetCmdOwner = function(card, cmdParser)
    if not card then
      return {}
    end
    local owner = card:GetOwner()
    local exp = BattleCmdTargetsExp(cmdParser, {owner})
    return exp
  end,
  card_cost = function(card)
    if not card then
      return 0
    end
    do return card.GetUseCost end
    return card.GetUseCost, card
  end,
  allowIgnoreCost = function(card)
    if not card then
      return 0
    end
    return card.allowIgnoreCost
  end,
  slot = function(card)
    if not card then
      return 0
    end
    return card.configData.Slot
  end
}

function BattleCmdCardListExp:GetAttr(attrName)
  if "CardCount" == attrName or "TargetCount" == attrName then
    return #self.cardList
  end
  local card = self.cardList[1]
  if AttrFunc[attrName] then
    do return AttrFunc[attrName], card end
    return AttrFunc[attrName], card, self.cmdParser
  end
  if not card then
    return 0
  end
  return card:GetProperty(attrName) or 0
end

local PosFunc = {
  [bc.BattleCardDeckPos.RANDOM] = function(battleEngine, cardList, num)
    local ret = {}
    cardList = table.clone(cardList)
    BattleUtilServer.Shuffle(battleEngine, cardList)
    for i = 1, num do
      if not cardList[i] then
        break
      end
      table.insert(ret, cardList[i])
    end
    return ret
  end,
  [bc.BattleCardDeckPos.TOP] = function(_, cardList, num)
    local ret = {}
    for i = 1, num do
      if not cardList[i] then
        break
      end
      table.insert(ret, cardList[i])
    end
    return ret
  end,
  [bc.BattleCardDeckPos.BOTTOM] = function(_, cardList, num)
    local ret = {}
    local len = #cardList
    local count = 0
    for i = len, 1, -1 do
      table.insert(ret, cardList[i])
      count = count + 1
      if num <= count then
        break
      end
    end
    return ret
  end,
  [bc.BattleCardDeckPos.RANDOMENCHANT] = function(battleEngine, cardList, num)
    local ret = {}
    cardList = table.clone(cardList)
    BattleUtilServer.Shuffle(battleEngine, cardList)
    BattleUtilServer.MoveNoEnchantToEnd(cardList)
    for i = 1, num do
      if not cardList[i] then
        break
      end
      table.insert(ret, cardList[i])
    end
    return ret
  end,
  [bc.BattleCardDeckPos.RANDOMNOENCHANT] = function(battleEngine, cardList, num)
    local ret = {}
    cardList = table.clone(cardList)
    BattleUtilServer.Shuffle(battleEngine, cardList)
    BattleUtilServer.MoveEnchantToEnd(cardList)
    for i = 1, num do
      if not cardList[i] then
        break
      end
      table.insert(ret, cardList[i])
    end
    return ret
  end,
  [bc.BattleCardDeckPos.RANDOM_NOT_ENCHANT] = function(battleEngine, cardList, num)
    local ret = {}
    local noEnchantCardList = {}
    for _, card in ipairs(cardList) do
      if not card.data.runes or not next(card.data.runes) then
        table.insert(noEnchantCardList, card)
      end
    end
    BattleUtilServer.Shuffle(battleEngine, noEnchantCardList)
    for i = 1, num do
      if not noEnchantCardList[i] then
        break
      end
      table.insert(ret, noEnchantCardList[i])
    end
    return ret
  end,
  [bc.BattleCardDeckPos.RANDOM_COSTNOT0] = function(battleEngine, cardList, num)
    local ret = {}
    cardList = table.clone(cardList)
    BattleUtilServer.Shuffle(battleEngine, cardList)
    for i = #cardList, 1, -1 do
      local card = cardList[i]
      if card:IsXCost() or 0 == card:GetCurCost() then
        table.remove(cardList, i)
      end
    end
    for i = 1, num do
      if not cardList[i] then
        break
      end
      table.insert(ret, cardList[i])
    end
    return ret
  end
}

function BattleCmdCardListExp._GetCardByPos(battleEngine, cardList, posType, num)
  local ret = {}
  if 0 == num then
    return ret
  end
  local posFunc = PosFunc[posType]
  if posFunc then
    do return posFunc, battleEngine, cardList end
    return posFunc, battleEngine, cardList, num
  else
    battleEngine:Error("_GetCardByPos no posType %s", posType)
  end
  return ret
end

function BattleCmdCardListExp:GetCard(posType, num)
  local cardDeck = rawget(self, "cardDeck")
  if cardDeck == bc.CardDeck.DrawDeck and 0 == #self.cardList then
    self.cmdParser.battleEngine.cardMgr:GenerateDrawDeck()
    self.cardList = self:_GenerateCardList(cardDeck)
  end
  local cardList = BattleCmdCardListExp._GetCardByPos(self.cmdParser.battleEngine, self.cardList, posType, num)
  local exp = BattleCmdCardListExp(self.cmdParser, cardList)
  return exp
end

function BattleCmdCardListExp:GetCardCount()
  return #self.cardList
end

function BattleCmdCardListExp:GetCardByEnchant(enchantTid)
  local cardList = {}
  for _, card in ipairs(self.cardList) do
    if card:HasEnchant(enchantTid) then
      table.insert(cardList, card)
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, cardList)
  return exp
end

function BattleCmdCardListExp:GetCardCountByID(cardID)
  if not cardID then
    return 0
  end
  local count = 0
  for _, card in ipairs(self.cardList) do
    if card.configData.ID == cardID then
      count = count + 1
    end
  end
  return count
end

function BattleCmdCardListExp:IsInDeck(deck)
  local card = self.cardList[1]
  return card.deck == deck:_GetDeckName() and 1 or 0
end

function BattleCmdCardListExp:GetCardByID(cardID, num)
  num = num or 1
  if not cardID then
    return 0
  end
  local count = 0
  local ret = {}
  for _, card in ipairs(self.cardList) do
    if num <= count then
      break
    end
    if card.configData.ID == cardID then
      table.insert(ret, card)
      count = count + 1
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:CardTypeMatch(...)
  if 0 == #self.cardList then
    return 0
  end
  local target = self.cardList[1]
  if not target then
    return 0
  end
  if not target.CardTypeMatch then
    return 0
  end
  local ret = target:CardTypeMatch({
    ...
  })
  if ret then
    return 1
  end
  return 0
end

function BattleCmdCardListExp:GetCardCountByType(cardTypes)
  if not cardTypes then
    return 0
  end
  if type(cardTypes) ~= "table" then
    cardTypes = {cardTypes}
  end
  local count = 0
  for _, card in ipairs(self.cardList) do
    if card:CardTypeMatch(cardTypes) then
      count = count + 1
    end
  end
  return count
end

function BattleCmdCardListExp:GetCardByType(cardTypes, num, pos, exceptTypes)
  if not cardTypes then
    do return BattleCmdCardListExp, self.cmdParser end
    return BattleCmdCardListExp, self.cmdParser, {}, nil, nil, nil, nil, nil, nil, nil
  end
  if type(cardTypes) ~= "table" then
    cardTypes = {cardTypes}
  end
  exceptTypes = exceptTypes or {}
  if type(exceptTypes) ~= "table" then
    exceptTypes = {exceptTypes}
  end
  num = num or 1
  local filteredCardList = {}
  pos = pos or bc.BattleCardDeckPos.TOP
  for _, card in ipairs(self.cardList) do
    if card:CardTypeMatch(cardTypes) and not card:CardTypeMatch(exceptTypes) then
      table.insert(filteredCardList, card)
    end
  end
  local ret = BattleCmdCardListExp._GetCardByPos(self.cmdParser.battleEngine, filteredCardList, pos, num)
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:GetCardByAwaker(awakerTid, num)
  num = num or 1
  local count = 0
  local ret = {}
  for _, card in ipairs(self.cardList) do
    if num <= count then
      break
    end
    if card.configData.AwakerID == awakerTid then
      count = count + 1
      table.insert(ret, card)
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:GetCardByAwakerExp(awakerExpList, num)
  num = num or 1
  local count = 0
  local ret = {}
  if awakerExpList.is and awakerExpList:is(BattleCmdTargetsExp) then
    awakerExpList = {awakerExpList}
  end
  local awakerUids = {}
  for _, exp in ipairs(awakerExpList) do
    for _, awaker in ipairs(exp.targets) do
      awakerUids[awaker.uid] = true
    end
  end
  for _, card in ipairs(self.cardList) do
    if num <= count then
      break
    end
    if awakerUids[card.owner.uid] then
      count = count + 1
      table.insert(ret, card)
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

local function sort_by_cost(cardA, cardB)
  if not cardA:GetCurCost() then
    return false
  end
  if not cardB:GetCurCost() then
    return true
  end
  return cardA:GetCurCost() > cardB:GetCurCost()
end

function BattleCmdCardListExp:GetMaxCostCard(num)
  local cardList = table.clone(self.cardList)
  table.sort(cardList, sort_by_cost)
  local pos = bc.BattleCardDeckPos.TOP
  local list = BattleCmdCardListExp._GetCardByPos(self.cmdParser.battleEngine, cardList, pos, num)
  local exp = BattleCmdCardListExp(self.cmdParser, list)
  return exp
end

function BattleCmdCardListExp:GetMinCostCard(num)
  local cardList = table.clone(self.cardList)
  table.sort(cardList, sort_by_cost)
  local pos = bc.BattleCardDeckPos.BOTTOM
  local ret = BattleCmdCardListExp._GetCardByPos(self.cmdParser.battleEngine, cardList, pos, num)
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:GetStateLayer(startTid)
  if not self.cardList or not self.cardList[1] then
    return 0
  end
  local target = self.cardList[1]
  local state = self.cmdParser.battleEngine.stateMgr:GetState(target, startTid)
  if not state or state.isDeleted then
    print("GetStateLayer not find startTid=" .. startTid)
    return 0
  end
  return state.data.layer or 0
end

function BattleCmdCardListExp:GetStateParam(stateTid, index)
  local target = self.cardList and self.cardList[1]
  if not target then
    return 0
  end
  local state = self.cmdParser.battleEngine.stateMgr:GetState(target, stateTid)
  if not state or state.isDeleted then
    return 0
  end
  return state.stateParams[index] or 0
end

function BattleCmdCardListExp:FuncGetEnchantCardNum(quality)
  local count = 0
  for _, card in ipairs(self.cardList) do
    local runes = card.data.runes
    if not runes or next(runes) == nil then
    elseif "All" == quality then
      count = count + 1
    else
      for _, runeTid in ipairs(runes) do
        local runeCfg = self.cmdParser.battleEngine.battleDT.EnchantConfig[runeTid]
        if runeCfg and runeCfg.Quality == quality then
          count = count + 1
        end
      end
    end
  end
  return count
end

function BattleCmdCardListExp:GetCardListByProperty(attrs, isOwnedAttr, num)
  if type(attrs) ~= "table" then
    attrs = {attrs}
  end
  num = num or 99
  local ret = {}
  for _, card in ipairs(self.cardList) do
    local ok = true
    for _, attr in ipairs(attrs) do
      local value = card:GetProperty(attr)
      if 1 == isOwnedAttr and value <= 0 then
        ok = false
        break
      elseif 0 == isOwnedAttr and value > 0 then
        ok = false
        break
      end
    end
    if ok then
      table.insert(ret, card)
    end
  end
  if num < #ret then
    ret = BattleCmdCardListExp._GetCardByPos(self.cmdParser.battleEngine, ret, bc.BattleCardDeckPos.RANDOM, num)
  end
  do return BattleCmdCardListExp, self.cmdParser end
  return BattleCmdCardListExp, self.cmdParser, ret, bc.BattleCardDeckPos.RANDOM, num, nil, false, table.insert, ret, card, ipairs(attrs)
end

function BattleCmdCardListExp:GetCardListByState(stateTids, isOwnedState, num)
  if type(stateTids) ~= "table" then
    stateTids = {stateTids}
  end
  num = num or 99
  local ret = {}
  local stateMgr = self.cmdParser.battleEngine.stateMgr
  for _, card in ipairs(self.cardList) do
    local ok = true
    for _, tid in ipairs(stateTids) do
      if 1 == isOwnedState and not stateMgr:HasStateByStateIds(card.uid, {tid}) then
        ok = false
        break
      elseif 0 == isOwnedState and stateMgr:HasStateByStateIds(card.uid, {tid}) then
        ok = false
        break
      end
    end
    if ok then
      table.insert(ret, card)
    end
  end
  if num < #ret then
    ret = BattleCmdCardListExp._GetCardByPos(self.cmdParser.battleEngine, ret, bc.BattleCardDeckPos.RANDOM, num)
  end
  do return BattleCmdCardListExp, self.cmdParser end
  return BattleCmdCardListExp, self.cmdParser, ret, bc.BattleCardDeckPos.RANDOM, num, nil, false, table.insert, ret, card, ipairs(stateTids)
end

function BattleCmdCardListExp:FuncGetAwakerCardNum(awakerExp)
  local count = 0
  for _, card in ipairs(self.cardList) do
    if card.owner.uid == awakerExp:GetAttr("uid") then
      count = count + 1
    end
  end
  return count
end

function BattleCmdCardListExp:GetCamp()
  return self.camp
end

function BattleCmdCardListExp:RemoveCardByID(cardID, num)
  local ret = {}
  local count = 0
  for i, card in ipairs(self.cardList) do
    if card.tid == cardID and num > count then
      count = count + 1
    else
      table.insert(ret, card)
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:RemoveCardByType(cardTypes)
  if type(cardTypes) ~= "table" then
    cardTypes = {cardTypes}
  end
  local ret = {}
  for i, card in ipairs(self.cardList) do
    if not card:CardTypeMatch(cardTypes) then
      table.insert(ret, card)
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:DeckSort(sortType, sortOrder)
  local sortFunc = {
    [bc.CardListSortType.HandDeckSort] = function()
      table.sort(self.cardList, function(cardA, cardB)
        do return self.SortCardByHandOrder, self, cardA end
        return self.SortCardByHandOrder, self, cardA, cardB
      end)
    end,
    [bc.CardListSortType.UnorderedSort] = function()
      BattleUtilServer.Shuffle(self.cmdParser.battleEngine, self.cardList)
    end,
    [bc.CardListSortType.CreatetimeSort] = function()
      table.sort(self.cardList, function(a, b)
        local ua = a and a.uid or 0
        local ub = b and b.uid or 0
        return ua < ub
      end)
    end
  }
  if sortFunc[sortType] then
    sortFunc[sortType]()
  end
  if sortOrder == bc.CardListSortOrder.ReverseSort and sortType ~= bc.CardListSortType.UnorderedSort then
    local list = {}
    for i = #self.cardList, 1, -1 do
      table.insert(list, self.cardList[i])
    end
    self.cardList = list
  end
  return self
end

function BattleCmdCardListExp:SortCardByHandOrder(cardA, cardB)
  local battleEngine = self.cmdParser.battleEngine
  local playerRole = battleEngine.roleMgr:GetPlayer(self.cmdParser:GetCasterCamp())
  local awakerUidA = cardA.ownerUid
  local awakerUidB = cardB.ownerUid
  if battleEngine:IsPVP() then
    if awakerUidA == playerRole.uid and awakerUidB ~= playerRole.uid then
      return false
    end
    if awakerUidA ~= playerRole.uid and awakerUidB == playerRole.uid then
      return true
    end
  end
  if awakerUidA ~= awakerUidB then
    if battleEngine:IsPVE() then
      return awakerUidA < awakerUidB
    else
      return awakerUidA > awakerUidB
    end
  end
  local baseSortA = cardA.configData.BaseSortID
  local baseSortB = cardB.configData.BaseSortID
  if baseSortA ~= baseSortB then
    return baseSortA < baseSortB
  end
  return cardA.uid < cardB.uid
end

function BattleCmdCardListExp:GetFirstTarget()
  local target = self.cardList and self.cardList[1]
  if not target then
    return
  end
  return target
end

function BattleCmdCardListExp:GetTargetList()
  return self.cardList
end

function BattleCmdCardListExp:RemoveByUniqueID(uid)
  local list = {}
  for _, card in ipairs(self.cardList) do
    if card.uid ~= uid then
      table.insert(list, card)
    end
  end
  do return BattleCmdCardListExp, self.cmdParser end
  return BattleCmdCardListExp, self.cmdParser, list, ipairs(self.cardList)
end

function BattleCmdCardListExp:GetCardByCost(cost, operator, num)
  num = num or 1
  local count = 0
  local ret = {}
  for _, card in ipairs(self.cardList) do
    if num <= count then
      break
    end
    local curCost = card:GetCurCost()
    if BattleUtilServer.Comparison(curCost, operator, cost) then
      count = count + 1
      table.insert(ret, card)
    end
  end
  local exp = BattleCmdCardListExp(self.cmdParser, ret)
  return exp
end

function BattleCmdCardListExp:CardTagMatch(...)
  if 0 == #self.cardList then
    return 0
  end
  local target = self.cardList[1]
  if not target then
    return 0
  end
  if not target.CardTagMatch then
    return 0
  end
  local ret = target:CardTagMatch({
    ...
  })
  if ret then
    return 1
  end
  return 0
end

return BattleCmdCardListExp
