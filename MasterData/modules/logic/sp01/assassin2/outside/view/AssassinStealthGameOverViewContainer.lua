-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameOverViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameOverViewContainer", package.seeall)

local AssassinStealthGameOverViewContainer = class("AssassinStealthGameOverViewContainer", BaseViewContainer)

function AssassinStealthGameOverViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStealthGameOverView.New())

	return views
end

function AssassinStealthGameOverViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return AssassinStealthGameOverViewContainer
