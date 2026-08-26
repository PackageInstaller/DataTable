-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinLoginViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinLoginViewContainer", package.seeall)

local AssassinLoginViewContainer = class("AssassinLoginViewContainer", BaseViewContainer)

function AssassinLoginViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinLoginView.New())

	return views
end

return AssassinLoginViewContainer
