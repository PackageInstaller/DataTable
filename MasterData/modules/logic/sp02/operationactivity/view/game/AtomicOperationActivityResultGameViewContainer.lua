-- chunkname: @modules/logic/sp02/operationactivity/view/game/AtomicOperationActivityResultGameViewContainer.lua

module("modules.logic.sp02.operationactivity.view.game.AtomicOperationActivityResultGameViewContainer", package.seeall)

local AtomicOperationActivityResultGameViewContainer = class("AtomicOperationActivityResultGameViewContainer", BaseViewContainer)

function AtomicOperationActivityResultGameViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityResultGameView.New())

	return views
end

return AtomicOperationActivityResultGameViewContainer
