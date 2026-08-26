-- chunkname: @modules/logic/clickuiswitch/view/ClickUISwitchInfoViewContainer.lua

module("modules.logic.clickuiswitch.view.ClickUISwitchInfoViewContainer", package.seeall)

local ClickUISwitchInfoViewContainer = class("ClickUISwitchInfoViewContainer", BaseViewContainer)

function ClickUISwitchInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, ClickUISwitchInfoView.New())

	return views
end

return ClickUISwitchInfoViewContainer
