-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityGameTipViewContainer.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityGameTipViewContainer", package.seeall)

local AtomicOperationActivityGameTipViewContainer = class("AtomicOperationActivityGameTipViewContainer", BaseViewContainer)

function AtomicOperationActivityGameTipViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityGameTipView.New())

	return views
end

return AtomicOperationActivityGameTipViewContainer
