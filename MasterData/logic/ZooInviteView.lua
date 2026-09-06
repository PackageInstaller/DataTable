-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooInviteView.lua

module("logic.extensions.pk.view.ZooInviteView", package.seeall)

local ZooInviteView = class("ZooInviteView", ViewComponent)

function ZooInviteView:buildUI()
	ZooInviteView.super.buildUI(self)

	self._waitText = self:getTxt("waitText")
	self._time = goutil.findChildTextComponent(self.mainGO, "time")
	self._success = self:getTxt("success")
	self._cancelBtn = self:getBtn("cancelBtn")
end

function ZooInviteView:bindEvents()
	ZooInviteView.super.bindEvents(self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
end

function ZooInviteView:unbindEvents()
	ZooInviteView.super.unbindEvents(self)
	self._cancelBtn:RemoveClickListener()
end

function ZooInviteView:onEnter()
	ZooInviteView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._animalMo = openParam[1]
	self._friendMo = openParam[2]

	self:_onWaitingStatus()
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyPairRefuse, self._onRefusedStatus, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyPairAccept, self._onAcceptedStatus, self)
end

function ZooInviteView:onExit()
	ZooInviteView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyPairRefuse, self._onRefusedStatus, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyPairAccept, self._onAcceptedStatus, self)
	removetimer(self._tickInviteTimer, self)
end

function ZooInviteView:_onClickCancel()
	if self._seconds <= 0 then
		self:close()
	end
end

function ZooInviteView:_onWaitingStatus()
	goutil.setActive(self._waitText.gameObject, true)
	goutil.setActive(self._time.gameObject, true)
	goutil.setActive(self._success.gameObject, false)
	goutil.setActive(self._cancelBtn.gameObject, false)

	self._waitText.text = string.format(lang("petzoo_match_invite_waiting"), self._friendMo:getValue("name"))
	self._seconds = ZooConfig.instance:getInviteMatchWaitingTime()
	self._time.text = string.format(lang("petzoo_match_invite_counttime"), self._seconds)

	settimer(1, self._tickInviteTimer, self, true)
end

function ZooInviteView:_onTimemoutStatus()
	goutil.setActive(self._waitText.gameObject, false)
	goutil.setActive(self._time.gameObject, false)
	goutil.setActive(self._success.gameObject, true)

	self._success.text = lang("petzoo_match_invite_norespond")

	removetimer(self._tickInviteTimer, self)
	goutil.setActive(self._cancelBtn.gameObject, true)
end

function ZooInviteView:_tickInviteTimer()
	self._seconds = self._seconds - 1

	if self._seconds >= 0 then
		self._time.text = string.format(lang("petzoo_match_invite_counttime"), self._seconds)
	else
		self:_onTimemoutStatus()
	end
end

function ZooInviteView:_onRefusedStatus()
	goutil.setActive(self._waitText.gameObject, false)
	goutil.setActive(self._time.gameObject, false)
	goutil.setActive(self._success.gameObject, true)
	printInfo(lang("petzoo_match_invite_refused"))

	self._success.text = lang("petzoo_match_invite_refused")
	self._seconds = -1

	removetimer(self._tickInviteTimer, self)
	goutil.setActive(self._cancelBtn.gameObject, true)
end

function ZooInviteView:_onAcceptedStatus()
	goutil.setActive(self._waitText.gameObject, false)
	goutil.setActive(self._time.gameObject, false)

	self._success.text = lang("petzoo_match_invite_accepted")

	goutil.setActive(self._success.gameObject, true)
	self:close()
end

return ZooInviteView
