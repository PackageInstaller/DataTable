-- chunkname: @modules/logic/sp02/operationactivity/view/game/AtomicOperationActivityGameCountDownViewContainer.lua

module("modules.logic.sp02.operationactivity.view.game.AtomicOperationActivityGameCountDownViewContainer", package.seeall)

local AtomicOperationActivityGameCountDownViewContainer = class("AtomicOperationActivityGameCountDownViewContainer", BaseViewContainer)

function AtomicOperationActivityGameCountDownViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityGameCountDownView.New())

	return views
end

return AtomicOperationActivityGameCountDownViewContainer
