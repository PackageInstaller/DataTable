-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkInviteView.lua

module("logic.extensions.pk.view.PkInviteView", package.seeall)

local PkInviteView = class("PkInviteView", ViewComponent)

function PkInviteView:ctor()
	PkInviteView.super.ctor(self)
end

function PkInviteView:buildUI()
	PkInviteView.super.buildUI(self)

	self._waitText = self:getTxt("waitText")
	self._time = goutil.findChildTextComponent(self.mainGO, "time")
	self._success = self:getTxt("success")
	self._cancelBtn = self:getBtn("cancelBtn")
end

function PkInviteView:bindEvents()
	PkInviteView.super.bindEvents(self)
	self._cancelBtn:AddClickListener(self._onClickCancel, self)
end

function PkInviteView:unbindEvents()
	PkInviteView.super.unbindEvents(self)
	self._cancelBtn:RemoveClickListener()
end

function PkInviteView:destroyUI()
	PkInviteView.super.destroyUI(self)
end

function PkInviteView:onEnter()
	PkInviteView.super.onEnter(self)
	goutil.setActive(self._waitText.gameObject, true)
	goutil.setActive(self._time.gameObject, true)
	goutil.setActive(self._success.gameObject, false)

	self._seconds = tonumber(PkConfig.instance:getCommonByKey("MATCH_TIME"))
	self._time.text = string.format("倒计时:%d秒", self._seconds)

	settimer(1, self._timer, self, true)

	self._enter = true
	self._waitText.text = string.format("正在等待%s接受邀请......", self:getFirstParam())

	GlobalDispatcher:addListener(GlobalNotify.FightRefused, self._fightRefused, self)
	GlobalDispatcher:addListener(GlobalNotify.FightStart, self._fightStart, self)
end

function PkInviteView:onEnterFinished()
	PkInviteView.super.onEnterFinished(self)
end

function PkInviteView:onExit()
	PkInviteView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FightRefused, self._fightRefused, self)
	GlobalDispatcher:removeListener(GlobalNotify.FightStart, self._fightStart, self)

	self._enter = false

	removetimer(self._timer, self)
	PkController.instance:setRefusedReason()
	QieCuoAgent.instance:getDispatcher():removeAllListener(QieCuoAgent.PM_CancelFightRes)
end

function PkInviteView:onExitFinished()
	PkInviteView.super.onExitFinished(self)
end

function PkInviteView:_onClickCancel()
	if self._seconds <= 0 or PkController.instance:getRefusedReason() then
		self:close()
	else
		QieCuoAgent.instance:sendPM_CancelFightReq(function()
			if self._enter then
				self:close()
			end
		end)
	end
end

function PkInviteView:_timer()
	if PkController.instance:getRefusedReason() then
		self:_fightRefused()

		return
	end

	self._seconds = self._seconds - 1

	if self._seconds >= 0 then
		self._time.text = string.format("倒计时:%d秒", self._seconds)
	else
		goutil.setActive(self._waitText.gameObject, false)
		goutil.setActive(self._time.gameObject, false)
		goutil.setActive(self._success.gameObject, true)

		self._success.text = "对方未响应你的邀请"

		removetimer(self._timer, self)
	end
end

function PkInviteView:_fightRefused()
	goutil.setActive(self._waitText.gameObject, false)
	goutil.setActive(self._time.gameObject, false)
	goutil.setActive(self._success.gameObject, true)

	self._success.text = PkController.instance:getRefusedReason()

	removetimer(self._timer, self)

	self._seconds = -1
end

function PkInviteView:_fightStart()
	goutil.setActive(self._waitText.gameObject, false)
	goutil.setActive(self._time.gameObject, false)
	goutil.setActive(self._success.gameObject, true)
	self:close()
	UIStateManager.instance:popByName(ViewName.PkListView)
	PkController.instance:startDefenseTimer()
	PkModel.instance:setMyFormation(clone(FormationNewModel.instance:GetCurTeam():GetCurFormation()))
	UIStateManager.instance:push(ViewName.PkFormationselectView)
end

return PkInviteView
