-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGamePauseViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGamePauseViewContainer", package.seeall)

local AssassinStealthGamePauseViewContainer = class("AssassinStealthGamePauseViewContainer", BaseViewContainer)

function AssassinStealthGamePauseViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStealthGamePauseView.New())

	return views
end

function AssassinStealthGamePauseViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return AssassinStealthGamePauseViewContainer
