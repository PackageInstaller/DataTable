-- chunkname: @modules/logic/fight/view/FightItemSkillInfosBtnView.lua

module("modules.logic.fight.view.FightItemSkillInfosBtnView", package.seeall)

local FightItemSkillInfosBtnView = class("FightItemSkillInfosBtnView", FightBaseView)

function FightItemSkillInfosBtnView:onInitView()
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Root/bottomLeft/#btn_skill")
end

function FightItemSkillInfosBtnView:addEvents()
	self:com_registClick(self.click, self.onClick)
	self:com_registMsg(FightMsgId.CheckGuideFightItemPlayerSkillGroup, self.onCheckGuideFightItemPlayerSkillGroup)
end

function FightItemSkillInfosBtnView:removeEvents()
	return
end

function FightItemSkillInfosBtnView:onCheckGuideFightItemPlayerSkillGroup()
	GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.FightItemPlayerSkillGroup)
end

function FightItemSkillInfosBtnView:onClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightItemSkillInfosView)
end

function FightItemSkillInfosBtnView:onOpen()
	return
end

return FightItemSkillInfosBtnView
