-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameGetItemViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameGetItemViewContainer", package.seeall)

local AssassinStealthGameGetItemViewContainer = class("AssassinStealthGameGetItemViewContainer", BaseViewContainer)

function AssassinStealthGameGetItemViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStealthGameGetItemView.New())

	return views
end

function AssassinStealthGameGetItemViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return AssassinStealthGameGetItemViewContainer
