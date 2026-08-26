-- chunkname: @modules/logic/turnback/view/TurnbackRewardShowViewContainer.lua

module("modules.logic.turnback.view.TurnbackRewardShowViewContainer", package.seeall)

local TurnbackRewardShowViewContainer = class("TurnbackRewardShowViewContainer", BaseViewContainer)

function TurnbackRewardShowViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackRewardShowView.New())

	return views
end

return TurnbackRewardShowViewContainer
