-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupWindowView.lua

module("logic.extensions.tips.view.PopupWindowView", package.seeall)

local DefaultTogText = "今日不再提示"
local PopupWindowView = class("PopupWindowView", FlyTweenBase)

function PopupWindowView:buildUI()
	PopupWindowView.super.buildUI(self)

	self._closeBtn = self:getBtn("Nego_Main/Btn_Close")
	self._txt = MaterialMgr.findGraphicText(self.mainGO, "Nego_Main/ScrollView/Viewport/Content")
	self._scrollviewImg = goutil.findChild(self.mainGO, "Nego_Main/ScrollView"):GetComponent("Image")
	self._scrollviewTr = goutil.findChild(self.mainGO, "Nego_Main/ScrollView").transform
	self._srWidth = GameUtil.getWidth(self._scrollviewTr)
	self._srHeight = GameUtil.getHeight(self._scrollviewTr)
	self._scroll = goutil.findChild(self.mainGO, "Nego_Main/ScrollView"):GetComponent("ScrollRect")
	self._titleTxt = goutil.findChild(self.mainGO, "Nego_Main/Txt_Title"):GetComponent("Text")
	self._btns = {}
	self._btnTexts = {}
	self._validX = false
	self._defaultBtnTexts = {
		"确定",
		"取消",
		"跳过"
	}

	for i = 1, 3 do
		self._btns[i] = Framework.ButtonAdapter.GetFrom(self.mainGO, "Nego_Main/Btns/Btn" .. tostring(i))
		self._btnTexts[i] = goutil.findChild(self._btns[i].gameObject, "Text"):GetComponent("Text")
	end

	self._toggle = goutil.findChild(self.mainGO, "Nego_Main/Toggle"):GetComponent("Toggle")
	self._toggleTxt = goutil.findChild(self.mainGO, "Nego_Main/Toggle/Label"):GetComponent("Text")
	self._toggleFunc = nil
end

function PopupWindowView:destroyUI()
	PopupWindowView.super.destroyUI(self)

	self._closeBtn = nil
end

function PopupWindowView:onEnter()
	PopupWindowView.super.onEnter(self)

	local cfg = self._viewPresentor._openParam[1]

	self._titleTxt.text = cfg.title
	self._txt.text = cfg.text

	if not cfg.showTog then
		if not self._srHeight then
			local baseHeight = self._srHeight - 20

			self._scrollviewTr.sizeDelta = Vector2.New(self._srWidth, baseHeight)

			local preferredHeight = self._txt.preferredHeight

			self._scrollviewImg.raycastTarget = baseHeight < preferredHeight
			self._txt.transform.sizeDelta = baseHeight < preferredHeight and Vector2.New(self._srWidth, preferredHeight) or Vector2.New(self._srWidth, baseHeight)

			GameUtil.setLocalPos(self._txt.gameObject, 0, 0, 0)

			self._scroll.verticalNormalizedPosition = 1

			self._closeBtn.gameObject:SetActive(cfg.showX)

			self._funcs = {}
			self._validX = false
			self.onExitCallBack = cfg.onExitCallBack

			if cfg.params[1] and cfg.params[1][3] then
				self._validX = true
			end

			local arr = {
				0
			}

			arr = cfg.numBtn == 1 and {
				0
			} or cfg.numBtn == 2 and {
				216,
				-216
			} or {
				216,
				0,
				-216
			}

			local idx = 1

			for i = 1, 3 do
				self._btns[i]:AddClickListener(GameUtil.handler(self._onClickBtn, self, i))

				if i <= cfg.numBtn then
					self._btns[i].gameObject:SetActive(true)

					self._funcs[i] = cfg.params[i][1]
					self._btnTexts[i].text = cfg.params[i][2] or self._defaultBtnTexts[i]

					GameUtil.setAnchoredPos(self._btns[i].gameObject, arr[idx], 0)

					idx = idx + 1
				else
					self._btns[i].gameObject:SetActive(false)
				end
			end

			self._toggle.gameObject:SetActive(cfg.showTog)

			if cfg.showTog then
				self._toggle.isOn = false
				self._toggleFunc = cfg.params[cfg.numBtn + 1][1]
				self._toggleTxt.text = cfg.params[cfg.numBtn + 1][2] or DefaultTogText

				self:_setUIFlyTweenParam(cfg.params[cfg.numBtn + 2])
			else
				self:_setUIFlyTweenParam(cfg.params[cfg.numBtn + 1])
			end

			local height = self._txt.preferredHeight

			if cfg.alignment == nil then
				if height > 40 then
					self._txt.alignment = UnityEngine.TextAnchor.MiddleLeft or UnityEngine.TextAnchor.MiddleCenter
				end
			else
				self._txt.alignment = cfg.alignment
			end

			self._closeBtn:AddClickListener(self._onClickClose, self)
		end
	end
end

function PopupWindowView:onExit()
	PopupWindowView.super.onExit(self)

	TipsFacade.popupWindowSource = nil

	for i = 1, 3 do
		self._btns[i]:RemoveClickListener()
	end

	self._closeBtn:RemoveClickListener()

	local tem = self.onExitCallBack

	self.onExitCallBack = nil

	GameUtil.callBack(tem)
end

function PopupWindowView:_onClickClose()
	local function closeCallback()
		self:_closeCurView()
	end

	self:_doCloseCallback(closeCallback)
end

function PopupWindowView:_closeCurView()
	self:close()

	if self._toggle.isOn and self._toggleFunc then
		self._toggleFunc()

		self._toggleFunc = nil
	end

	if self._validX and self._funcs and self._funcs[1] then
		self._funcs[1]()
	end
end

function PopupWindowView:_onClickBtn(i)
	local function closeCallback()
		self:_onClickBtnCloseView(i)
	end

	self:_doCloseCallback(closeCallback)
end

function PopupWindowView:_onClickBtnCloseView(i)
	self:close()
	GameUtil.callBack(self._funcs[i])

	if self._toggle.isOn then
		GameUtil.callBack(self._toggleFunc)

		self._toggleFunc = nil
	end
end

return PopupWindowView
