-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/model/TunTianHelpModel.lua

module("logic.extensions.tuntianhelp.model.TunTianHelpModel", package.seeall)

local TunTianHelpModel = class("TunTianHelpModel", BaseModel)

function TunTianHelpModel:ctor()
	return
end

function TunTianHelpModel:onInit()
	self:onReset()
end

function TunTianHelpModel:onReset()
	self._dailyLotteryTimes = 0
	self._prizeIdOfLottery = 0
	self._changeSetIdOfLottery = 0
end

function TunTianHelpModel:handlePM_TunTianHelpGetInfoRes(msg)
	self._dailyLotteryTimes = msg.dailyLotteryTimes
end

function TunTianHelpModel:handlePM_TunTianHelpLotteryRes(msg)
	self._dailyLotteryTimes = msg.dailyLotteryTimes
	self._prizeIdOfLottery = msg.prizeId
	self._changeSetIdOfLottery = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self._changeSetIdOfLottery)
end

function TunTianHelpModel:getDailyLotteryTimes()
	return self._dailyLotteryTimes
end

function TunTianHelpModel:getPrizeIdOfLottery()
	return self._prizeIdOfLottery
end

function TunTianHelpModel:getChangeSetIdOfLottery()
	return self._changeSetIdOfLottery
end

function TunTianHelpModel:isUsedAllLotteryTimes(activityId)
	local cfg = TunTianHelpConfig.instance:getTthActBaseData(activityId)

	if cfg then
		if not cfg.dailyTimesLimit then
			local maxLimit = 0

			return maxLimit <= self._dailyLotteryTimes
		end
	end
end

TunTianHelpModel.instance = TunTianHelpModel.New()

return TunTianHelpModel
