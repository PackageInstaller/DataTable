-- chunkname: @modules/logic/sp02/dungeon/view/V3A10_FightSuccViewContainer.lua

module("modules.logic.sp02.dungeon.view.V3A10_FightSuccViewContainer", package.seeall)

local V3A10_FightSuccViewContainer = class("V3A10_FightSuccViewContainer", BaseViewContainer)

function V3A10_FightSuccViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A10_FightSuccView.New())

	return views
end

return V3A10_FightSuccViewContainer
