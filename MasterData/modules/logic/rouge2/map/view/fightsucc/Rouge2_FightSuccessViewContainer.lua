-- chunkname: @modules/logic/rouge2/map/view/fightsucc/Rouge2_FightSuccessViewContainer.lua

module("modules.logic.rouge2.map.view.fightsucc.Rouge2_FightSuccessViewContainer", package.seeall)

local Rouge2_FightSuccessViewContainer = class("Rouge2_FightSuccessViewContainer", BaseViewContainer)

function Rouge2_FightSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_FightSuccessView.New())

	return views
end

return Rouge2_FightSuccessViewContainer
