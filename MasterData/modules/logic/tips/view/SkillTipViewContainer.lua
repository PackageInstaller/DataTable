-- chunkname: @modules/logic/tips/view/SkillTipViewContainer.lua

module("modules.logic.tips.view.SkillTipViewContainer", package.seeall)

local SkillTipViewContainer = class("SkillTipViewContainer", BaseViewContainer)

function SkillTipViewContainer:buildViews()
	return {
		SkillTipView.New()
	}
end

function SkillTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function SkillTipViewContainer:getCustomViewMaskAlpha()
	local isOpen = ViewMgr.instance:isOpen(ViewName.AssassinStatsView)

	if isOpen then
		return 0
	end
end

return SkillTipViewContainer
