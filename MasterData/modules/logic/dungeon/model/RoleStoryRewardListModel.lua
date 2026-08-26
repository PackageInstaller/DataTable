-- chunkname: @modules/logic/dungeon/model/RoleStoryRewardListModel.lua

module("modules.logic.dungeon.model.RoleStoryRewardListModel", package.seeall)

local RoleStoryRewardListModel = class("RoleStoryRewardListModel", ListScrollModel)

function RoleStoryRewardListModel:refreshList()
	local storyId = RoleStoryModel.instance:getCurActStoryId()
	local dataList = {}

	if storyId then
		local list = RoleStoryConfig.instance:getRewardList(storyId) or {}

		for i, v in ipairs(list) do
			table.insert(dataList, {
				index = i,
				config = v
			})
		end
	end

	self:setList(dataList)
end

RoleStoryRewardListModel.instance = RoleStoryRewardListModel.New()

return RoleStoryRewardListModel
