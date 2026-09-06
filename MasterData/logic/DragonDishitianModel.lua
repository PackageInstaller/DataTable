-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/model/DragonDishitianModel.lua

module("logic.extensions.dragondishitian.model.DragonDishitianModel", package.seeall)

local DragonDishitianModel = class("DragonDishitianModel", BaseModel)

function DragonDishitianModel:onInit()
	self:onReset()
end

function DragonDishitianModel:onReset()
	self._agentDic = {}
end

function DragonDishitianModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function DragonDishitianModel:_initAgent(info)
	info.activityId = 0
	info.chapterInfos = {}
	info.buffTypes = {}
	info.customFmtMo = nil
end

function DragonDishitianModel:getCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info.customFmtMo == nil then
		info.customFmtMo = DragonDishitianFmtMo.New()
	end

	return info.customFmtMo
end

function DragonDishitianModel:onDragonDishitianGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info.chapterInfos = GameUtil.pbToTable(msg.chapterInfos) or {}
	info.buffTypes = GameUtil.pbToTable(msg.buffTypes) or {}
end

function DragonDishitianModel:onDragonDishitianChallengeRes(msg)
	return
end

function DragonDishitianModel:onNotify_DragonDishitianChallengeRes(msg)
	local info = self:getAgentInfo(msg.activityId)
	local isExistChapter = false

	for i, v in ipairs(info.chapterInfos) do
		if v.chapterId == msg.chapterId then
			isExistChapter = true
			v.stageInfos = v.stageInfos or {}

			local isExistStage = false

			for i1, v1 in ipairs(v.stageInfos) do
				if v1.stageId == msg.stageInfo.stageId then
					isExistStage = true
					v1.hasPassedConditionArrIndexes = GameUtil.pbToTable(msg.stageInfo.hasPassedConditionArrIndexes) or {}

					break
				end
			end

			if not isExistStage then
				table.insert(v.stageInfos, GameUtil.pbToTable(msg.stageInfo) or {})
			end
		end
	end

	if not isExistChapter then
		local element = {}

		element.chapterId = msg.chapterId
		element.stageInfos = {}

		table.insert(element.stageInfos, GameUtil.pbToTable(msg.stageInfo) or {})
		table.insert(info.chapterInfos, element)
	end
end

function DragonDishitianModel:onDragonDishitianChargeRes(msg)
	local info = self:getAgentInfo(msg.activityId)
	local buffTypeInfo

	for i, v in ipairs(info.buffTypes) do
		if v.typeId == msg.typeId then
			buffTypeInfo = v

			break
		end
	end

	if buffTypeInfo then
		buffTypeInfo.progress = msg.progress
	else
		local buffInfo = {}

		buffInfo.typeId = msg.typeId
		buffInfo.progress = msg.progress

		table.insert(info.buffTypes, buffInfo)
	end
end

function DragonDishitianModel:getActivityId()
	if self._activityId then
		return self._activityId
	end

	self._activityId = checknumber(DragonDishitianConfig.instance:getCommonValue("ACTIVITY_ID"))

	return self._activityId
end

function DragonDishitianModel:getActivityType()
	return GameEnum.ActivityType.DragonDishitian
end

function DragonDishitianModel:getChapterInfo(activityId, chapterId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.chapterInfos) do
		if v.chapterId == chapterId then
			return v
		end
	end
end

function DragonDishitianModel:getBuffInfo(activityId, typeId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info.buffTypes) do
		if v.typeId == typeId then
			return v
		end
	end
end

function DragonDishitianModel:getStageInfo(activityId, chapterId, stageId)
	local chapterInfo = self:getChapterInfo(activityId, chapterId)

	if chapterInfo then
		for i, v in ipairs(chapterInfo.stageInfos) do
			if v.stageId == stageId then
				return v
			end
		end
	end
end

function DragonDishitianModel:isPassChapter(activityId, chapterId)
	local cfgs = DragonDishitianConfig.instance:getStageCfgList(activityId, chapterId)

	for i, cfg in ipairs(cfgs) do
		if not self:isPassStage(activityId, chapterId, cfg.stageId) then
			return false
		end
	end

	return true
end

function DragonDishitianModel:isUnlockChapter(activityId, chapterId)
	local isMatchOpenTime = self:isMatchOpenTime(activityId, chapterId)

	if not isMatchOpenTime then
		return false
	end

	return (self:isPassPreChapter(activityId, chapterId))
end

function DragonDishitianModel:isMatchOpenTime(activityId, chapterId)
	local cfg = DragonDishitianConfig.instance:getChapterCfg(activityId, chapterId)

	if cfg.openTime then
		local openTimestamp = GameUtil.string2time(cfg.openTime)

		if openTimestamp > ServerTime.now() then
			return false
		else
			return true
		end
	end

	return true
end

function DragonDishitianModel:isPassPreChapter(activityId, chapterId)
	local preChapterId = chapterId - 1

	return preChapterId > 0 and self:isPassChapter(activityId, preChapterId) or true
end

function DragonDishitianModel:isPassStage(activityId, chapterId, stageId)
	local cfg = DragonDishitianConfig.instance:getStageCfg(activityId, chapterId, stageId)

	if cfg then
		if not cfg.conditionIds then
			local conditionIds = {}
			local conditionNum = #conditionIds
			local stageInfo = self:getStageInfo(activityId, chapterId, stageId)

			if stageInfo and stageInfo.hasPassedConditionArrIndexes then
				local passNum = #stageInfo.hasPassedConditionArrIndexes

				if passNum > 0 and conditionNum == passNum then
					return true
				end
			end
		end
	end
end

function DragonDishitianModel:isPassCondition(activityId, chapterId, stageId, conditionId)
	local stageInfo = self:getStageInfo(activityId, chapterId, stageId)

	if stageInfo and stageInfo.hasPassedConditionArrIndexes then
		local cfg = DragonDishitianConfig.instance:getStageCfg(activityId, chapterId, stageId)

		if not cfg.conditionIds then
			for i, index in ipairs(stageInfo.hasPassedConditionArrIndexes) do
				if cfg.conditionIds[index + 1] == conditionId then
					return true
				end
			end
		end
	end
end

DragonDishitianModel.instance = DragonDishitianModel.New()

return DragonDishitianModel
