-- chunkname: @modules/logic/versionactivity1_9/heroinvitation/view/HeroInvitationViewContainer.lua

module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationViewContainer", package.seeall)

local HeroInvitationViewContainer = class("HeroInvitationViewContainer", BaseViewContainer)

function HeroInvitationViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Right/#scroll_RoleList"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = HeroInvitationItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 204
	scrollParam1.cellHeight = 528
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollViewWithAnimator.New(HeroInvitationListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, HeroInvitationView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function HeroInvitationViewContainer:buildTabViews(tabContainerId)
	local view = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		view
	}
end

function HeroInvitationViewContainer:getScrollView()
	return self.scrollView
end

return HeroInvitationViewContainer
