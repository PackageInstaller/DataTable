-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStatsViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStatsViewContainer", package.seeall)

local AssassinStatsViewContainer = class("AssassinStatsViewContainer", BaseViewContainer)

function AssassinStatsViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinStatsView.New())

	return views
end

function AssassinStatsViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return AssassinStatsViewContainer
