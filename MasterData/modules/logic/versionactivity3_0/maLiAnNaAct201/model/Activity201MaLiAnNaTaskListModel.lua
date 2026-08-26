-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/Activity201MaLiAnNaTaskListModel.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaTaskListModel", package.seeall)

local Activity201MaLiAnNaTaskListModel = class("Activity201MaLiAnNaTaskListModel", ListScrollModel)

function Activity201MaLiAnNaTaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity203)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = Activity201MaLiAnNaConfig.instance:getTaskByActId(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = Activity201MaLiAnNaTaskMo.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity201MaLiAnNaTaskMo.New()

		allMO.id = -99999
		allMO.activityId = actId

		table.insert(dataList, allMO)
	end

	table.sort(dataList, Activity201MaLiAnNaTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function Activity201MaLiAnNaTaskListModel.sortMO(objA, objB)
	local sidxA = Activity201MaLiAnNaTaskListModel.getSortIndex(objA)
	local sidxB = Activity201MaLiAnNaTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity201MaLiAnNaTaskListModel.getSortIndex(objA)
	if objA.id == -99999 then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function Activity201MaLiAnNaTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function Activity201MaLiAnNaTaskListModel:getRankDiff(mo)
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

function Activity201MaLiAnNaTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function Activity201MaLiAnNaTaskListModel:preFinish(taskMO)
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

		table.sort(taskMOList, Activity201MaLiAnNaTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function Activity201MaLiAnNaTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= -99999 then
			count = count + 1
		end
	end

	return count
end

Activity201MaLiAnNaTaskListModel.instance = Activity201MaLiAnNaTaskListModel.New()

return Activity201MaLiAnNaTaskListModel
