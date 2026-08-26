-- chunkname: @modules/logic/sp01/library/AssassinLibraryViewContainer.lua

module("modules.logic.sp01.library.AssassinLibraryViewContainer", package.seeall)

local AssassinLibraryViewContainer = class("AssassinLibraryViewContainer", BaseViewContainer)
local TabId_Navigate = 1
local TabId_Container = AssassinEnum.LibraryInfoViewTabId

function AssassinLibraryViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinLibraryView.New())
	table.insert(views, TabViewGroup.New(TabId_Navigate, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(TabId_Container, "root/#go_container"))

	return views
end

function AssassinLibraryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == TabId_Navigate then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == TabId_Container then
		return {
			AssassinLibraryHeroView.New(),
			AssassinLibraryListView.New(),
			AssassinLibraryVideoListView.New()
		}
	end
end

function AssassinLibraryViewContainer:switchLibType(libType)
	local tabId = AssassinEnum.LibraryType2TabViewId[libType]

	self:dispatchEvent(ViewEvent.ToSwitchTab, TabId_Container, tabId)
end

return AssassinLibraryViewContainer
