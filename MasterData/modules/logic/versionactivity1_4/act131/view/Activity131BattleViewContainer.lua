-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131BattleViewContainer.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131BattleViewContainer", package.seeall)

local Activity131BattleViewContainer = class("Activity131BattleViewContainer", BaseViewContainer)

function Activity131BattleViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity131BattleView.New())

	return views
end

return Activity131BattleViewContainer
