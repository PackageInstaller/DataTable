-- chunkname: @modules/logic/store/view/optionalcharge/OptionalChargeViewContainer.lua

module("modules.logic.store.view.optionalcharge.OptionalChargeViewContainer", package.seeall)

local OptionalChargeViewContainer = class("OptionalChargeViewContainer", BaseViewContainer)

function OptionalChargeViewContainer:buildViews()
	local views = {}

	table.insert(views, OptionalChargeView.New())

	return views
end

return OptionalChargeViewContainer
