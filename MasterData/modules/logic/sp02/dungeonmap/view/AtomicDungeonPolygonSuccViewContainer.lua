-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonSuccViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonSuccViewContainer", package.seeall)

local AtomicDungeonPolygonSuccViewContainer = class("AtomicDungeonPolygonSuccViewContainer", BaseViewContainer)

function AtomicDungeonPolygonSuccViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDungeonPolygonSuccView.New())

	return views
end

return AtomicDungeonPolygonSuccViewContainer
