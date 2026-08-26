-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinTechniqueViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinTechniqueViewContainer", package.seeall)

local AssassinTechniqueViewContainer = class("AssassinTechniqueViewContainer", BaseViewContainer)

function AssassinTechniqueViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinTechniqueView.New())

	return views
end

return AssassinTechniqueViewContainer
