-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineevolvepluspopupView.lua

module("logic.extensions.divineevolveplus.view.DivineevolvepluspopupView", package.seeall)

local DivineevolvepluspopupView = class("DivineevolvepluspopupView", FlyTweenBase)

function DivineevolvepluspopupView:buildUI()
	DivineevolvepluspopupView.super.buildUI(self)

	self._closeBtn = self:getBtn("Nego_Main/btnClose")
	self._txt = MaterialMgr.findGraphicText(self.mainGO, "Nego_Main/ScrollView/Viewport/Content")
	self._scrollviewImg = goutil.findChild(self.mainGO, "Nego_Main/ScrollView"):GetComponent("Image")
	self._scrollviewTr = goutil.findChild(self.mainGO, "Nego_Main/ScrollView").transform
	self._srWidth = GameUtil.getWidth(self._scrollviewTr)
	self._srHeight = GameUtil.getHeight(self._scrollviewTr)
	self._scroll = goutil.findChild(self.mainGO, "Nego_Main/ScrollView"):GetComponent("ScrollRect")
	self._titleTxt = goutil.findChild(self.mainGO, "Nego_Main/Txt_Title"):GetComponent("Text")
	self._btnSure = self:getBtn("Nego_Main/Btns/btnSure")
	self._btnCancel = self:getBtn("Nego_Main/Btns/btnCancel")
	self._btnSureGo = self:getGo("Nego_Main/Btns/btnSure")
	self._txtBtnSure = self:getTxt("Nego_Main/Btns/btnSure/Text")
end

function DivineevolvepluspopupView:bindEvents()
	DivineevolvepluspopupView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function DivineevolvepluspopupView:unbindEvents()
	DivineevolvepluspopupView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function DivineevolvepluspopupView:onEnter()
	DivineevolvepluspopupView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._txt.text = params[1]
	self._sureCallBack = params[2]

	local baseHeight = self._srHeight

	self._scrollviewTr.sizeDelta = Vector2.New(self._srWidth, baseHeight)

	local preferredHeight = self._txt.preferredHeight

	self._scrollviewImg.raycastTarget = baseHeight < preferredHeight
	self._txt.transform.sizeDelta = baseHeight < preferredHeight and Vector2.New(self._srWidth, preferredHeight) or Vector2.New(self._srWidth, baseHeight)

	GameUtil.setLocalPos(self._txt.gameObject, 0, 0, 0)

	self._scroll.verticalNormalizedPosition = 1

	local height = self._txt.preferredHeight

	if height > 40 then
		self._txt.alignment = UnityEngine.TextAnchor.MiddleLeft or UnityEngine.TextAnchor.MiddleCenter
	end

	self._countDownTime = 3

	settimer(1, self._tick, self, true)
	self:_updateTxtBtnSure()
end

function DivineevolvepluspopupView:onExit()
	DivineevolvepluspopupView.super.onExit(self)

	TipsFacade.popupWindowSource = nil

	removetimer(self._tick, self)
end

function DivineevolvepluspopupView:_onClickClose()
	self:close()
end

function DivineevolvepluspopupView:_onClickbtnSure()
	if self._countDownTime > 0 then
		FloatWordMgr.instance:show(string.format("请%ss后再试", self._countDownTime))

		return
	end

	if self._sureCallBack then
		self._sureCallBack()
	end

	self:close()
end

function DivineevolvepluspopupView:_onClickbtnCancel()
	self:close()
end

function DivineevolvepluspopupView:_updateTxtBtnSure()
	self._txtBtnSure.text = string.format("确认（%ss）", self._countDownTime)

	if self._countDownTime <= 0 then
		self._txtBtnSure.text = "确认"

		removetimer(self._tick, self)
	end

	local isGray = self._countDownTime > 0

	GameUtil.SetGray(self._btnSureGo, isGray)
end

function DivineevolvepluspopupView:_tick()
	self._countDownTime = self._countDownTime - 1

	self:_updateTxtBtnSure()
end

return DivineevolvepluspopupView
