-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_ActiveSkillAttrUpdateTipsViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_ActiveSkillAttrUpdateTipsViewContainer", package.seeall)

local Rouge2_ActiveSkillAttrUpdateTipsViewContainer = class("Rouge2_ActiveSkillAttrUpdateTipsViewContainer", BaseViewContainer)

function Rouge2_ActiveSkillAttrUpdateTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ActiveSkillAttrUpdateTipsView.New())

	return views
end

return Rouge2_ActiveSkillAttrUpdateTipsViewContainer
