-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/model/TimelimitrankModel.lua

module("logic.extensions.timelimitrank.model.TimelimitrankModel", package.seeall)

local TimelimitrankModel = class("TimelimitrankModel", BaseModel)

function TimelimitrankModel:ctor()
	TimelimitrankModel.super.ctor(self)
end

function TimelimitrankModel:onInit()
	TimelimitrankModel.super.onInit(self)

	self._topPrize = {}
	self._progressPrize = {}
	self._progressInfo = {}
end

function TimelimitrankModel:onReset()
	TimelimitrankModel.super.onReset(self)

	self._topPrize = {}
	self._progressPrize = {}
	self._progressInfo = {}
	self._define = nil
end

function TimelimitrankModel:initDefine()
	local defineList = TimelimitrankConfig.instance:getDefine()

	self._define = {}

	local cfgs, flag = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.HeroTrial), {}

	for i, cfg in ipairs(cfgs) do
		flag[cfg.activityId] = ActivityDefineController.instance:isRelateServerBy(cfg.relatedAreaIds)
	end

	for k, value in pairs(defineList) do
		if type(value) == "table" and value.id and flag[value.id] then
			local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.HeroTrial, value.id)

			value.startTime = startTime
			value.endTime = endTime

			table.insert(self._define, value)
		end
	end
end

function TimelimitrankModel:getDefine()
	if self._define == nil then
		self:initDefine()
	end

	return self._define
end

function TimelimitrankModel:getDefineById(id)
	if self._define == nil then
		self:initDefine()
	end

	for index, value in ipairs(self._define) do
		if id == value.id then
			return value
		end
	end
end

function TimelimitrankModel:setProgressInfo(id, progress, progressPrize)
	self._progressInfo[id] = {}
	self._progressInfo[id].progress = progress
	self._progressInfo[id].progressPrize = progressPrize
end

function TimelimitrankModel:setProgressPrizeInfo(id, index, flag)
	self._progressInfo[id].progressPrize[index] = flag
end

function TimelimitrankModel:getProgressInfo(id)
	return self._progressInfo[id]
end

function TimelimitrankModel:getTopPrizeById(rankPrizeId)
	if self._topPrize[rankPrizeId] then
		return self._topPrize[rankPrizeId]
	else
		self._topPrize[rankPrizeId] = {}

		local topPrize = TimelimitrankConfig.instance:getTopPrizeById(rankPrizeId)

		for key, value in pairs(topPrize) do
			table.insert(self._topPrize[rankPrizeId], value)
		end

		table.sort(self._topPrize[rankPrizeId], function(a, b)
			return a.startRank < b.startRank
		end)

		return self._topPrize[rankPrizeId]
	end
end

function TimelimitrankModel:getProgressPrizeById(progressPrizeId)
	if self._progressPrize[progressPrizeId] then
		local result = {}

		for index, value in ipairs(self._progressPrize[progressPrizeId]) do
			table.insert(result, value)
		end

		return result
	else
		local progressPrize = TimelimitrankConfig.instance:getProgressPrizeById(progressPrizeId)

		if progressPrize == nil then
			FloatWordMgr.instance:show(string.format("未配置id:%d的进度奖励方案", progressPrizeId))

			return
		end

		self._progressPrize[progressPrizeId] = {}

		for key, value in pairs(progressPrize) do
			table.insert(self._progressPrize[progressPrizeId], value)
		end

		table.sort(self._progressPrize[progressPrizeId], function(a, b)
			return a.progress < b.progress
		end)

		local result = {}

		for index, value in ipairs(self._progressPrize[progressPrizeId]) do
			table.insert(result, value)
		end

		return result
	end
end

function TimelimitrankModel:setSelectedRankType(id)
	self._id = id
end

function TimelimitrankModel:getSelectedRankType()
	return self._id
end

TimelimitrankModel.instance = TimelimitrankModel.New()

return TimelimitrankModel
