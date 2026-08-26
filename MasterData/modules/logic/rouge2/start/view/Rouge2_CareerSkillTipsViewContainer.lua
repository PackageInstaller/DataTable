-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerSkillTipsViewContainer.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerSkillTipsViewContainer", package.seeall)

local Rouge2_CareerSkillTipsViewContainer = class("Rouge2_CareerSkillTipsViewContainer", BaseViewContainer)

function Rouge2_CareerSkillTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_CareerSkillTipsView.New())

	return views
end

return Rouge2_CareerSkillTipsViewContainer
