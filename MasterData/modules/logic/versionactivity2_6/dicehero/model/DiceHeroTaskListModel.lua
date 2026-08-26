-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/DiceHeroTaskListModel.lua

module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroTaskListModel", package.seeall)

local DiceHeroTaskListModel = class("DiceHeroTaskListModel", ListScrollModel)

function DiceHeroTaskListModel:init()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.DiceHero)
	local dataList = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = DiceHeroConfig.instance:getTaskList()

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = DiceHeroTaskMo.New()

			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				rewardCount = rewardCount + 1
			end

			table.insert(dataList, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = DiceHeroTaskMo.New()

		allMO.id = -99999

		table.insert(dataList, allMO)
	end

	table.sort(dataList, DiceHeroTaskListModel.sortMO)

	self._hasRankDiff = false

	self:setList(dataList)
end

function DiceHeroTaskListModel.sortMO(objA, objB)
	local sidxA = DiceHeroTaskListModel.getSortIndex(objA)
	local sidxB = DiceHeroTaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function DiceHeroTaskListModel.getSortIndex(objA)
	if objA.id == -99999 then
		return 1
	elseif objA:isFinished() then
		return 100
	elseif objA:alreadyGotReward() then
		return 2
	end

	return 50
end

function DiceHeroTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

function DiceHeroTaskListModel:getRankDiff(mo)
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

function DiceHeroTaskListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function DiceHeroTaskListModel:preFinish(taskMO)
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

		table.sort(taskMOList, DiceHeroTaskListModel.sortMO)
		self:setList(taskMOList)

		self._hasRankDiff = false
	end
end

function DiceHeroTaskListModel:getGotRewardCount(moList)
	local taskMOList = moList or self:getList()
	local count = 0

	for _, tempMO in ipairs(taskMOList) do
		if tempMO:alreadyGotReward() and not tempMO.preFinish and tempMO.id ~= -99999 then
			count = count + 1
		end
	end

	return count
end

DiceHeroTaskListModel.instance = DiceHeroTaskListModel.New()

return DiceHeroTaskListModel
