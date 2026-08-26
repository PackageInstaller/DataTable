-- chunkname: @modules/logic/dungeon/model/RoleStoryListModel.lua

module("modules.logic.dungeon.model.RoleStoryListModel", package.seeall)

local RoleStoryListModel = class("RoleStoryListModel", ListScrollModel)

function RoleStoryListModel:markUnlockOrder()
	self.unlockOrderDict = {}

	local list = RoleStoryConfig.instance:getStoryList()

	if list then
		for i, v in ipairs(list) do
			local mo = RoleStoryModel.instance:getMoById(v.id)

			if mo:isResidentTime() then
				self.unlockOrderDict[v.id] = mo.hasUnlock and 1 or 0
			end
		end
	end
end

function RoleStoryListModel:refreshList()
	if #self._scrollViews == 0 then
		return
	end

	local list = RoleStoryConfig.instance:getStoryList()
	local dataList = {}

	if list then
		for i, v in ipairs(list) do
			local mo = RoleStoryModel.instance:getMoById(v.id)

			if mo:getType() == self.selectTabType and mo:isResidentTime() then
				mo.unlockOrder = self.unlockOrderDict[v.id] or 0

				table.insert(dataList, mo)
			end
		end
	end

	table.sort(dataList, SortUtil.tableKeyUpper({
		"getUnlockOrder",
		"unlockOrder",
		"hasRewardUnget",
		"getRewardOrder",
		"order"
	}))
	self:setList(dataList)
end

function RoleStoryListModel:setSelectTabType(tabType, noUpdate)
	if self.selectTabType == tabType then
		return
	end

	self.selectTabType = tabType

	if not noUpdate then
		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryTabChange)
	end

	return true
end

function RoleStoryListModel:getSelectTabType()
	return self.selectTabType
end

RoleStoryListModel.instance = RoleStoryListModel.New()

return RoleStoryListModel
