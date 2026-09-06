-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/controller/TimelimitrankController.lua

module("logic.extensions.timelimitrank.controller.TimelimitrankController", package.seeall)

local TimelimitrankController = class("TimelimitrankController", BaseController)

TimelimitrankController.UPDATE_REDPOINT = "UPDATE_REDPOINT"

function TimelimitrankController:ctor()
	TimelimitrankController.super.ctor(self)
end

function TimelimitrankController:onInit()
	TimelimitrankController.super.onInit(self)

	self._dayS = 86400
	self._rankTypeData = {}
end

function TimelimitrankController:onReset()
	TimelimitrankController.super.onReset(self)

	self._rankTypeData = {}
end

function TimelimitrankController:isHaveRank()
	local defineList = self:getDefine()

	for index, value in ipairs(defineList) do
		if TimelimitrankController.instance:isOpenRank(value.startTime) then
			return value
		end
	end
end

function TimelimitrankController:pushView(id)
	local defineInfo = TimelimitrankModel.instance:getDefineById(id)

	if self:isOpenRank(defineInfo.startTime) and self:calculatePublicSurplusTime(defineInfo.endTime, defineInfo.promulgateDay) then
		UIStateManager.instance:push(ViewName.TimelimitrankView, id)
	else
		FloatWordMgr.instance:show(defineInfo.title .. "排行榜未开启")
	end
end

function TimelimitrankController:pushPrizeView(id)
	TimeLimitRankAgent.instance:sendPM_TimeLimitRankGetProgressInfoReq(function(msg)
		for i, value in ipairs(msg.progressInfo) do
			TimelimitrankModel.instance:setProgressInfo(value.id, value.progress, value.progressPrize)
		end

		UIStateManager.instance:push(ViewName.TimelimitrankprizeView, id)
	end)
end

function TimelimitrankController:getDefine()
	local defineList = TimelimitrankModel.instance:getDefine()
	local result = {}

	for k, value in ipairs(defineList) do
		if self:calculatePublicSurplusTime(value.endTime, value.promulgateDay) then
			table.insert(result, value)
		end
	end

	table.sort(result, function(a, b)
		return a.id < b.id
	end)

	return result
end

function TimelimitrankController:isRedPoint(id)
	local progressInfo = TimelimitrankModel.instance:getProgressInfo(id)

	if progressInfo == nil then
		return false
	end

	local prizeList = TimelimitrankModel.instance:getProgressPrizeById(TimelimitrankConfig.instance:getDefineById(id).progressPrizeId)

	for index, value in ipairs(prizeList) do
		if progressInfo.progress >= value.progress and not progressInfo.progressPrize[index] then
			return true
		end
	end
end

function TimelimitrankController:checkRedPoint(id, callback)
	TimeLimitRankAgent.instance:sendPM_TimeLimitRankGetProgressInfoReq(function(msg, state)
		if state == 0 then
			for i, value in ipairs(msg.progressInfo) do
				TimelimitrankModel.instance:setProgressInfo(value.id, value.progress, value.progressPrize)
			end

			local ret = self:isRedPoint(id)

			GameUtil.callBack(callback, ret)
		end

		GameUtil.callBack(callback, false)
	end)
end

function TimelimitrankController:isOpenRank(startTime)
	return ServerTime.now() - startTime > 0
end

function TimelimitrankController:calculateSurplusTime(endTime)
	local surplusTime = endTime - ServerTime.now()

	if surplusTime >= 0 then
		local string_date = GameUtil.formatTimeStamp("!%H时%M分%S秒", surplusTime)
		local day = math.floor(surplusTime / self._dayS)

		return day .. "天" .. string_date
	else
		return nil
	end
end

function TimelimitrankController:calculatePublicSurplusTime(endTime, promulgateDay)
	local surplusTime = endTime + promulgateDay * self._dayS - ServerTime.now()

	if surplusTime >= 0 then
		local string_date = GameUtil.formatTimeStamp("!%H时%M分%S秒", surplusTime)
		local day = math.floor(surplusTime / self._dayS)

		return day .. "天" .. string_date
	else
		return nil
	end
end

function TimelimitrankController:getRankTypeData(rankId, handler, handlerObj)
	if self:_isNeedUpdate(self._rankTypeData[rankId]) then
		TimeLimitRankAgent.instance:sendPM_TimeLimitRankGetTopInfoReq(rankId, function(msg)
			local nowTime = ServerTime.now()
			local updateFlag = self._rankTypeData[rankId] == nil or nowTime > self._rankTypeData[rankId].nextUpdate + 600

			if not updateFlag then
				if not self._rankTypeData[rankId].rankInfo then
					do
						local rankInfo = {}

						for i, value in ipairs(msg.rankInfo) do
							if self._rankTypeData[rankId].rankInfo[i] == nil or self:_rankInfoEqual(self._rankTypeData[rankId].rankInfo[i], value) then
								updateFlag = true

								break
							end
						end
					end

					if updateFlag then
						self._rankTypeData[rankId] = {
							rankInfo = msg.rankInfo,
							myRank = msg.myRank
						}
						self._rankTypeData[rankId].nextUpdate = nowTime - nowTime % 600 + 600
					end
				end
			end

			handler(handlerObj, msg)
		end)
	else
		handler(handlerObj, self._rankTypeData[rankId])
	end
end

function TimelimitrankController:_isNeedUpdate(rankData)
	if rankData then
		return rankData.nextUpdate and ServerTime.now() > rankData.nextUpdate
	else
		return true
	end
end

function TimelimitrankController:_rankInfoEqual(a, b)
	return a.headInfo.userId == b.headInfo.userId and a.headInfo.userName == b.headInfo.userName and a.familyName == b.familyName and a.passTime == b.passTime and a.rank == b.rank and a.progressId == b.progressId and a.headIconId == b.headIcon
end

TimelimitrankController.instance = TimelimitrankController.New()

return TimelimitrankController
