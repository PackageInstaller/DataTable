-- chunkname: @modules/logic/summonuiswitch/view/SummonUISwitchInfoViewContainer.lua

module("modules.logic.summonuiswitch.view.SummonUISwitchInfoViewContainer", package.seeall)

local SummonUISwitchInfoViewContainer = class("SummonUISwitchInfoViewContainer", BaseViewContainer)

function SummonUISwitchInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonUISwitchInfoView.New())
	table.insert(views, SummonUISwitchInfoDisplayView.New())

	return views
end

return SummonUISwitchInfoViewContainer
