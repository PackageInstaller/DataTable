-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonFightSuccViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonFightSuccViewContainer", package.seeall)

local AtomicDungeonFightSuccViewContainer = class("AtomicDungeonFightSuccViewContainer", BaseViewContainer)

function AtomicDungeonFightSuccViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDungeonFightSuccView.New())

	return views
end

return AtomicDungeonFightSuccViewContainer
