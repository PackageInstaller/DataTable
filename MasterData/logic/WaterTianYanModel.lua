-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/model/WaterTianYanModel.lua

module("logic.extensions.watertianyan.model.WaterTianYanModel", package.seeall)

local WaterTianYanModel = class("WaterTianYanModel", BaseModel)

WaterTianYanModel.LockLevel = 0
WaterTianYanModel.BuffViewBuild = 1
WaterTianYanModel.BuffViewMain = 2
WaterTianYanModel.TipUnlock = 1
WaterTianYanModel.TipLevelup = 2

function WaterTianYanModel:onInit()
	self:onReset()
end

function WaterTianYanModel:onReset()
	self._agentDic = {}
end

function WaterTianYanModel:getAgentInfo(activityId)
	if not self._agentDic[activityId] then
		self._agentDic[activityId] = {}

		self:_initAgent(self._agentDic[activityId])
	end

	return self._agentDic[activityId]
end

function WaterTianYanModel:_initAgent(info)
	info._activityId = 0
	info._buildingStageIds = {}
	info._buildingStageTodayChallengeTimes = 0
	info._buffItems = {}
	info._mainStagePassId = 0
	info._prizeStageId = 0
	info._buildCustomFmtMo = nil
	info._mainCustomFmtMo = nil
end

function WaterTianYanModel:getBuildCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info._buildCustomFmtMo == nil then
		info._buildCustomFmtMo = WaterTianYanBuildCustomFmtMo.New()
	end

	return info._buildCustomFmtMo
end

function WaterTianYanModel:getMainCustomFmtMo(activityId)
	local info = self:getAgentInfo(activityId)

	if info._mainCustomFmtMo == nil then
		info._mainCustomFmtMo = WaterTianYanMainCustomFmtMo.New()
	end

	return info._mainCustomFmtMo
end

function WaterTianYanModel:getActivityId()
	return 305001
end

function WaterTianYanModel:getQiJiDiShiTianActivityId()
	return 305002
end

function WaterTianYanModel:getDivineMiuKeActivityId()
	return 305003
end

function WaterTianYanModel:getActivityType()
	return GameEnum.ActivityType.WaterTianYan
end

function WaterTianYanModel:onGetInfoRes(msg)
	local info = self:getAgentInfo(msg.activityId)

	info._buildingStageIds = GameUtil.pbToTable(msg.buildingStageIds) or {}
	info._buildingStageTodayChallengeTimes = msg.buildingStageTodayChallengeTimes
	info._buffItems = GameUtil.pbToTable(msg.buffItems) or {}
	info._mainStagePassId = msg.mainStagePassId
	info._prizeStageId = msg.prizeStageId
end

function WaterTianYanModel:onUpgradeBuffRes(msg, activityId, buffItemId)
	if not activityId or not buffItemId then
		return
	end

	local info = self:getAgentInfo(activityId)
	local cfgs = WaterTianYanConfig.instance:getBuffItemLevelCfgList(activityId, buffItemId)

	if cfgs then
		if not #cfgs then
			local maxLevel = 1
			local isUnlock = false

			for i, v in ipairs(info._buffItems) do
				if v.buffItemId == buffItemId then
					isUnlock = true
					v.level = v.level + 1
					v.level = maxLevel < v.level and maxLevel or v.level
				end
			end

			if not isUnlock then
				local element = {}

				element.buffItemId = buffItemId
				element.level = 1
				element.usedStageId = 0

				table.insert(info._buffItems, element)
			end
		end
	end
end

function WaterTianYanModel:onRefreshBuildingStageListRes(msg, activityId)
	local info = self:getAgentInfo(activityId)

	info._buildingStageIds = GameUtil.pbToTable(msg.buildingStageIds) or {}
end

function WaterTianYanModel:onBuildingStageChallengeRes(msg)
	return
end

function WaterTianYanModel:onMainStageChallengeRes(msg)
	return
end

function WaterTianYanModel:onResetMainStageRes(msg, activityId)
	local info = self:getAgentInfo(activityId)

	info._mainStagePassId = 0

	for i, v in ipairs(info._buffItems) do
		v.usedStageId = 0
	end
end

function WaterTianYanModel:onNotifyBuildingStageChallengeRes(msg, activityId, index)
	local isWin = BattleModel.instance:isSelfRealWin()

	if not isWin then
		return
	end

	if not activityId or not index then
		return
	end

	local info = self:getAgentInfo(activityId)

	index = index + 1

	if info._buildingStageIds[index] and msg:HasField("replaceStageId") then
		info._buildingStageIds[index] = msg.replaceStageId
	end

	info._buildingStageTodayChallengeTimes = info._buildingStageTodayChallengeTimes + 1
end

function WaterTianYanModel:onNotifyMainStageChallengeRes(msg, activityId, stageId, buffItemIds)
	local isWin = BattleModel.instance:isSelfRealWin()

	if not isWin then
		return
	end

	if not activityId or not stageId or not buffItemIds then
		return
	end

	local info = self:getAgentInfo(activityId)

	for i1, v1 in ipairs(buffItemIds) do
		for i2, v2 in ipairs(info._buffItems) do
			if v1 == v2.buffItemId then
				v2.usedStageId = stageId

				break
			end
		end
	end

	info._mainStagePassId = stageId

	if stageId > info._prizeStageId then
		info._prizeStageId = stageId
	end
end

function WaterTianYanModel:getMainStagePassId(activityId)
	local info = self:getAgentInfo(activityId)

	return info._mainStagePassId
end

function WaterTianYanModel:getBuildingStageChallengeTimes(activityId)
	local info = self:getAgentInfo(activityId)

	return info._buildingStageTodayChallengeTimes
end

function WaterTianYanModel:getBuildingStageIds(activityId)
	local info = self:getAgentInfo(activityId)

	return info._buildingStageIds
end

function WaterTianYanModel:isPassMainStage(activityId, stageId)
	local info = self:getAgentInfo(activityId)

	return stageId <= info._mainStagePassId
end

function WaterTianYanModel:getBuffLevel(activityId, buffItemId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info._buffItems) do
		if v.buffItemId == buffItemId then
			return v.level
		end
	end

	return WaterTianYanModel.LockLevel
end

function WaterTianYanModel:isBuffUnlock(activityId, buffItemId)
	local info = self:getAgentInfo(activityId)
	local level = self:getBuffLevel(activityId, buffItemId)

	return level > 0
end

function WaterTianYanModel:getUsedBuffItemIdList(activityId, usedStageId)
	local info = self:getAgentInfo(activityId)
	local list = {}

	for i, v in ipairs(info._buffItems) do
		if v.usedStageId == usedStageId then
			table.insert(list, v.buffItemId)
		end
	end

	printInfo("test WaterTianYanModel:getUsedBuffItemIdList buff数量", #list)

	return list
end

function WaterTianYanModel:isUsedBuff(activityId, buffItemId)
	local info = self:getAgentInfo(activityId)

	for i, v in ipairs(info._buffItems) do
		if v.buffItemId == buffItemId and v.usedStageId > 0 then
			return true
		end
	end

	return false
end

WaterTianYanModel.instance = WaterTianYanModel.New()

return WaterTianYanModel
