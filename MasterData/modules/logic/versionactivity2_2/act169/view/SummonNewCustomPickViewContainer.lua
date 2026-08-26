-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickViewContainer.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickViewContainer", package.seeall)

local SummonNewCustomPickViewContainer = class("SummonNewCustomPickViewContainer", BaseViewContainer)

function SummonNewCustomPickViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonNewCustomPickView.New())

	return views
end

return SummonNewCustomPickViewContainer
