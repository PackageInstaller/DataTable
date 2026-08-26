-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickFullViewContainer.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickFullViewContainer", package.seeall)

local SummonNewCustomPickFullViewContainer = class("SummonNewCustomPickFullViewContainer", BaseViewContainer)

function SummonNewCustomPickFullViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonNewCustomPickFullView.New())

	return views
end

return SummonNewCustomPickFullViewContainer
