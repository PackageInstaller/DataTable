-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaTaskListModel.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaTaskListModel", package.seeall)

local AiZiLaTaskListModel = class("AiZiLaTaskListModel", ListScrollModel)

function AiZiLaTaskListModel:init()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleAiZiLa) or {}
	local dataList = {}
	local actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	local taskCfgList = AiZiLaConfig.instance:getTaskList(actId)
	local rewardCount = 0

	for _, taskCfg in ipairs(taskCfgList) do
		local mo = AiZiLaTaskMO.New()

		mo:init(taskCfg, taskDict[taskCfg.id])
		table.insert(dataList, mo)

		if mo:alreadyGotReward() then
			rewardCount = rewardCount + 1
		end
	end

	if rewardCount > 1 then
		local allMO = AiZiLaTaskMO.New()

		allMO.id = AiZiLaEnum.TaskMOAllFinishId
		allMO.activityId = actId

		table.insert(dataList, 1, allMO)
	end

	table.sort(dataList, AiZiLaTaskListModel.sortMO)

	self._hasRankDiff = false

	self:_refreshShowTab(dataList)
	self:setList(dataList)
end

function AiZiLaTaskListModel.sortMO(objA, objB)
	local sidxA = AiZiLaTaskListModel.getSortIndex(objA)
	local sidxB = AiZiLaTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function AiZiLaTaskListModel.getSortIndex(objA)
	if objA.id == AiZiLaEnum.TaskMOAllFinishId then
		return 1
	end

	local offset = objA:isMainTask() and 0 or 200

	if objA:isFinished() then
		return 99 + offset
	elseif objA:alreadyGotReward() then
		return 2 + offset
	end

	return 50 + offset
end

function AiZiLaTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function AiZiLaTaskListModel:getRankDiff(mo)
	if self._hasRankDiff and mo then
		local oldIdx = tabletool.indexOf(self._idIdxList, mo.id)
		local curIdx = self:getIndex(mo)

		if oldIdx and curIdx then
			self._idIdxList[oldIdx] = -2

			return curIdx - oldIdx
		end
	end

	return 0
end

function AiZiLaTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function AiZiLaTaskListModel:refreshShowTab()
	self:_refreshShowTab(self:getList())
end

function AiZiLaTaskListModel:_refreshShowTab(taskMOList)
	local showType

	for _, tempMO in ipairs(taskMOList) do
		local tempType = tempMO:isMainTask()

		if tempMO.id ~= AiZiLaEnum.TaskMOAllFinishId and showType ~= tempType then
			showType = tempType

			tempMO:setShowTab(true)
		else
			tempMO:setShowTab(false)
		end
	end
end

function AiZiLaTaskListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	self:_refreshShowTab(list)

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, mo:getLineHeight(), i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function AiZiLaTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == AiZiLaEnum.TaskMOAllFinishId then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= AiZiLaEnum.TaskMOAllFinishId then
				tempMO.preFinish = true
				isCanSort = true
				preCount = preCount + 1
			end
		end
	elseif taskMO:alreadyGotReward() then
		taskMO.preFinish = true
		isCanSort = true
		preCount = preCount + 1
	end

	if isCanSort then
		local allMO = self:getById(AiZiLaEnum.TaskMOAllFinishId)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, AiZiLaTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function AiZiLaTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= AiZiLaEnum.TaskMOAllFinishId then
			count = count + 1
		end
	end

	return count
end

AiZiLaTaskListModel.instance = AiZiLaTaskListModel.New()

return AiZiLaTaskListModel
