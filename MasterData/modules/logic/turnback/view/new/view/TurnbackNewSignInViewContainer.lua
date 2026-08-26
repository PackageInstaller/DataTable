-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewSignInViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewSignInViewContainer", package.seeall)

local TurnbackNewSignInViewContainer = class("TurnbackNewSignInViewContainer", BaseViewContainer)

function TurnbackNewSignInViewContainer:buildViews()
	local views = {}

	table.insert(views, TurnbackNewSignInView.New())

	return views
end

return TurnbackNewSignInViewContainer
