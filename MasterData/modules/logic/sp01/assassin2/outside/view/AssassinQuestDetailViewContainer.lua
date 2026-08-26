-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestDetailViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestDetailViewContainer", package.seeall)

local AssassinQuestDetailViewContainer = class("AssassinQuestDetailViewContainer", BaseViewContainer)

function AssassinQuestDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinQuestDetailView.New())

	return views
end

function AssassinQuestDetailViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return AssassinQuestDetailViewContainer
