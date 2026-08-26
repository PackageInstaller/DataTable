-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonInteractViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonInteractViewContainer", package.seeall)

local AtomicDungeonInteractViewContainer = class("AtomicDungeonInteractViewContainer", BaseViewContainer)

function AtomicDungeonInteractViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDungeonInteractView.New())

	return views
end

return AtomicDungeonInteractViewContainer
