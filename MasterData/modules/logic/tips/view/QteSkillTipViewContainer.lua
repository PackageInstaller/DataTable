-- chunkname: @modules/logic/tips/view/QteSkillTipViewContainer.lua

module("modules.logic.tips.view.QteSkillTipViewContainer", package.seeall)

local QteSkillTipViewContainer = class("QteSkillTipViewContainer", BaseViewContainer)

function QteSkillTipViewContainer:buildViews()
	return {
		QteSkillTipView.New()
	}
end

return QteSkillTipViewContainer
