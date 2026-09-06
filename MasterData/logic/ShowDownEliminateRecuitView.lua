-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateRecuitView.lua

module("logic.extensions.showdown.view.ShowDownEliminateRecuitView", package.seeall)

local ShowDownEliminateRecuitView = class("ShowDownEliminateRecuitView", ViewComponent)

function ShowDownEliminateRecuitView:ctor()
	ShowDownEliminateRecuitView.super.ctor(self)
end

function ShowDownEliminateRecuitView:bindEvents()
	ShowDownEliminateRecuitView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._inputFieldOfMin:AddOnValueChanged(self._onLeftValueChanged, self)
	self._inputFieldOfMax:AddOnValueChanged(self._onRightValueChanged, self)
	self._recordInputField:AddOnValueChanged(self._onRecordValueChanged, self)
	self._petInputField:AddOnValueChanged(self._onPetValueChanged, self)
end

function ShowDownEliminateRecuitView:unbindEvents()
	ShowDownEliminateRecuitView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	self._btnSure:RemoveClickListener()
	self._inputFieldOfMin:RemoveOnValueChanged()
	self._inputFieldOfMax:RemoveOnValueChanged()
	self._recordInputField:RemoveOnValueChanged()
	self._petInputField:RemoveOnValueChanged()
end

function ShowDownEliminateRecuitView:buildUI()
	ShowDownEliminateRecuitView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._inputFieldOfMin = self:getInput("level/InputFieldOfMin")
	self._inputFieldOfMax = self:getInput("level/InputFieldOfMax")
	self._recordInputField = self:getInput("record/InputField")
	self._petInputField = self:getInput("pet/InputField")
	self._btnSure = self:getBtn("btnSure")
end

function ShowDownEliminateRecuitView:onEnter()
	ShowDownEliminateRecuitView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = checknumber(param[1])
	self._teamId = checknumber(param[2])
	self._nextCanSendTimeStamp = self._nextCanSendTimeStamp or 0
	self._leftTime = Mathf.Max(checkint(self._nextCanSendTimeStamp - ServerTime.now()), 0)
	self._maxDelaySend = 10

	local inputRecuit = ShowDownController.instance:getShowDownMo(self._activityId):getInputRecuit()

	self:_onLeftValueChanged(inputRecuit.left)
	self:_onRightValueChanged(inputRecuit.right)
	self:_onRecordValueChanged(inputRecuit.owinCount)
	self:_onPetValueChanged(inputRecuit.ownRaceCount)
	GameUtil.SetGray(self._btnSure, self._leftTime > 0)

	if self._leftTime > 0 then
		settimer(1, self._ticking, self, true)
	end
end

function ShowDownEliminateRecuitView:onExit()
	ShowDownEliminateRecuitView.super.onExit(self)
	removetimer(self._ticking, self)
end

function ShowDownEliminateRecuitView:_onClickSure()
	if self._leftTime > 0 then
		FloatWordMgr.instance:show(string.format("请等待%d秒后再尝试", self._leftTime))

		return
	end

	local minLv = self._inputFieldOfMin:GetText()
	local maxLv = self._inputFieldOfMax:GetText()
	local winCount = self._recordInputField:GetText()
	local ownRaceCount = self._petInputField:GetText()
	local istrue = self:inputIsTrue(minLv, maxLv, winCount, ownRaceCount)

	if istrue then
		self._nextCanSendTimeStamp = ServerTime.now() + self._maxDelaySend

		settimer(1, self._ticking, self, true)
		GameUtil.SetGray(self._btnSure, true)
		ShowDownController.instance:sendPM_ShowDownTeam_SendEnlistMsgReq(self._activityId, self._teamId, minLv, maxLv, winCount, ownRaceCount)
		ShowDownController.instance:getShowDownMo(self._activityId):setInputRecuit(minLv, maxLv, winCount, ownRaceCount)
	else
		FloatWordMgr.instance:show("超出范围")
	end
end

function ShowDownEliminateRecuitView:_ticking()
	self._leftTime = Mathf.Max(checkint(self._nextCanSendTimeStamp - ServerTime.now()), 0)

	if self._leftTime <= 0 then
		removetimer(self._ticking, self)
		GameUtil.SetGray(self._btnSure, false)
	end
end

function ShowDownEliminateRecuitView:_onLeftValueChanged(numStr)
	local num = checkint(numStr)

	num = Mathf.Clamp(num, 1, 100)

	self._inputFieldOfMin:SetText(num)
end

function ShowDownEliminateRecuitView:_onRightValueChanged(numStr)
	local num = checkint(numStr)

	num = Mathf.Clamp(num, 1, 100)

	self._inputFieldOfMax:SetText(num)
end

function ShowDownEliminateRecuitView:_onRecordValueChanged(numStr)
	local num = checkint(numStr)

	num = Mathf.Clamp(num, 1, 70)

	self._recordInputField:SetText(num)
end

function ShowDownEliminateRecuitView:_onPetValueChanged(numStr)
	local num = checkint(numStr)
	local maxPetCount = ConstConfig.instance:getPetLimltCount()

	num = Mathf.Clamp(num, 1, maxPetCount)

	self._petInputField:SetText(num)
end

function ShowDownEliminateRecuitView:inputIsTrue(left, right, winCount, ownRaceCount)
	if checkint(left) < 1 then
		return false
	end

	if checkint(right) < 1 then
		return false
	end

	if checkint(right) < checkint(left) then
		return false
	end

	if checkint(winCount) < 1 then
		return false
	end

	if checkint(ownRaceCount) < 1 then
		return false
	end

	return true
end

return ShowDownEliminateRecuitView
