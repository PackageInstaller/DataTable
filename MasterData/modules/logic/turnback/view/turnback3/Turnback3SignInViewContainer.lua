-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3SignInViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3SignInViewContainer", package.seeall)

local Turnback3SignInViewContainer = class("Turnback3SignInViewContainer", BaseViewContainer)

function Turnback3SignInViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3SignInView.New())

	return views
end

return Turnback3SignInViewContainer
