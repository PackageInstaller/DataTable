-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameInviteViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameInviteViewContainer", package.seeall)

local Activity186GameInviteViewContainer = class("Activity186GameInviteViewContainer", BaseViewContainer)

function Activity186GameInviteViewContainer:buildViews()
	local views = {}

	self.heroView = Activity186GameHeroView.New()

	table.insert(views, self.heroView)
	table.insert(views, Activity186GameInviteView.New())
	table.insert(views, Activity186GameDialogueView.New())

	return views
end

return Activity186GameInviteViewContainer
