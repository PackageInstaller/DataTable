-- chunkname: @modules/logic/versionactivity1_4/act133/model/Activity133Model.lua

module("modules.logic.versionactivity1_4.act133.model.Activity133Model", package.seeall)

local Activity133Model = class("Activity133Model", BaseModel)

function Activity133Model:ctor()
	self.super:ctor()

	self.serverTaskModel = BaseModel.New()
end

function Activity133Model:setActivityInfo(info)
	self.actId = info.activityId
	self.hasGetBonusIds = info.hasGetBonusIds

	self:setTasksInfo(info.tasks)
end

function Activity133Model:getTasksInfo()
	return self.serverTaskModel:getList()
end

function Activity133Model:setTasksInfo(taskInfoList)
	local hasChange

	for i, info in ipairs(taskInfoList) do
		local mo = self.serverTaskModel:getById(info.id)

		if mo then
			mo:update(info)
		else
			local co = Activity133Config.instance:getTaskCo(info.id)

			if co then
				mo = TaskMo.New()

				mo:init(info, co)
				self.serverTaskModel:addAtLast(mo)
			end
		end

		hasChange = true
	end

	if hasChange then
		self:sortList()
	end

	return hasChange
end

function Activity133Model:deleteInfo(ids)
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
	end

	return isChange
end

function Activity133Model:sortList()
	self.serverTaskModel:sort(function(a, b)
		local aValue = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
		local bValue = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		else
			return a.config.id < b.config.id
		end
	end)
end

function Activity133Model:checkBonusReceived(bonusId)
	for _, id in pairs(self.hasGetBonusIds) do
		if id == bonusId then
			return true
		end
	end

	return false
end

function Activity133Model:getFixedNum()
	if self.hasGetBonusIds then
		return #self.hasGetBonusIds
	end

	return 0
end

function Activity133Model:setSelectID(id)
	self._selectid = self._selectid or id
	self._selectid = id
end

function Activity133Model:getSelectID()
	return self._selectid
end

Activity133Model.instance = Activity133Model.New()

return Activity133Model
