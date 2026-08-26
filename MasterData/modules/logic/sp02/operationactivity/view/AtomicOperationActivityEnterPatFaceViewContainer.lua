-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityEnterPatFaceViewContainer.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityEnterPatFaceViewContainer", package.seeall)

local AtomicOperationActivityEnterPatFaceViewContainer = class("AtomicOperationActivityEnterPatFaceViewContainer", BaseViewContainer)

function AtomicOperationActivityEnterPatFaceViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityEnterPatFaceView.New())

	return views
end

return AtomicOperationActivityEnterPatFaceViewContainer
