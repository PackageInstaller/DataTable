-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameMo.lua

module("logic.extensions.landlords.view.FalGameMo", package.seeall)

local FalGameMo = class("FalGameMo")

function FalGameMo:ctor()
	return
end

function FalGameMo:init(activityId, gameId)
	self._activityId = activityId
	self._gameId = gameId
	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()
	self._gameData = FightAgainstLandlordsConfig.instance:getFalGameData(self._activityId, self._gameId)
	self._playerMoPool = {}
	self._userIdList = {}
	self._falCustomFmtMo = nil
	self._fightInfo = {}
	self._fightInfo.simpleFrom = {}
	self._fightInfo.roundId = 0
	self._fightInfo.waitSecond = 0
	self._fightInfo.opUserIdList = {}
	self._grabNum = 0
end

function FalGameMo:initPlayerMoPool(userIdList)
	self._userIdList = userIdList

	for _, userId in ipairs(self._userIdList) do
		local mo = {}

		mo.userId = userId
		mo.identity = GameEnum.FalIdentity.Nothing
		mo.headInfo = nil
		mo.tokenScore = 0
		mo.bagCreepsIds = {}
		mo.fmtCreepsIds = {}

		for _, identity in pairs(GameEnum.FalIdentity) do
			mo.fmtCreepsIds[identity] = {}
		end

		mo.buffIds = {}

		for _, identity in pairs(GameEnum.FalIdentity) do
			mo.buffIds[identity] = {}
		end

		self._playerMoPool[userId] = mo
	end
end

function FalGameMo:getPlayerMo(userId)
	return self._playerMoPool[userId]
end

function FalGameMo:getPlayerUserIdList()
	return self._userIdList
end

function FalGameMo:getUserIdListAsSameTeam(teamId)
	local userIdLists = {}

	for _, userId in ipairs(self:getPlayerUserIdList()) do
		if self:getTeamId(userId) == teamId then
			table.insert(userIdLists, userId)
		end
	end

	return userIdLists
end

function FalGameMo:getActivityId()
	return self._activityId
end

function FalGameMo:getGameId()
	return self._gameId
end

function FalGameMo:getLandlordsUserId()
	local res = 0

	for userId, mo in pairs(self._playerMoPool) do
		if mo.identity == GameEnum.FalIdentity.Landlord then
			res = userId

			break
		end
	end

	return res
end

function FalGameMo:getIdentity(userId)
	return self:getPlayerMo(userId).identity
end

function FalGameMo:setIdentity(userId, identity)
	self:getPlayerMo(userId).identity = identity
end

function FalGameMo:getTeamId(userId)
	return self:getIdentity(userId) == self:getIdentity(self._myUserId) and 0 or 1
end

function FalGameMo:getMyTeamId()
	return self:getTeamId(self._myUserId)
end

function FalGameMo:getHeadInfo(userId)
	return self:getPlayerMo(userId).headInfo
end

function FalGameMo:setHeadInfo(userId, headInfo)
	self:getPlayerMo(userId).headInfo = headInfo
end

function FalGameMo:getTokenScore(userId)
	return self:getPlayerMo(userId).tokenScore
end

function FalGameMo:setTokenScore(userId, tokenScore)
	self:getPlayerMo(userId).tokenScore = tokenScore
end

function FalGameMo:getProfit(userId)
	local profit = self._gameData.initialScore

	profit = profit * self:getRateValue()

	if self:getIdentity(userId) == GameEnum.FalIdentity.Farmer then
		profit = Mathf.Floor(profit / 2)
	end

	return profit
end

function FalGameMo:getRateValue()
	return Mathf.Pow(2, Mathf.Max(self._grabNum - 1, 0))
end

function FalGameMo:getGrabNum()
	return self._grabNum
end

function FalGameMo:setGrabNum(grabNum)
	self._grabNum = grabNum
end

function FalGameMo:getBagCreepsIdsAsSameTeam(teamId)
	local bagPetIdList = {}
	local userIdList = self:getUserIdListAsSameTeam(teamId)

	for _, userId in ipairs(userIdList) do
		local creepsIds = self:getBagCreepsIdsAsUser(userId)

		TableUtil.AddTable(bagPetIdList, creepsIds)
	end

	return bagPetIdList
end

function FalGameMo:getBagCreepsIdsAsUser(userId)
	return self:getPlayerMo(userId).bagCreepsIds
end

function FalGameMo:setBagCreepsIds(userId, creepsIds)
	table.clear(self:getPlayerMo(userId).bagCreepsIds)

	for _, v in ipairs(creepsIds) do
		table.insert(self:getPlayerMo(userId).bagCreepsIds, v)
	end
end

function FalGameMo:getBuffIdsAsSameTeam(teamId)
	local list = {}
	local userIdList = self:getUserIdListAsSameTeam(teamId)

	for _, userId in ipairs(userIdList) do
		local buffIds = self:getAllBuffIds(userId)

		TableUtil.AddTable(list, buffIds)
	end

	return list
end

function FalGameMo:getAllBuffIds(userId)
	local buffIds = {}
	local lists = {}

	for _, identity in pairs(GameEnum.FalIdentity) do
		local list = self:getBuffIds(userId, identity)

		if list then
			table.insert(lists, list)
		end
	end

	for _, ids in ipairs(lists) do
		for _, id in ipairs(ids) do
			table.insert(buffIds, id)
		end
	end

	return buffIds
end

function FalGameMo:getBuffIds(userId, identity)
	return self:getPlayerMo(userId).buffIds[identity]
end

function FalGameMo:setBuffIds(userId, buffIds, identity)
	local mo = self:getPlayerMo(userId)

	mo.buffIds[identity] = buffIds
end

function FalGameMo:getFalCustomFmtMo()
	return self._falCustomFmtMo
end

function FalGameMo:setFalCustomFmtMo(customFmtMo)
	self._falCustomFmtMo = customFmtMo
end

function FalGameMo:getSimpleFormByTeamId(teamId)
	local simpleForm
	local identity = self:getIdentity(self._myUserId)

	return teamId == 0 and self._fightInfo.simpleFrom[identity] or identity == GameEnum.FalIdentity.Farmer and self._fightInfo.simpleFrom[GameEnum.FalIdentity.Landlord] or self._fightInfo.simpleFrom[GameEnum.FalIdentity.Farmer]
end

function FalGameMo:setSimpleForm(simpleForm, identity)
	self._fightInfo.simpleFrom[identity] = simpleForm
end

function FalGameMo:getCurOpUserIdListInLeft()
	return self._fightInfo.opUserIdList or {}
end

function FalGameMo:setCurOpUserIdListInLeft(userIdList)
	self._fightInfo.opUserIdList = userIdList
end

function FalGameMo:getRoundId()
	return self._fightInfo.roundId
end

function FalGameMo:setRoundId(roundId)
	self._fightInfo.roundId = roundId
end

function FalGameMo:getMaxPetNumAllPlayerInFmt(roundId, identity)
	local num = 0

	for id = 1, roundId do
		num = num + self:getMaxPetNumOnePlayerInFmt(id, identity)
	end

	return num
end

function FalGameMo:getMaxPetNumOnePlayerInFmt(roundId, identity)
	local list

	return checknumber((identity == GameEnum.FalIdentity.Landlord and {
		3,
		2,
		2,
		2,
		2,
		2
	} or {
		3,
		3,
		3,
		3,
		3,
		3
	})[roundId])
end

function FalGameMo:getWaitSecondInFight()
	return self._fightInfo.waitSecond
end

function FalGameMo:setWaitSecondInFight(waitSecond)
	self._fightInfo.waitSecond = waitSecond
end

function FalGameMo:getAllCreepsIds()
	local userIds = self:getPlayerUserIdList()
	local creepsIds = {}

	for i, v in ipairs(userIds) do
		table.insertto(creepsIds, self:getPlayerMo(v).bagCreepsIds)
	end

	return creepsIds
end

return FalGameMo
