-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingLevelUpSuccessViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpSuccessViewContainer", package.seeall)

local AssassinBuildingLevelUpSuccessViewContainer = class("AssassinBuildingLevelUpSuccessViewContainer", BaseViewContainer)

function AssassinBuildingLevelUpSuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinBuildingLevelUpSuccessView.New())

	return views
end

return AssassinBuildingLevelUpSuccessViewContainer
