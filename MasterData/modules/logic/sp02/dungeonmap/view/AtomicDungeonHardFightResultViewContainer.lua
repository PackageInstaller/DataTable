-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonHardFightResultViewContainer.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonHardFightResultViewContainer", package.seeall)

local AtomicDungeonHardFightResultViewContainer = class("AtomicDungeonHardFightResultViewContainer", BaseViewContainer)

function AtomicDungeonHardFightResultViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDungeonHardFightResultView.New())

	return views
end

return AtomicDungeonHardFightResultViewContainer
