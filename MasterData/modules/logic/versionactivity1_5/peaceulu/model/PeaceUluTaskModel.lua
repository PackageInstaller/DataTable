-- chunkname: @modules/logic/versionactivity1_5/peaceulu/model/PeaceUluTaskModel.lua

module("modules.logic.versionactivity1_5.peaceulu.model.PeaceUluTaskModel", package.seeall)

local PeaceUluTaskModel = class("PeaceUluTaskModel", ListScrollModel)

function PeaceUluTaskModel:onInit()
	return
end

function PeaceUluTaskModel:reInit()
	return
end

function PeaceUluTaskModel:sortTaskMoList(firstOpen)
	local taskMoList = PeaceUluModel.instance:getTasksInfo()
	local finishNotGetRewardMoList = {}
	local notFinishMoList = {}
	local finishAndGetRewardMoList = {}

	for _, taskMo in pairs(taskMoList) do
		taskMo.firstOpen = firstOpen
		taskMo.isupdate = true

		if taskMo.finishCount > 0 then
			table.insert(finishAndGetRewardMoList, taskMo)
		elseif taskMo.hasFinished then
			table.insert(finishNotGetRewardMoList, taskMo)
		else
			table.insert(notFinishMoList, taskMo)
		end
	end

	table.sort(finishNotGetRewardMoList, PeaceUluTaskModel._sortFunc)
	table.sort(notFinishMoList, PeaceUluTaskModel._sortFunc)
	table.sort(finishAndGetRewardMoList, PeaceUluTaskModel._sortFunc)

	self.serverTaskModel = {}

	tabletool.addValues(self.serverTaskModel, finishNotGetRewardMoList)
	tabletool.addValues(self.serverTaskModel, notFinishMoList)
	tabletool.addValues(self.serverTaskModel, finishAndGetRewardMoList)
	self:refreshList(firstOpen)
end

function PeaceUluTaskModel._sortFunc(a, b)
	local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
	local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

	if aValue ~= bValue then
		return aValue < bValue
	elseif a.config.sort ~= b.config.sort then
		return a.config.sort < b.config.sort
	else
		return a.config.id < b.config.id
	end
end

function PeaceUluTaskModel:refreshList(firstOpen)
	local moList = tabletool.copy(self.serverTaskModel)

	table.insert(moList, 1, {
		isGame = true,
		isupdate = true,
		firstOpen = firstOpen
	})
	self:setList(moList)
end

function PeaceUluTaskModel:getFinishTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.serverTaskModel) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function PeaceUluTaskModel:getFinishTaskActivityCount()
	local count = 0

	for _, taskMo in ipairs(self.serverTaskModel) do
		if taskMo.hasFinished and taskMo.finishCount < taskMo.config.maxProgress then
			count = count + taskMo.config.activity
		end
	end

	return count
end

function PeaceUluTaskModel:getGetRewardTaskCount()
	local count = 0

	for _, taskMo in ipairs(self.serverTaskModel) do
		if taskMo.finishCount >= taskMo.config.maxProgress then
			count = count + 1
		end
	end

	return count
end

function PeaceUluTaskModel:checkAllTaskFinished()
	for index, value in ipairs(self.serverTaskModel) do
		if value.finishCount == 0 then
			return false
		end
	end

	return true
end

function PeaceUluTaskModel:getKeyRewardMo()
	if self.serverTaskModel then
		for i, v in ipairs(self.serverTaskModel) do
			if v.config.isKeyReward == 1 and v.finishCount < v.config.maxProgress then
				return v
			end
		end
	end
end

PeaceUluTaskModel.instance = PeaceUluTaskModel.New()

return PeaceUluTaskModel
