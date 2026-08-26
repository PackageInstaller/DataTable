-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickTipsViewContainer.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickTipsViewContainer", package.seeall)

local SummonNewCustomPickTipsViewContainer = class("SummonNewCustomPickTipsViewContainer", BaseViewContainer)

function SummonNewCustomPickTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonNewCustomPickTipsView.New())

	return views
end

return SummonNewCustomPickTipsViewContainer
