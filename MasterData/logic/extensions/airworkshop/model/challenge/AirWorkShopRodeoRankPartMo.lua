-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/challenge/AirWorkShopRodeoRankPartMo.lua

module("logic.extensions.airworkshop.model.challenge.AirWorkShopRodeoRankPartMo", package.seeall)

local M = class("AirWorkShopRodeoRankPartMo")

function M:ctor()
	self._rodeoRankList = {}
end

function M:setLastUpdateTime(ts)
	self._lastUpdateTimeStamp = ts
end

function M:getLastUpdateTime()
	return self._lastUpdateTimeStamp or 0
end

function M:canReqNewRankDataFromServer()
	local now = ServerTime.now()
	local last = self:getLastUpdateTime()
	local timeInterval = AirWorkShopEnum.DefaultRankReqTimeInterval
	local passTime = timeInterval <= now - last
	local lastUpdateOffset = self:getLastUpdateRankListCountOffset()

	if lastUpdateOffset == 0 then
		if enableLog and not passTime then
			printWarn(string.format("week[%s]part[%s]请求间隔过短,不发送请求, last:%s", self:getWeek(), self:getPart(), last))
		end

		return passTime, passTime
	elseif self:isMaxShowRankCount() then
		if enableLog and not passTime then
			printWarn(string.format("week[%s]part[%s]请求间隔过短,不发送请求, last:%s", self:getWeek(), self:getPart(), last))
		end

		return passTime, passTime
	else
		return true, passTime
	end
end

function M:updateFromServer(rankReqInfo)
	self:setLastUpdateTime(ServerTime.now())

	if Astral.OSDef.isEditor then
		TableUtil.dump(rankReqInfo)
	end

	self._week = rankReqInfo.week
	self._part = rankReqInfo.part

	local startIndex = rankReqInfo.startIndex
	local endIndex = rankReqInfo.endIndex
	local listRankEntryNO = rankReqInfo.listRankEntryNO or {}
	local myRankEntryNO = rankReqInfo.myRankEntryNO
	local maxShowRankCount = self:getMaxShowRankCount()
	local lastRankListCount = self:getRankListCount()

	if not self._rodeoRankList then
		self._rodeoRankList = {}
	end

	for _, _rankEntryNO in pairs(listRankEntryNO) do
		if _rankEntryNO and _rankEntryNO.rank and maxShowRankCount >= _rankEntryNO.rank then
			local _rank = _rankEntryNO.rank

			if not self._rodeoRankList[_rank] then
				self._rodeoRankList[_rank] = AirWorkShopRodeoRankMo.New()
			end

			self._rodeoRankList[_rank]:updateFromServer(_rankEntryNO, self._week, self._part)
		end
	end

	if not self._playerRankMO then
		self._playerRankMO = AirWorkShopRodeoRankMo.New()
	end

	self._playerRankMO:updateFromServer(myRankEntryNO, self._week, self._part)

	if rankReqInfo.useFakeData then
		for i = startIndex, endIndex do
			local _rank = i

			if _rank <= maxShowRankCount then
				local _data = {
					userId = _rank * 1000,
					rank = _rank,
					nickname = string.format("虚假数据%s号玩家", _rank),
					playerLv = math.random(1, 99),
					portrait = PlayerModel.instance:getMyPlayerInfo().portrait,
					displayCard = {},
					airRodeo = {
						lv = 1,
						score = 1
					}
				}

				if not self._rodeoRankList[_rank] then
					self._rodeoRankList[_rank] = AirWorkShopRodeoRankMo.New()
				end

				self._rodeoRankList[_rank]:updateFromServer(_data, self._week, self._part)
			end
		end
	end

	self:setLastUpdateRankListCountOffset(self:getRankListCount() - lastRankListCount)
end

function M:getLastUpdateRankListCountOffset()
	return self._lastUpdateRankListCountOffset or 1
end

function M:setLastUpdateRankListCountOffset(num)
	self._lastUpdateRankListCountOffset = num
end

function M:getWeek()
	return self._week
end

function M:getPart()
	return self._part
end

function M:getMaxShowRankCount()
	return AirWorkShopEnum.DefaultMaxRankShow
end

function M:getRankList()
	return self._rodeoRankList
end

function M:getRankListCount()
	local rankList = self:getRankList()
	local count = rankList and #rankList or 0

	return count
end

function M:isMaxShowRankCount()
	local rankList = self:getRankList()
	local len = rankList and #rankList or 0

	return len >= self:getMaxShowRankCount()
end

function M:getPlayerRankMO()
	return self._playerRankMO
end

function M:getPlayerRankScore()
	local playerRankMo = self:getPlayerRankMO()

	if playerRankMo then
		return playerRankMo:getAirScore()
	end

	return nil
end

return M
