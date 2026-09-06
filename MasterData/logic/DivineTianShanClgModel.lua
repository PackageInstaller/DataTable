-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/model/DivineTianShanClgModel.lua

module("logic.extensions.divinetianshanclg.model.DivineTianShanClgModel", package.seeall)

local DivineTianShanClgModel = class("DivineTianShanClgModel", BaseModel)

function DivineTianShanClgModel:ctor()
	return
end

function DivineTianShanClgModel:onInit()
	self:onReset()
end

function DivineTianShanClgModel:onReset()
	self._baseInfoMap = {}
	self._extremeStageInfoMap = {}
	self._normalStageInfoMap = {}
end

function DivineTianShanClgModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info

	local extremeClgInfo = info.extremeClgInfo

	if extremeClgInfo then
		if not extremeClgInfo.stageList then
			do
				local extremeStageList = {}
				local extremeStageMap = {}

				for _, stageInfo in ipairs(extremeStageList) do
					extremeStageMap[stageInfo.stageId] = stageInfo
				end

				self._extremeStageInfoMap[info.activityId] = extremeStageMap
			end

			local normalClgInfo = info.normalClgInfo

			if normalClgInfo then
				if not normalClgInfo.stageList then
					local normalStageList = {}
					local normalStageMap = {}

					for _, stageInfo in ipairs(normalStageList) do
						normalStageMap[stageInfo.stageId] = stageInfo
					end

					self._normalStageInfoMap[info.activityId] = normalStageMap
				end
			end
		end
	end
end

function DivineTianShanClgModel:onResetExtremeFight(msg)
	local info = GameUtil.pbToTable(msg)
	local extremeStageMap = self:getExtremeStageMap(info.activityId)

	extremeStageMap[info.stageInfo.stageId] = info.stageInfo
	self._extremeStageInfoMap[info.activityId] = extremeStageMap
end

function DivineTianShanClgModel:onGainNormalPrize(msg)
	local baseInfo = self:getBaseInfo(msg.activityId)

	if baseInfo and baseInfo.normalClgInfo then
		if not baseInfo.normalClgInfo.gainPrizeIds then
			table.insert(baseInfo.normalClgInfo.gainPrizeIds, msg.prizeId)

			baseInfo.normalClgInfo.gainPrizeIds = baseInfo.normalClgInfo.gainPrizeIds
		end
	end
end

function DivineTianShanClgModel:onNotifyExtremeFight(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(info.activityId)

	if baseInfo then
		local extremeStageMap = self:getExtremeStageMap(info.activityId)

		extremeStageMap[info.stageInfo.stageId] = info.stageInfo
		self._extremeStageInfoMap[info.activityId] = extremeStageMap
		baseInfo.extremeClgInfo.gainPrize = info.gainPrize
	end
end

function DivineTianShanClgModel:onNotifyNormalFight(msg)
	local info = GameUtil.pbToTable(msg)
	local baseInfo = self:getBaseInfo(info.activityId)

	if baseInfo then
		local normalStageMap = self:getNormalStageMap(info.activityId)
		local stageInfo = normalStageMap[info.stageId]

		if stageInfo and not info.isPractice then
			stageInfo.leftHp = checknumber(info.leftHp)
			baseInfo.normalClgInfo.todayFightTimes = info.todayFightTimes
		end

		self._normalStageInfoMap[info.activityId] = normalStageMap
	end
end

function DivineTianShanClgModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		printError("神曜天闪数据未初始化")
	end

	return self._baseInfoMap[activityId]
end

function DivineTianShanClgModel:getExtremeStageMap(activityId)
	return self._extremeStageInfoMap[activityId] or {}
end

function DivineTianShanClgModel:getNormalStageMap(activityId)
	return self._normalStageInfoMap[activityId] or {}
end

DivineTianShanClgModel.instance = DivineTianShanClgModel.New()

return DivineTianShanClgModel
