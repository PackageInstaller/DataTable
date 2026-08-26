-- chunkname: @modules/logic/endofdream/view/EndOfDreamViewContainer.lua

module("modules.logic.endofdream.view.EndOfDreamViewContainer", package.seeall)

local EndOfDreamViewContainer = class("EndOfDreamViewContainer", BaseViewContainer)

function EndOfDreamViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, EndOfDreamView.New())

	return views
end

function EndOfDreamViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigationView
	}
end

return EndOfDreamViewContainer
