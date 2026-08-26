-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4SignInViewContainer.lua

module("modules.logic.turnback.view.turnback4.Turnback4SignInViewContainer", package.seeall)

local Turnback4SignInViewContainer = class("Turnback4SignInViewContainer", BaseViewContainer)

function Turnback4SignInViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback4SignInView.New())

	return views
end

return Turnback4SignInViewContainer
