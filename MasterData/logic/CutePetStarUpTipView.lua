-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetStarUpTipView.lua

module("logic.extensions.cutepet.view.CutePetStarUpTipView", package.seeall)

local CutePetStarUpTipView = class("CutePetStarUpTipView", ViewComponent)

function CutePetStarUpTipView:ctor()
	CutePetStarUpTipView.super.ctor(self)
end

function CutePetStarUpTipView:buildUI()
	CutePetStarUpTipView.super.buildUI(self)

	self._btnToggle = self:getGo("Nego_Main/btnToggle")
	self._Checkmark = self:getGo("Nego_Main/btnToggle/Background/Checkmark")
	self._btnClose = self:getGo("Nego_Main/Btn_Close")
	self._btnCancel = self:getGo("Nego_Main/Btns/Btn2")
	self._btnSure = self:getGo("Nego_Main/Btns/Btn1")
	self._txtLabel = self:getTxt("Nego_Main/btnToggle/Label")
	self._txtContent = self:getTxt("Nego_Main/ScrollView/Viewport/Content")
	self._txtSure = self:getTxt("Nego_Main/Btns/Btn1/Text")
end

function CutePetStarUpTipView:bindEvents()
	CutePetStarUpTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickBtnToggle, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function CutePetStarUpTipView:unbindEvents()
	CutePetStarUpTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnToggle)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function CutePetStarUpTipView:onExit()
	CutePetStarUpTipView.super.onExit(self)
	removetimer(self._onTimeCountDown, self)
end

function CutePetStarUpTipView:destroyUI()
	CutePetStarUpTipView.super.destroyUI(self)
end

function CutePetStarUpTipView:onEnter()
	CutePetStarUpTipView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._tipText = params[1]
	self._sureFunc = params[2]
	self._toggleText = params[3]
	self._toggleKey = params[4]
	self._setTimeNum = checknumber(params[5])
	self._isToggleOn = false
	self._canSure = false
	self._txtLabel.text = self._toggleText
	self._txtContent.text = self._tipText

	if self._setTimeNum > 0 then
		self:_onTimeCountDown()
		settimer(1, self._onTimeCountDown, self, true)
	end

	GameUtil.SetActive(self._Checkmark, self._isToggleOn)
end

function CutePetStarUpTipView:_onClickBtnToggle()
	self._isToggleOn = not self._isToggleOn

	GameUtil.SetActive(self._Checkmark, self._isToggleOn)
end

function CutePetStarUpTipView:_onClickBtnSure()
	if not self._canSure then
		FloatWordMgr.instance:show(string.format("%d秒后可一键放入", self._setTimeNum))

		return
	end

	if self._isToggleOn then
		GameUtil.saveUserDayData(self._toggleKey, 1)
	end

	GameUtil.callBack(self._sureFunc)
	self:close()
end

function CutePetStarUpTipView:_onTimeCountDown()
	if self._setTimeNum > 0 then
		GameUtil.SetGray(self._btnSure, true)

		self._txtSure.text = string.format("确认(%ds)", self._setTimeNum)
	else
		GameUtil.SetGray(self._btnSure, false)

		self._canSure = true

		removetimer(self._onTimeCountDown, self)

		self._txtSure.text = "确认"
	end

	self._setTimeNum = self._setTimeNum - 1
end

return CutePetStarUpTipView
