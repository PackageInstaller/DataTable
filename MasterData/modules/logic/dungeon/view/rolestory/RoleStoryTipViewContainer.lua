-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryTipViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryTipViewContainer", package.seeall)

local RoleStoryTipViewContainer = class("RoleStoryTipViewContainer", BaseViewContainer)

function RoleStoryTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoleStoryTipView.New())

	return views
end

return RoleStoryTipViewContainer
