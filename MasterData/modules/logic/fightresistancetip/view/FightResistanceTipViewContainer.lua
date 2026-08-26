-- chunkname: @modules/logic/fightresistancetip/view/FightResistanceTipViewContainer.lua

module("modules.logic.fightresistancetip.view.FightResistanceTipViewContainer", package.seeall)

local FightResistanceTipViewContainer = class("FightResistanceTipViewContainer", BaseViewContainer)

function FightResistanceTipViewContainer:buildViews()
	local views = {}

	table.insert(views, FightResistanceTipView.New())

	return views
end

return FightResistanceTipViewContainer
