-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDataBaseToastViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDataBaseToastViewContainer", package.seeall)

local AtomicDataBaseToastViewContainer = class("AtomicDataBaseToastViewContainer", BaseViewContainer)

function AtomicDataBaseToastViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDataBaseToastView.New())

	return views
end

return AtomicDataBaseToastViewContainer
