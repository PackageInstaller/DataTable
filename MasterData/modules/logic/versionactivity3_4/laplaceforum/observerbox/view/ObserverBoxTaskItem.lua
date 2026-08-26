-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/view/ObserverBoxTaskItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.view.ObserverBoxTaskItem", package.seeall)

local ObserverBoxTaskItem = class("ObserverBoxTaskItem", LuaCompBase)

function ObserverBoxTaskItem:init(go)
	self.go = go
	self._gocommon = gohelper.findChild(self.go, "go_common")
	self._txttaskdes = gohelper.findChildText(self.go, "go_common/txt_taskdes")
	self._gorewards = gohelper.findChild(self.go, "go_common/go_rewards")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.go, "go_common/btn_finishbg")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "go_common/btn_notfinishbg")
	self._goget = gohelper.findChild(self.go, "go_common/go_get")
	self._itemAnim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._rewardItems = {}

	self:_addEvents()
end

function ObserverBoxTaskItem:_addEvents()
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
end

function ObserverBoxTaskItem:_removeEvents()
	self._btnfinishbg:RemoveClickListener()
	self._btnnotfinishbg:RemoveClickListener()
end

function ObserverBoxTaskItem:_btnnotfinishbgOnClick()
	if self._mo then
		local jumpId = self._mo.config.jumpId

		if jumpId and jumpId > 0 then
			GameFacade.jump(jumpId)
		end
	end
end

function ObserverBoxTaskItem:_btnfinishbgOnClick()
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_lit)
	gohelper.setActive(self._goget, true)
	self._itemAnim:Play("finish", 0, 0)
	TaskDispatcher.runDelay(self._onSendTaskFinish, self, 0.67)
end

function ObserverBoxTaskItem:_onSendTaskFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function ObserverBoxTaskItem:refresh(mo)
	gohelper.setActive(self.go, true)

	self._mo = mo

	gohelper.setActive(self._gocommon, true)
	gohelper.setActive(self._goget, false)
	gohelper.setActive(self._btnnotfinishbg, false)
	gohelper.setActive(self._btnfinishbg.gameObject, false)

	self._txttaskdes.text = string.format("%s(%s/%s)", self._mo.config.desc, self._mo.progress, self._mo.config.maxProgress)

	if self._mo.finishCount > 0 then
		gohelper.setActive(self._goget, true)
	elseif self._mo.progress >= self._mo.config.maxProgress then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
	else
		gohelper.setActive(self._btnnotfinishbg.gameObject, self._mo.config.jumpId ~= 0)
	end
end

function ObserverBoxTaskItem:hide()
	gohelper.setActive(self.go, false)
end

function ObserverBoxTaskItem:destroy()
	TaskDispatcher.cancelTask(self._onSendTaskFinish, self)
	self:_removeEvents()
end

return ObserverBoxTaskItem
