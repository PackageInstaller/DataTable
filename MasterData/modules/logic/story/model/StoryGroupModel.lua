-- chunkname: @modules/logic/story/model/StoryGroupModel.lua

module("modules.logic.story.model.StoryGroupModel", package.seeall)

local StoryGroupModel = class("StoryGroupModel", BaseModel)

function StoryGroupModel:onInit()
	self._groupList = {}
end

function StoryGroupModel:setGroupList(infos)
	self._groupList = {}

	if infos then
		for _, info in pairs(infos) do
			local mo = {}

			for _, value in ipairs(info) do
				local groupMo = StoryGroupMo.New()

				groupMo:init(value)
				table.insert(mo, groupMo)
			end

			table.insert(self._groupList, mo)
		end
	end
end

function StoryGroupModel:getGroupList()
	return self._groupList
end

function StoryGroupModel:getGroupListById(stepId)
	for _, branch in pairs(self._groupList) do
		for _, v in pairs(branch) do
			if v.id == stepId then
				return branch
			end
		end
	end

	return nil
end

StoryGroupModel.instance = StoryGroupModel.New()

return StoryGroupModel
