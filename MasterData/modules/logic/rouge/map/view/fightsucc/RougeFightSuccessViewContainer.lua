-- chunkname: @modules/logic/rouge/map/view/fightsucc/RougeFightSuccessViewContainer.lua

module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessViewContainer", package.seeall)

local RougeFightSuccessViewContainer = class("RougeFightSuccessViewContainer", BaseViewContainer)

function RougeFightSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeFightSuccessView.New())

	return views
end

return RougeFightSuccessViewContainer
