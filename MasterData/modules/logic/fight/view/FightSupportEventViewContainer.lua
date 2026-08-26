-- chunkname: @modules/logic/fight/view/FightSupportEventViewContainer.lua

module("modules.logic.fight.view.FightSupportEventViewContainer", package.seeall)

local FightSupportEventViewContainer = class("FightSupportEventViewContainer", BaseViewContainer)

function FightSupportEventViewContainer:buildViews()
	local views = {}

	table.insert(views, FightSupportEventView.New())

	return views
end

return FightSupportEventViewContainer
