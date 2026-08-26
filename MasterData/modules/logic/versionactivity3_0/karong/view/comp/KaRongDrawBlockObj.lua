-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawBlockObj.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawBlockObj", package.seeall)

local KaRongDrawBlockObj = class("KaRongDrawBlockObj", KaRongDrawBaseObj)

function KaRongDrawBlockObj:ctor(go)
	KaRongDrawBlockObj.super.ctor(self, go)

	self._btnswitch = gohelper.findChildButtonWithAudio(self.go, "#btn_switch")

	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)

	self._anim = go:GetComponent(gohelper.Type_Animator)

	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.UsingSkill, self._onUsingSkill, self)
end

function KaRongDrawBlockObj:_onUsingSkill(using)
	gohelper.setActive(self._btnswitch, using)

	local animName = using and "highlight" or "gray"

	self._anim:Play(animName, 0, 0)
end

function KaRongDrawBlockObj:onInit(mo)
	KaRongDrawBlockObj.super.onInit(self, mo)
	gohelper.setActive(self._btnswitch.gameObject, false)
end

function KaRongDrawBlockObj:_btnswitchOnClick()
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_barrier_dispel)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("KaRongDrawBlockObj")
	self._anim:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._delayHide, self, 1.67)
end

function KaRongDrawBlockObj:_delayHide()
	gohelper.setActive(self.go, false)
	KaRongDrawController.instance:useSkill(self.mo)
	UIBlockMgr.instance:endBlock("KaRongDrawBlockObj")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function KaRongDrawBlockObj:destroy()
	TaskDispatcher.cancelTask(self._delayHide, self)
	UIBlockMgr.instance:endBlock("KaRongDrawBlockObj")
	UIBlockMgrExtend.setNeedCircleMv(true)
	self._btnswitch:RemoveClickListener()
	KaRongDrawBlockObj.super.destroy(self)
end

return KaRongDrawBlockObj
