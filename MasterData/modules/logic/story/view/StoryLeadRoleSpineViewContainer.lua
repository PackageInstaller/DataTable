-- chunkname: @modules/logic/story/view/StoryLeadRoleSpineViewContainer.lua

module("modules.logic.story.view.StoryLeadRoleSpineViewContainer", package.seeall)

local StoryLeadRoleSpineViewContainer = class("StoryLeadRoleSpineViewContainer", BaseViewContainer)

function StoryLeadRoleSpineViewContainer:buildViews()
	local views = {}

	table.insert(views, StoryLeadRoleSpineView.New())

	return views
end

return StoryLeadRoleSpineViewContainer
