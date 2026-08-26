-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchSceneViewContainer.lua

module("modules.logic.fightuiswitch.view.FightUISwitchSceneViewContainer", package.seeall)

local FightUISwitchSceneViewContainer = class("FightUISwitchSceneViewContainer", BaseViewContainer)

function FightUISwitchSceneViewContainer:buildViews()
	local views = {}

	table.insert(views, FightUISwitchSceneView.New())

	return views
end

return FightUISwitchSceneViewContainer
