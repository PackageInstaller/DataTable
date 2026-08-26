-- chunkname: @modules/logic/fight/view/preview/SkillEditorBuffSelectView.lua

module("modules.logic.fight.view.preview.SkillEditorBuffSelectView", package.seeall)

local SkillEditorBuffSelectView = class("SkillEditorBuffSelectView", BaseView)

SkillEditorBuffSelectView.idCounter = 0
SkillEditorBuffSelectView._show_frame = false

function SkillEditorBuffSelectView:ctor()
	return
end

function SkillEditorBuffSelectView:onInitView()
	self._buffViewGO = gohelper.findChild(self.viewGO, "selectBuff")
	self._btnBuffPreviewL = gohelper.findChildButtonWithAudio(self.viewGO, "scene/Grid/btnBuffPreview")
	self._inp = gohelper.findChildTextMeshInputField(self.viewGO, "selectBuff/inp")
	self._btnClose = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectBuff/btnClose")
	self._btnClearBuff = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectBuff/btnClearBuff")
	self._btnswitchframestate = SLFramework.UGUI.ButtonWrap.GetWithPath(self.viewGO, "selectBuff/btnSwitchFrameState")
end

function SkillEditorBuffSelectView:addEvents()
	self._btnBuffPreviewL:AddClickListener(self._showThis, self, FightEnum.EntitySide.EnemySide)
	self._inp:AddOnValueChanged(self._onInpValueChanged, self)
	self._btnClose:AddClickListener(self._hideThis, self)
	self._btnClearBuff:AddClickListener(self._clearBuff, self)
	self._btnswitchframestate:AddClickListener(self._onSwitchFrameState, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEditorPlayBuffStart, self._onPlayBuffStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnEditorPlayBuffEnd, self._onPlayBuffEnd, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffClick, self._onBuffClick, self)
	SLFramework.UGUI.UIClickListener.Get(self._buffViewGO):AddClickListener(self._hideThis, self)
end

function SkillEditorBuffSelectView:removeEvents()
	self._btnBuffPreviewL:RemoveClickListener()
	self._inp:RemoveOnValueChanged()
	self._btnClose:RemoveClickListener()
	self._btnClearBuff:RemoveClickListener()
	self._btnswitchframestate:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._buffViewGO):RemoveClickListener()
end

function SkillEditorBuffSelectView:_showThis(side)
	self._attacker = SkillEditorMgr.instance.cur_select_entity_id and FightGameMgr.entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id) or FightGameMgr.entityMgr:getEntityByPosId(SceneTag.UnitPlayer, SkillEditorView.selectPosId[FightEnum.EntitySide.MySide])

	if not self._attacker then
		logError("所选对象错误，请从新选择对象")

		return
	end

	gohelper.setActive(self._buffViewGO, true)
	self:_updateItems()
end

function SkillEditorBuffSelectView:_hideThis()
	gohelper.setActive(self._buffViewGO, false)
end

function SkillEditorBuffSelectView:_onInpValueChanged(inputStr)
	self:_updateItems()
end

function SkillEditorBuffSelectView:_clearBuff()
	local sideEntityList = FightHelper.getSideEntitys(SkillEditorMgr.instance.cur_select_side, false)

	for _, entity in ipairs(sideEntityList) do
		local buffDic = entity:getMO():getBuffDic()

		for _, buffMO in pairs(buffDic) do
			entity:getMO():delBuff(buffMO.uid)
			entity.buff:delBuff(buffMO.uid)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate)
	self:_hideThis()
end

function SkillEditorBuffSelectView:_updateItems()
	SkillEditorBuffSelectModel.instance:setSelect(self._attacker, self._inp:GetText())
end

function SkillEditorBuffSelectView.genBuffUid()
	SkillEditorBuffSelectView.idCounter = SkillEditorBuffSelectView.idCounter + 1

	return SkillEditorBuffSelectView.idCounter
end

function SkillEditorBuffSelectView:_onSwitchFrameState()
	SkillEditorBuffSelectView._show_frame = not SkillEditorBuffSelectView._show_frame
	self._btnswitchframestate.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = SkillEditorBuffSelectView._show_frame and "关闭帧数显示" or "开启帧数显示"
end

function SkillEditorBuffSelectView:_onPlayBuffStart()
	gohelper.setActive(self._buffViewGO, false)
end

function SkillEditorBuffSelectView:_onPlayBuffEnd()
	gohelper.setActive(self._buffViewGO, true)
end

function SkillEditorBuffSelectView:_onBuffClick(entityId, buffIconTransform, offsetX, offsetY)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, entityId)
end

return SkillEditorBuffSelectView
