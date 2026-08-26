-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/model/FeiLinShiDuoTaskListModel.lua

module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoTaskListModel", package.seeall)

local FeiLinShiDuoTaskListModel = class("FeiLinShiDuoTaskListModel", ListScrollModel)

function FeiLinShiDuoTaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity185)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = FeiLinShiDuoConfig.instance:getTaskByActId(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = FeiLinShiDuoTaskMo.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = FeiLinShiDuoTaskMo.New()

		allMO.id = -99999
		allMO.activityId = actId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, FeiLinShiDuoTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function FeiLinShiDuoTaskListModel.sortMO(objA, objB)
	local sidxA = FeiLinShiDuoTaskListModel.getSortIndex(objA)
	local sidxB = FeiLinShiDuoTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function FeiLinShiDuoTaskListModel.getSortIndex(objA)
	if objA.id == -99999 then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function FeiLinShiDuoTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function FeiLinShiDuoTaskListModel:getRankDiff(mo)
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

function FeiLinShiDuoTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function FeiLinShiDuoTaskListModel:preFinish(taskMO)
	if not taskMO then
		return
	end

	local isCanSort = false

	self._hasRankDiff = false

	self:refreshRankDiff()

	local preCount = 0
	local taskMOList = self:getList()

	if taskMO.id == -99999 then
		for _, tempMO in ipairs(taskMOList) do
			if tempMO:alreadyGotReward() and tempMO.id ~= -99999 then
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
		local allMO = self:getById(-99999)

		if allMO and self:getGotRewardCount() < preCount + 1 then
			tabletool.removeValue(taskMOList, allMO)
		end

		self._hasRankDiff = true

		table.sort(taskMOList, FeiLinShiDuoTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function FeiLinShiDuoTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= -99999 then
			count = count + 1
		end
	end

	return count
end

FeiLinShiDuoTaskListModel.instance = FeiLinShiDuoTaskListModel.New()

return FeiLinShiDuoTaskListModel
