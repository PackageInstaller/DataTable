-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchEquipViewContainer.lua

module("modules.logic.fightuiswitch.view.FightUISwitchEquipViewContainer", package.seeall)

local FightUISwitchEquipViewContainer = class("FightUISwitchEquipViewContainer", BaseViewContainer)

function FightUISwitchEquipViewContainer:buildViews()
	local views = {}

	table.insert(views, FightUISwitchEquipView.New())

	return views
end

return FightUISwitchEquipViewContainer
