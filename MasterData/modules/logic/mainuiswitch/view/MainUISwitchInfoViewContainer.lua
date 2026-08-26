-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoViewContainer.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoViewContainer", package.seeall)

local MainUISwitchInfoViewContainer = class("MainUISwitchInfoViewContainer", BaseViewContainer)

function MainUISwitchInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, MainUISwitchInfoView.New())
	table.insert(views, TabViewGroup.New(1, "middle/#go_mainUI"))

	return views
end

function MainUISwitchInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local t = {}

		self:_addMainUI(t)

		return t
	end
end

function MainUISwitchInfoViewContainer:_addMainUI(t)
	local views = {}

	table.insert(views, SwitchMainUIShowView.New())
	table.insert(views, SwitchMainActivityEnterView.New())
	table.insert(views, SwitchMainActExtraDisplay.New())
	table.insert(views, SwitchMainUIView.New())
	table.insert(views, SwitchMainUIEagleAnimView.New())
	table.insert(views, MainBirdAnimView.New())

	t[1] = MultiView.New(views)

	return t[1]
end

return MainUISwitchInfoViewContainer
