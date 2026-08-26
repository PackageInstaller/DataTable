-- chunkname: @modules/logic/store/view/optionalcharge/OptionalGroupChargeViewContainer.lua

module("modules.logic.store.view.optionalcharge.OptionalGroupChargeViewContainer", package.seeall)

local OptionalGroupChargeViewContainer = class("OptionalGroupChargeViewContainer", BaseViewContainer)

function OptionalGroupChargeViewContainer:buildViews()
	local views = {}

	table.insert(views, OptionalGroupChargeView.New())

	return views
end

return OptionalGroupChargeViewContainer
