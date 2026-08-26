-- chunkname: @modules/logic/ressplit/work/ResSplitRoleStoryWork.lua

module("modules.logic.ressplit.work.ResSplitRoleStoryWork", package.seeall)

local ResSplitRoleStoryWork = class("ResSplitRoleStoryWork", BaseWork)

function ResSplitRoleStoryWork:onStart(context)
	local dic = ResSplitConfig.instance:getAppIncludeConfig()

	for i, v in pairs(dic) do
		if v.heroStoryIds then
			for n, storyId in pairs(v.heroStoryIds) do
				local config = RoleStoryConfig.instance:getStoryById(storyId)

				ResSplitModel.instance:addIncludeChapter(config.chapterId)
			end
		end
	end

	self:onDone(true)
end

return ResSplitRoleStoryWork
