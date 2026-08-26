-- chunkname: @modules/logic/fight/view/preview/FightViewSkillFrame.lua

module("modules.logic.fight.view.preview.FightViewSkillFrame", package.seeall)

local FightViewSkillFrame = class("FightViewSkillFrame", BaseView)

function FightViewSkillFrame:ctor(show)
	self._show = not not show
end

function FightViewSkillFrame:onInitView()
	self._text = gohelper.findChildText(self.viewGO, "Text")
	self._goAutoProgress = gohelper.findChild(self.viewGO, "autoprogress")
	self._btnstop = gohelper.findChildButtonWithAudio(self.viewGO, "btnstop")
	self._txtRoleProgress = gohelper.findChildText(self.viewGO, "autoprogress/left/role")
	self._txtSkillProgress = gohelper.findChildText(self.viewGO, "autoprogress/right/skill")

	if not gohelper.isNil(self._text) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), self._text.gameObject)
		gohelper.setActive(self._text.gameObject, true)
	end

	if not gohelper.isNil(self._goAutoProgress) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), self._goAutoProgress)
	end

	if not gohelper.isNil(self._btnstop) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), self._btnstop.gameObject)
	end
end

function FightViewSkillFrame:addEvents()
	if not gohelper.isNil(self._text) then
		self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillStart, self)
		self.addEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillFinish, self)
		self.addEventCb(self, FightController.instance, FightEvent.OnEditorPlaySpineAniStart, self._onPlaySpineAniStart, self)
		self.addEventCb(self, FightController.instance, FightEvent.OnEditorPlaySpineAniEnd, self._onPlaySpineAniEnd, self)
		self.addEventCb(self, FightController.instance, FightEvent.OnEditorPlayBuffStart, self._onPlayBuffStart, self)

		if isDebugBuild then
			self._text.raycastTarget = true

			SLFramework.UGUI.UIClickListener.Get(self._text.gameObject):AddClickListener(self._onClickShow, self)
		end
	end

	if not gohelper.isNil(self._goAutoProgress) then
		SkillEditorMgr.instance:registerCallback(SkillEditorMgr._onSwitchEnityOrSkill, self._onSwitchEnityOrSkill, self)
	end

	if not gohelper.isNil(self._btnstop) then
		self._btnstop:AddClickListener(self._stopFlow, self)
	end
end

function FightViewSkillFrame:removeEvents()
	if not gohelper.isNil(self._text) then
		self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayStart, self._onSkillStart, self)
		self.removeEventCb(self, FightController.instance, FightEvent.OnSkillPlayFinish, self._onSkillFinish, self)
		self.removeEventCb(self, FightController.instance, FightEvent.OnEditorPlaySpineAniStart, self._onPlaySpineAniStart, self)
		self.removeEventCb(self, FightController.instance, FightEvent.OnEditorPlaySpineAniEnd, self._onPlaySpineAniEnd, self)
		self.removeEventCb(self, FightController.instance, FightEvent.OnEditorPlayBuffStart, self._onPlayBuffStart, self)
		TaskDispatcher.cancelTask(self._setFrameText, self)
		TaskDispatcher.cancelTask(self._setAniFrameText, self)

		if isDebugBuild then
			SLFramework.UGUI.UIClickListener.Get(self._text.gameObject):RemoveClickListener()
		end
	end

	if not gohelper.isNil(self._goAutoProgress) then
		SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._onSwitchEnityOrSkill, self._onSwitchEnityOrSkill, self)
	end

	if not gohelper.isNil(self._btnstop) then
		self._btnstop:RemoveClickListener()
	end
end

function FightViewSkillFrame:onDestroyView()
	if not gohelper.isNil(self._text) then
		gohelper.destroy(self._text.gameObject)

		self._text = nil
	end

	if not gohelper.isNil(self._goAutoProgress) then
		gohelper.destroy(self._goAutoProgress)

		self._goAutoProgress = nil
	end

	if not gohelper.isNil(self._btnstop) then
		gohelper.destroy(self._btnstop.gameObject)
	end
end

function FightViewSkillFrame:_onClickShow()
	self._show = true
end

function FightViewSkillFrame:_stopFlow()
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._StopAutoPlayFlow1)
end

function FightViewSkillFrame:_onSkillStart(entity, skillId)
	if not self._show then
		return
	end

	self._entity = entity

	TaskDispatcher.runRepeat(self._setFrameText, self, 0.01)
	self:_setFrameText()
end

function FightViewSkillFrame:_onSkillFinish(entity, skillId)
	if not self._show then
		return
	end

	TaskDispatcher.cancelTask(self._setFrameText, self)
end

function FightViewSkillFrame:_setFrameText()
	if not self._show then
		return
	end

	local binder = self._entity.skill:getBinder()

	if self._entity and self._entity.skill and binder then
		local curFrame = binder.CurFrame

		if curFrame > 0 then
			self._text.text = "技能预览\n" .. curFrame
		end
	end
end

function FightViewSkillFrame:_onPlaySpineAniStart(entity)
	if not self._show then
		return
	end

	self._entity = entity

	TaskDispatcher.runRepeat(self._setAniFrameText, self, 0.01)
	self:_setAniFrameText()
end

function FightViewSkillFrame:_onPlaySpineAniEnd()
	if not self._show then
		return
	end

	TaskDispatcher.cancelTask(self._setAniFrameText, self)
end

function FightViewSkillFrame:_setAniFrameText()
	if not self._show then
		return
	end

	if self._entity and self._entity.spine then
		self._text.text = "小人动作\n" .. math.ceil(self._entity.spine._skeletonAnim:GetCurFrame())
	end
end

function FightViewSkillFrame:_onPlayBuffStart()
	if not self._show then
		return
	end

	self._buff_startTime = Time.time

	TaskDispatcher.runRepeat(self._seBuffFrameText, self, 0.01)
	self:_seBuffFrameText()
end

function FightViewSkillFrame:_onPlayBuffEnd()
	if not self._show then
		return
	end

	TaskDispatcher.cancelTask(self._seBuffFrameText, self)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlayBuffEnd)

	self._text.text = ""
end

function FightViewSkillFrame:_seBuffFrameText()
	if not self._show then
		return
	end

	self._text.text = "buff时间\n" .. math.ceil((Time.time - self._buff_startTime) * 60)

	if Time.time - self._buff_startTime >= 3 then
		self:_onPlayBuffEnd()
	end
end

function FightViewSkillFrame:_onSwitchEnityOrSkill(param)
	if param then
		local rolestr = param.rolestr
		local skillstr = param.skillstr

		if rolestr or skillstr then
			gohelper.setActive(self.viewGO, false)
			gohelper.setActive(self._goAutoProgress, true)
			gohelper.setActive(self._btnstop.gameObject, true)

			self._txtRoleProgress.text = rolestr or self._txtRoleProgress.text
			self._txtSkillProgress.text = skillstr or self._txtSkillProgress.text
		end
	else
		gohelper.setActive(self.viewGO, true)
		gohelper.setActive(self._goAutoProgress, false)
		gohelper.setActive(self._btnstop.gameObject, false)
	end
end

return FightViewSkillFrame
