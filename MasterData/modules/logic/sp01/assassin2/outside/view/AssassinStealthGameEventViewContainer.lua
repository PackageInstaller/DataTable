-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameEventViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEventViewContainer", package.seeall)

local AssassinStealthGameEventViewContainer = class("AssassinStealthGameEventViewContainer", BaseViewContainer)

function AssassinStealthGameEventViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStealthGameEventView.New())

	return views
end

function AssassinStealthGameEventViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return AssassinStealthGameEventViewContainer
