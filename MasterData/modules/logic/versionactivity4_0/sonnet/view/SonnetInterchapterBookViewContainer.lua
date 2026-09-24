-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterBookViewContainer.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterBookViewContainer", package.seeall)

local SonnetInterchapterBookViewContainer = class("SonnetInterchapterBookViewContainer", BaseViewContainer)

function SonnetInterchapterBookViewContainer:buildViews()
	local views = {}

	table.insert(views, SonnetInterchapterBookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function SonnetInterchapterBookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return SonnetInterchapterBookViewContainer
