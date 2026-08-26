-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillLevelUpViewContainer.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillLevelUpViewContainer", package.seeall)

local Rouge2_ActiveSkillLevelUpViewContainer = class("Rouge2_ActiveSkillLevelUpViewContainer", BaseViewContainer)

function Rouge2_ActiveSkillLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ActiveSkillLevelUpView.New())

	return views
end

function Rouge2_ActiveSkillLevelUpViewContainer:buildTabViews(tabContainerId)
	return
end

return Rouge2_ActiveSkillLevelUpViewContainer
