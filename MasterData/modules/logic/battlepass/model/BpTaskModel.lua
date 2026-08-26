-- chunkname: @modules/logic/battlepass/model/BpTaskModel.lua

module("modules.logic.battlepass.model.BpTaskModel", package.seeall)

local BpTaskModel = class("BpTaskModel", ListScrollModel)

function BpTaskModel:onInit()
	self.serverTaskModel = BaseModel.New()
	self.showQuickFinishTask = false
	self.haveTurnBackTask = false
end

function BpTaskModel:reInit()
	self.haveTurnBackTask = false
	self.showQuickFinishTask = false

	self.serverTaskModel:clear()
end

function BpTaskModel:onGetInfo(taskInfoList)
	local list = {}

	for _, info in ipairs(taskInfoList) do
		local co = BpConfig.instance:getTaskCO(info.id)

		if co then
			local taskMO = TaskMo.New()

			taskMO:init(info, co)
			table.insert(list, taskMO)
		else
			logError("Bp task config not find:" .. tostring(info.id))
		end
	end

	self.serverTaskModel:setList(list)
	self:sortList()
	self:_checkRedDot()
end

function BpTaskModel:sortList()
	self.serverTaskModel:sort(function(a, b)
		local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
		local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		else
			if a.config.sortId ~= b.config.sortId then
				return a.config.sortId < b.config.sortId
			end

			return a.config.id < b.config.id
		end
	end)
	self:onModelUpdate()
end

function BpTaskModel:_checkRedDot()
	local isWeekScoreFull = BpModel.instance:isWeeklyScoreFull()
	local finishCount = 0

	for _, taskMO in ipairs(self.serverTaskModel:getList()) do
		if taskMO.config.bpId == BpModel.instance.id then
			if taskMO.progress >= taskMO.config.maxProgress and taskMO.finishCount == 0 then
				local loopType = taskMO.config.loopType

				if loopType == 5 then
					loopType = 3
				end

				if not isWeekScoreFull or isWeekScoreFull and loopType == 3 then
					finishCount = finishCount + 1
				end
			end

			if taskMO.config.turnbackTask then
				self.haveTurnBackTask = true
			end
		end
	end

	self.showQuickFinishTask = finishCount >= 1
end

function BpTaskModel:getHaveRedDot(loopType)
	if loopType == 3 then
		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, 3) or RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, 5)
	else
		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, loopType)
	end
end

function BpTaskModel:updateInfo(taskInfoList)
	local hasChange

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.BattlePass then
			local mo = self.serverTaskModel:getById(info.id)

			if mo then
				mo:update(info)
			else
				local co = BpConfig.instance:getTaskCO(info.id)

				if co then
					mo = TaskMo.New()

					mo:init(info, co)
					self.serverTaskModel:addAtLast(mo)
				else
					logError("Bp task config not find:" .. tostring(info.id))
				end
			end

			hasChange = true
		end
	end

	if hasChange then
		self:sortList()
		self:_checkRedDot()
	end

	return hasChange
end

function BpTaskModel:deleteInfo(ids)
	local removeDict = {}

	for _, id in pairs(ids) do
		local mo = self.serverTaskModel:getById(id)

		if mo then
			removeDict[id] = mo
		end
	end

	for id, mo in pairs(removeDict) do
		self.serverTaskModel:remove(mo)
	end

	local isChange = not not next(removeDict)

	if isChange then
		self:sortList()
		self:_checkRedDot()
	end

	return isChange
end

function BpTaskModel:refreshListView(loopType)
	local list = {}
	local allTasks = self.serverTaskModel:getList()

	for _, taskMO in ipairs(allTasks) do
		local configLoopType = taskMO.config.loopType

		if configLoopType == 5 then
			configLoopType = 3
		end

		if taskMO.config.bpId == BpModel.instance.id and configLoopType == loopType then
			local dict = BpConfig.instance.taskPreposeIds
			local isShow = true

			if dict[taskMO.config.id] then
				for preId in pairs(dict[taskMO.config.id]) do
					local preTaskMo = self.serverTaskModel:getById(preId)

					if preTaskMo and preTaskMo.finishCount == 0 then
						isShow = false

						break
					end
				end
			end

			if isShow then
				table.insert(list, taskMO)
			end
		end
	end

	self:setList(list)
end

function BpTaskModel:isLoopTypeTaskAllFinished(loopType)
	local allTasks = self.serverTaskModel:getList()

	for _, taskMO in ipairs(allTasks) do
		local configLoopType = taskMO.config.loopType

		if configLoopType == 5 then
			configLoopType = 3
		end

		if taskMO.config.bpId == BpModel.instance.id and configLoopType == loopType and taskMO.finishCount < 1 then
			return false
		end
	end

	return true
end

BpTaskModel.instance = BpTaskModel.New()

return BpTaskModel
