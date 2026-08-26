-- chunkname: @modules/logic/seasonver/act166/model/Season166TrainModel.lua

module("modules.logic.seasonver.act166.model.Season166TrainModel", package.seeall)

local Season166TrainModel = class("Season166TrainModel", BaseModel)

function Season166TrainModel:onInit()
	self:reInit()
end

function Season166TrainModel:reInit()
	self:cleanData()
end

function Season166TrainModel:cleanData()
	self.curTrainId = 0
	self.curTrainConfig = nil
	self.curEpisodeId = nil
end

function Season166TrainModel:initTrainData(actId, trainId)
	self.actId = actId
	self.curTrainId = trainId
	self.curTrainConfig = Season166Config.instance:getSeasonTrainCo(actId, trainId)
	self.curEpisodeId = self.curTrainConfig and self.curTrainConfig.episodeId
end

function Season166TrainModel:checkIsFinish(actId, trainId)
	local actMO = Season166Model.instance:getActInfo(actId)
	local trainMO = actMO.trainInfoMap[trainId]

	return trainMO and trainMO.passCount > 0
end

function Season166TrainModel:getCurTrainPassCount(actId)
	local passCount = 0
	local trainCoList = Season166Config.instance:getSeasonTrainCos(actId)

	for index, trainCo in ipairs(trainCoList) do
		if self:checkIsFinish(actId, trainCo.trainId) then
			passCount = passCount + 1
		end
	end

	return passCount
end

function Season166TrainModel:isHardEpisodeUnlockTime(actId)
	local actMO = ActivityModel.instance:getActMO(actId)
	local offsetTime = Season166Config.instance:getSeasonConstNum(actId, Season166Enum.SpOpenTimeConstId)

	offsetTime = offsetTime > 0 and offsetTime - 1

	local runTimeSec = ServerTime.now() - actMO:getRealStartTimeStamp()
	local runTime = math.floor(runTimeSec / TimeUtil.OneDaySecond)
	local isOpenTime = offsetTime <= runTime
	local remainTime = offsetTime - runTime

	return isOpenTime, remainTime
end

function Season166TrainModel:getUnlockTrainInfoMap(actId)
	local Season166MO = Season166Model.instance:getActInfo(actId)

	return tabletool.copy(Season166MO.trainInfoMap)
end

Season166TrainModel.instance = Season166TrainModel.New()

return Season166TrainModel
