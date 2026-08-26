-- chunkname: @modules/logic/gm/view/GMSummonViewContainer.lua

module("modules.logic.gm.view.GMSummonViewContainer", package.seeall)

local GMSummonViewContainer = class("GMSummonViewContainer", BaseViewContainer)

function GMSummonViewContainer:buildViews()
	local views = {}

	table.insert(views, GMSummonView.New())

	return views
end

return GMSummonViewContainer
