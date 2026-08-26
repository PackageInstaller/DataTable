-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillDropViewContainer.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillDropViewContainer", package.seeall)

local Rouge2_ActiveSkillDropViewContainer = class("Rouge2_ActiveSkillDropViewContainer", BaseViewContainer)

function Rouge2_ActiveSkillDropViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ActiveSkillDropView.New())

	return views
end

function Rouge2_ActiveSkillDropViewContainer:buildTabViews(tabContainerId)
	return
end

return Rouge2_ActiveSkillDropViewContainer
