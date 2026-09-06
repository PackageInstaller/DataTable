-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTracePopupView.lua

module("logic.extensions.sourcetrace.view.SourceTracePopupView", package.seeall)

local SourceTracePopupView = class("SourceTracePopupView", FlyTweenBase)
local STATE_PREVIEW = "preview"
local STATE_CONFIRM = "confirm"
local CONFIRM_COUNTDOWN = 3
local OPEN_RUSH_SECONDS = 600

function SourceTracePopupView:buildUI()
	SourceTracePopupView.super.buildUI(self)

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
	self._leftTimeGo = self:getGo("Nego_Main/leftTime")
	self._txtLeftTime = self:getTxt("Nego_Main/leftTime/txt")
end

function SourceTracePopupView:bindEvents()
	SourceTracePopupView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function SourceTracePopupView:unbindEvents()
	SourceTracePopupView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function SourceTracePopupView:onEnter()
	SourceTracePopupView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._txt.text = params[1]
	self._sureCallBack = params[2]
	self._previewEndTime = checknumber(params[3])
	self._cfg = params[6]

	local openedInPreview = params[4] == true
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

	if openedInPreview and self:_getPreviewLeftTime() > 0 then
		self:_enterPreviewState()
	else
		self:_enterConfirmState(self:_getConfirmCountdown())
	end
end

function SourceTracePopupView:onExit()
	SourceTracePopupView.super.onExit(self)

	TipsFacade.popupWindowSource = nil

	self:_stopTicking()
end

function SourceTracePopupView:_stopTicking()
	removetimer(self._tick, self)
end

function SourceTracePopupView:_getPreviewLeftTime()
	if self._previewEndTime <= 0 then
		return 0
	end

	return math.max(0, self._previewEndTime - PreciseServerTime.nowMs() / 1000)
end

function SourceTracePopupView:_getConfirmCountdown()
	if self._previewEndTime > 0 and PreciseServerTime.nowMs() / 1000 < self._previewEndTime + OPEN_RUSH_SECONDS then
		return 0
	end

	return CONFIRM_COUNTDOWN
end

function SourceTracePopupView:_enterPreviewState()
	self:_stopTicking()

	self._state = STATE_PREVIEW

	goutil.setActive(self._leftTimeGo, true)

	self._txtBtnSure.text = "确认"

	GameUtil.SetGray(self._btnSureGo, true)
	self:_refreshPreviewText()
	settimer(1, self._tick, self, true)
end

function SourceTracePopupView:_enterConfirmState(countDown)
	self:_stopTicking()

	self._state = STATE_CONFIRM

	goutil.setActive(self._leftTimeGo, false)

	self._countDownTime = countDown or 0

	self:_refreshConfirmText()

	if self._countDownTime > 0 then
		settimer(1, self._tick, self, true)
	end
end

function SourceTracePopupView:_refreshPreviewText()
	local leftTime = math.max(1, math.ceil(self:_getPreviewLeftTime()))

	self._txtLeftTime.text = GameUtil.FormatTimeWords(leftTime)
end

function SourceTracePopupView:_refreshConfirmText()
	if self._countDownTime > 0 then
		self._txtBtnSure.text = string.format("确认（%ss）", self._countDownTime)

		GameUtil.SetGray(self._btnSureGo, true)
	else
		self._txtBtnSure.text = "确认"

		GameUtil.SetGray(self._btnSureGo, false)
		self:_stopTicking()
	end
end

function SourceTracePopupView:_tick()
	if self._state == STATE_PREVIEW then
		if self:_getPreviewLeftTime() <= 0 then
			self:_enterConfirmState(0)

			return
		end

		self:_refreshPreviewText()
	else
		self._countDownTime = self._countDownTime - 1

		self:_refreshConfirmText()
	end
end

function SourceTracePopupView:_onClickClose()
	self:close()
end

function SourceTracePopupView:_onClickbtnSure()
	if self._state == STATE_PREVIEW then
		FloatWordMgr.instance:show(string.format("距离进化开启还有%s", GameUtil.FormatTimeWords(math.max(1, math.ceil(self:_getPreviewLeftTime())))))

		return
	end

	if self._countDownTime and self._countDownTime > 0 then
		FloatWordMgr.instance:show(string.format("请%ss后再试", self._countDownTime))

		return
	end

	if self:_getPreviewLeftTime() > 0 then
		FloatWordMgr.instance:show("突破尚未开启")

		return
	end

	if self._sureCallBack then
		self._sureCallBack()
	end

	self:close()
end

function SourceTracePopupView:_onClickbtnCancel()
	self:close()
end

return SourceTracePopupView
