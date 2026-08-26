-- chunkname: @modules/logic/versionactivity2_6/xugouji/model/Activity188Model.lua

module("modules.logic.versionactivity2_6.xugouji.model.Activity188Model", package.seeall)

local Activity188Model = class("Activity188Model", BaseModel)

function Activity188Model:onInit()
	self:_initData()
end

function Activity188Model:reInit()
	self:_initData()
end

function Activity188Model:_initData()
	self._passEpisodes = {}
	self._unlockEpisodes = {}
	self._episodeDatas = {}
	self._unLockCount = 0
	self._finishedCount = 0

	self:clearGameInfo()
end

function Activity188Model:clearGameInfo()
	self._round = 0
	self._isMyTurn = true
	self._curTurnOperateTime = 0
	self._gameState = XugoujiEnum.GameStatus.Operatable
	self._gameViewState = XugoujiEnum.GameViewState.PlayerOperating
	self._playerInitialHP = 0
	self._enemyInitialHP = 0
	self._curHP = 0
	self._enenyHP = 0
	self._curPairCount = 0
	self._enenyPairCount = 0
	self._playerAbilityIds = {}
	self._enemyAbilityIds = {}
	self._curTurnOperateTime = 0
	self._enemyOperateTimeLeft = 0
	self._curCardUid = 0
	self._cardsInfo = {}
	self._cardsInfoList = {}
	self._cardsEffect = {}
	self._cardItemState = {}
	self._lastCardStatus = 0
	self._lastCardId = 0
	self._lastCardInfoUId = 0
	self._playerBuffs = {}
	self._enemyBuffs = {}
	self._guideMode = false
	self._isHpZero = false
end

function Activity188Model:onAct188GameInfoUpdate(gameInfo)
	self:clearGameInfo()

	if self._cardsInfo then
		self._cardsInfo = self._cardsInfo or {}
	end

	local episodeId = Activity188Model.instance:getCurEpisodeId()
	local episodeCfg = Activity188Config.instance:getEpisodeCfgByEpisodeId(episodeId)

	self._gameId = episodeCfg.gameId

	if self._gameId then
		self:setRound(gameInfo.round)

		local cardInfos = gameInfo.cards

		self:updateCardInfo(cardInfos)
		self:_setCurHP(gameInfo.team.hp)
		self:_setEnemyHP(gameInfo.bossTeam.hp)
		self:setInitialHP(gameInfo.team.hp, gameInfo.bossTeam.hp)
		self:_setCurPairCount(gameInfo.team.pairCount)
		self:_setEnemyPairCount(gameInfo.bossTeam.pairCount)
		self:setPlayerAbilityIds(gameInfo.team.abilityIds)
		self:setEnemyAbilityIds(gameInfo.bossTeam.abilityIds)
		self:setCurTurnOperateTime(gameInfo.team.maxReverseCount)
		self:setCurTurnOperateTime(gameInfo.bossTeam.maxReverseCount, true)
	end
end

function Activity188Model:updateCardInfo(cardInfos)
	for idx, cardInfo in ipairs(cardInfos) do
		self._cardsInfo[cardInfo.uid] = cardInfo
		self._cardsInfoList[idx] = cardInfo
	end
end

function Activity188Model:updateCardStatus(uid, status)
	local cardInfo = self:getCardInfo(uid)

	if cardInfo then
		cardInfo.status = status
		self._lastUid = uid
		self._lastCardStatus = status
		self._lastCardId = cardInfo.id
	end
end

function Activity188Model:updateCardEffectStatus(uid, add, effectStatus)
	local cardEffect = self:getCardEffect(uid)

	if not cardEffect then
		self._cardsEffect[uid] = {}
	end

	if add then
		self._cardsEffect[uid][effectStatus] = true
	elseif effectStatus == 0 then
		self._cardsEffect[uid] = {}
	else
		self._cardsEffect[uid][effectStatus] = false
	end
end

function Activity188Model:clearCardsInfo()
	self._cardsInfo = {}
	self._cardsInfoList = {}
	self._cardsEffect = {}
	self._cardItemState = {}
end

function Activity188Model:getCardsInfo()
	return self._cardsInfo
end

function Activity188Model:getCardsInfoList()
	return self._cardsInfoList
end

function Activity188Model:getCardsInfoSortedList()
	local sortList = {}
	local colNum = Activity188Model.instance:getCardColNum()

	for _, cardInfo in ipairs(self._cardsInfoList) do
		local idx = cardInfo.y + 1 + cardInfo.x * colNum

		sortList[idx] = cardInfo
	end

	return sortList
end

function Activity188Model:getCardColNum()
	local cardGridColNum = 0

	for _, cardInfo in ipairs(self._cardsInfoList) do
		cardGridColNum = cardGridColNum < cardInfo.y and cardInfo.y or cardGridColNum
	end

	return cardGridColNum + 1
end

function Activity188Model:getCardInfo(cardUid)
	return self._cardsInfo[cardUid]
end

function Activity188Model:getCardEffect(cardUid)
	return self._cardsEffect[cardUid]
end

function Activity188Model:addOpenedCard(cardUid)
	if self._openedCardList then
		self._openedCardList = self._openedCardList or {}
	end

	self._openedCardList[#self._openedCardList + 1] = cardUid
end

function Activity188Model:getLastCardPair()
	if not self._openedCardList or #self._openedCardList < 2 then
		return nil
	end

	return self._openedCardList[#self._openedCardList], self._openedCardList[#self._openedCardList - 1]
end

function Activity188Model:getLastCardUid()
	return self._lastUid
end

function Activity188Model:getLastCardStatus()
	return self._lastCardStatus
end

function Activity188Model:getLastCardId()
	return self._lastCardId
end

function Activity188Model:setLastCardInfoUId(value)
	self._lastCardInfoUId = value
end

function Activity188Model:getLastCardInfoUId()
	return self._lastCardInfoUId
end

function Activity188Model:setCurCardUid(uid)
	self._curCardUid = uid
end

function Activity188Model:getCurCardUid()
	return self._curCardUid
end

function Activity188Model:setCurActId(actId)
	self._curActId = actId
end

function Activity188Model:getCurActId()
	return self._curActId
end

function Activity188Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity188Model:getCurEpisodeId()
	return self._curEpisodeId
end

function Activity188Model:setCurBattleEpisodeId(episodeId)
	self._curBattleEpisodeId = episodeId
end

function Activity188Model:getCurBattleEpisodeId()
	return self._curBattleEpisodeId
end

function Activity188Model:isEpisodeFinish(episodeId)
	return self._passEpisodes[episodeId]
end

function Activity188Model:getCurGameId()
	return self._gameId
end

function Activity188Model:setCurTurnOperateTime(time, isEnemy)
	if isEnemy then
		self._enemyOperateTimeLeft = time
	else
		self._curTurnOperateTime = time
	end
end

function Activity188Model:getCurTurnOperateTime()
	return self._curTurnOperateTime
end

function Activity188Model:getEnemyOperateTime()
	return self._enemyOperateTimeLeft
end

function Activity188Model:setRound(round)
	self._round = round
end

function Activity188Model:getRound()
	return self._round
end

function Activity188Model:getGameTurn()
	return self._curCardUid
end

function Activity188Model:isMyTurn()
	return self._isMyTurn
end

function Activity188Model:setTurn(isMyTurn)
	if self._isMyTurn == false and isMyTurn then
		self:setRound(self:getRound() + 1)
	end

	self._isMyTurn = isMyTurn
end

function Activity188Model:updateHp(isPlayer, modifiedValue)
	local modifiedNum = tonumber(modifiedValue)

	if isPlayer then
		self._curHP = self._curHP + modifiedNum
	else
		self._enenyHP = self._enenyHP + modifiedNum
	end
end

function Activity188Model:checkHpZero(modifiedValue)
	local modifiedNum = tonumber(modifiedValue)

	self._isHpZero = self._curHP + modifiedNum <= 0

	return self._isHpZero
end

function Activity188Model:isHpZero()
	return self._isHpZero
end

function Activity188Model:_setCurHP(hp)
	self._curHP = hp and hp or 0
end

function Activity188Model:getCurHP()
	return self._curHP
end

function Activity188Model:_setEnemyHP(hp)
	self._enenyHP = hp and hp or 0
end

function Activity188Model:getEnemyHP()
	return self._enenyHP
end

function Activity188Model:setInitialHP(playerHp, enemyHp)
	self._playerInitialHP = tonumber(playerHp)
	self._enemyInitialHP = tonumber(enemyHp)
end

function Activity188Model:getPlayerInitialHP()
	return self._playerInitialHP
end

function Activity188Model:getEnemyInitialHP()
	return self._enemyInitialHP
end

function Activity188Model:setPairCount(count, isMyself)
	if isMyself then
		self._curPairCount = count
	else
		self._enenyPairCount = count
	end
end

function Activity188Model:_setCurPairCount(count)
	self._curPairCount = count
end

function Activity188Model:getCurPairCount()
	return self._curPairCount
end

function Activity188Model:_setEnemyPairCount(count)
	self._enenyPairCount = count
end

function Activity188Model:getEnemyPairCount()
	return self._enenyPairCount
end

function Activity188Model:setPlayerAbilityIds(abilityIds)
	self._playerAbilityIds = abilityIds
end

function Activity188Model:getPlayerAbilityIds()
	return self._playerAbilityIds
end

function Activity188Model:setEnemyAbilityIds(abilityIds)
	self._enemyAbilityIds = abilityIds
end

function Activity188Model:getEnemyAbilityIds()
	return self._enemyAbilityIds
end

function Activity188Model:setBuffs(buffList, isPlayer)
	if isPlayer then
		self._playerBuffs = buffList
	else
		self._enemyBuffs = buffList
	end
end

function Activity188Model:getBuffs(isPlayer)
	return (isPlayer or nil) and (self._playerBuffs or self._enemyBuffs)
end

function Activity188Model:setGameState(state)
	self._gameState = state
end

function Activity188Model:getGameState()
	return self._gameState
end

function Activity188Model:setGameViewState(state)
	self._gameViewState = state
end

function Activity188Model:getGameViewState()
	return self._gameViewState
end

function Activity188Model:setCardItemStatue(cardUId, state)
	self._cardItemState[cardUId] = state
end

function Activity188Model:getCardItemStatue(cardUId)
	return self._cardItemState[cardUId]
end

function Activity188Model:setGameGuideMode(isGuide)
	self._guideMode = isGuide and tonumber(isGuide) == 1
end

function Activity188Model:isGameGuideMode()
	return self._guideMode
end

function Activity188Model:onGetActInfoReply(act188Episodes)
	self._unLockCount = 0
	self._finishedCount = 0

	for _, episodeData in ipairs(act188Episodes) do
		local episodeId = episodeData.episodeId

		self._episodeDatas[episodeId] = episodeData
		self._unlockEpisodes[episodeId] = true
		self._unLockCount = self._unLockCount + 1

		if episodeData.isFinished then
			self._passEpisodes[episodeId] = true
			self._finishedCount = self._finishedCount + 1
		end
	end
end

function Activity188Model:onEpisodeInfoUpdate(episodeId, finished)
	local curEpisodeCfg = Activity188Config.instance:getEpisodeCfgByEpisodeId(episodeId)

	if curEpisodeCfg and not self._unlockEpisodes[episodeId] then
		self._unlockEpisodes[episodeId] = true
		self._unLockCount = self._unLockCount + 1

		local preEpisodeId = curEpisodeCfg.preEpisodeId

		if not self._passEpisodes[preEpisodeId] then
			self._passEpisodes[preEpisodeId] = true
			self._finishedCount = self._finishedCount + 1
		end
	end
end

function Activity188Model:onStoryEpisodeFinish(episodeId)
	if not self._passEpisodes[episodeId] then
		self._passEpisodes[episodeId] = true
		self._finishedCount = self._finishedCount + 1
	end

	local nextEpisode = Activity188Config.instance:getEpisodeCfgByPreEpisodeId(episodeId)

	if nextEpisode and not self._unlockEpisodes[nextEpisode.episodeId] then
		self._unlockEpisodes[nextEpisode.episodeId] = true
		self._unLockCount = self._unLockCount + 1
	end
end

function Activity188Model:getUnlockCount()
	return (self._unLockCount or nil) and (self._unLockCount or 10)
end

function Activity188Model:getFinishedCount()
	return self._finishedCount
end

function Activity188Model:isEpisodeUnlock(episodeId)
	return self._unlockEpisodes[episodeId]
end

function Activity188Model:isEpisodeFinished(episodeId)
	return self._passEpisodes[episodeId]
end

Activity188Model.instance = Activity188Model.New()

return Activity188Model
