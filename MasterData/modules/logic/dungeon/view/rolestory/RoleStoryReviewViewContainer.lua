-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryReviewViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryReviewViewContainer", package.seeall)

local RoleStoryReviewViewContainer = class("RoleStoryReviewViewContainer", BaseViewContainer)

function RoleStoryReviewViewContainer:buildViews()
	local views = {}

	table.insert(views, RoleStoryReviewView.New())

	return views
end

return RoleStoryReviewViewContainer
