-- chunkname: @modules/logic/fight/view/preview/SkillEffectStatView.lua

module("modules.logic.fight.view.preview.SkillEffectStatView", package.seeall)

local SkillEffectStatView = class("SkillEffectStatView", BaseView)

function SkillEffectStatView:onInitView()
	self._btnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "btnOpen")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._btnClear = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnClear")
	self._btnSpeed = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnSpeed")
	self._txtSpeed = gohelper.findChildText(self.viewGO, "view/title/btnSpeed/Text")
	self._slider = gohelper.findChildSlider(self.viewGO, "view/title/slider")
	self._contentViewGO = gohelper.findChild(self.viewGO, "view")
	self._imgViewBg = self._contentViewGO:GetComponent(gohelper.Type_Image)

	self._slider:SetValue(self._imgViewBg.color.a)
	gohelper.setActive(self._btnOpen.gameObject, true)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._contentViewGO.gameObject, false)
end

function SkillEffectStatView:addEvents()
	self._btnOpen:AddClickListener(self._onClickOpen, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnClear:AddClickListener(self._onClickClear, self)
	self._btnSpeed:AddClickListener(self._onClickSpeed, self)
	self._slider:AddOnValueChanged(self._onValueChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnHideSkillEditorUIEvent, self._onHideSkillEditorUIEvent, self)
end

function SkillEffectStatView:removeEvents()
	self._btnOpen:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnSpeed:RemoveClickListener()
	self._slider:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._onFrame, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnHideSkillEditorUIEvent, self._onHideSkillEditorUIEvent, self)
end

function SkillEffectStatView:_onHideSkillEditorUIEvent(state)
	local canvasGorup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	canvasGorup.alpha = state
end

function SkillEffectStatView:_onClickOpen()
	gohelper.setActive(self._btnOpen.gameObject, false)
	gohelper.setActive(self._btnClose.gameObject, true)
	gohelper.setActive(self._contentViewGO.gameObject, true)
	TaskDispatcher.runRepeat(self._onFrame, self, 0.01)
end

function SkillEffectStatView:_onClickClose()
	gohelper.setActive(self._btnOpen.gameObject, true)
	gohelper.setActive(self._btnClose.gameObject, false)
	gohelper.setActive(self._contentViewGO.gameObject, false)
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function SkillEffectStatView:_onClickSpeed()
	if UnityEngine.Time.timeScale < 0.5 then
		self._txtSpeed.text = "速度0.01"
		UnityEngine.Time.timeScale = 1
	else
		UnityEngine.Time.timeScale = 0.01
		self._txtSpeed.text = "恢复速度"
	end
end

function SkillEffectStatView:_onClickClear()
	SkillEffectStatModel.instance:clearStat()
end

function SkillEffectStatView:_onValueChanged(param, value)
	local color = self._imgViewBg.color

	color.a = value
	self._imgViewBg.color = color
end

function SkillEffectStatView:_onFrame()
	SkillEffectStatModel.instance:statistic()
end

return SkillEffectStatView
