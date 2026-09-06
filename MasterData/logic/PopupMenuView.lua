-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupMenuView.lua

module("logic.extensions.tips.view.PopupMenuView", package.seeall)

local PopupMenuView = class("PopupMenuView", TipsViewBase)

function PopupMenuView:buildUI()
	PopupMenuView.super.buildUI(self)

	self._rectTrans = self.mainGO.transform
	self._layout = self:getGo("items"):GetComponent("UILayoutSingleLine")
	self._close = self:getBtn("Close")
	self._adjustPosition = self.mainGO:GetComponent("UIAdjustPosition")
	self._itemPrefab = self._layout.transform:GetChild(0).gameObject
end

function PopupMenuView:destroyUI()
	PopupMenuView.super.destroyUI(self)

	self._adjustPosition = nil
	self._layout = nil
	self._close = nil
	self._popupConfig = nil
	self._itemPrefab = nil
end

function PopupMenuView:onEnter()
	PopupMenuView.super.onEnter(self)
	self:_setupPopupConfig()
	self._close:AddClickListener(self._onClickClose, self)
end

function PopupMenuView:_setupPopupConfig()
	self._popupConfig = self._viewPresentor._openParam[1]

	self._close.gameObject:SetActive(self._popupConfig.showClose)
	self:_layoutItems()

	if not self._popupConfig.pos then
		self._adjustPosition:AdjustScreenPosition()
	end
end

function PopupMenuView:_layoutItems()
	local itemCnt = #self._popupConfig.displayOpts
	local transform = self._layout.transform
	local childCnt = transform.childCount

	while childCnt < itemCnt do
		childCnt = childCnt + 1

		UGUIToolHelper.AddChild(self._layout.gameObject, self._itemPrefab)
	end

	local maxWidth = 0

	for i = 1, itemCnt do
		maxWidth = self:_fillItem(i, go, maxWidth, self._popupConfig.displayOpts[i], itemCnt)
	end

	for i = itemCnt + 1, childCnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._layout:Layout()
	self:_doAligned(itemCnt, maxWidth)
	self:_resizeBg(maxWidth, itemCnt)
end

function PopupMenuView:_fillItem(idx, go, maxWidth, displayOpts, itemCnt)
	local transform = self._layout.transform
	local go = transform:GetChild(idx - 1).gameObject

	go:SetActive(true)

	local line = goutil.findChild(go, "Image")
	local text = goutil.findChild(go, "Text"):GetComponent("Text")
	local button = Framework.ButtonAdapter.GetFrom(text.gameObject, "Button")

	text.text = displayOpts

	local preferredWidth = text.preferredWidth

	if maxWidth < preferredWidth then
		maxWidth = preferredWidth
	end

	go.gameObject.name = string.format("item_popup_%d", idx)

	line:SetActive(true)
	button:AddClickListener(function()
		self:_onSelectItemIdx(idx)
	end, self)

	return maxWidth
end

function PopupMenuView:_doAligned(itemCnt, width)
	local scale

	self:_aligned(itemCnt, width, (not self._popupConfig.align or self._popupConfig.align == 0) and 0 or self._popupConfig.align == 1 and 0.5 or 1)
end

function PopupMenuView:_aligned(itemCnt, width, scale)
	local transform = self._layout.transform

	for i = 1, itemCnt do
		local go = transform:GetChild(i - 1).gameObject
		local text = goutil.findChild(go, "Text"):GetComponent("Text")
		local preferredWidth = text.preferredWidth
		local rect = text.transform
		local pos = rect.localPosition

		pos.x = (width - preferredWidth) * scale
		rect.localPosition = pos

		local line = goutil.findChild(go, "Image")
		local lineRect = line.transform
		local sizeDelta = lineRect.sizeDelta

		sizeDelta.x = width + 40
		lineRect.sizeDelta = sizeDelta

		local button = goutil.findChild(go, "Text/Button")
		local sizeDelta = button.transform.sizeDelta

		sizeDelta.x = width
		button.transform.sizeDelta = sizeDelta
	end
end

function PopupMenuView:_resizeBg(width, itemCnt)
	local sizeDelta = self._rectTrans.sizeDelta

	sizeDelta.x = width + 60
	sizeDelta.y = itemCnt * self._layout.verticalSpace + 54
	self._rectTrans.sizeDelta = sizeDelta
end

function PopupMenuView:onExit()
	PopupMenuView.super.onExit(self)
	self._close:RemoveClickListener()

	self._popupConfig = nil

	self:_clearItemListeners()
end

function PopupMenuView:_clearItemListeners()
	local transform = self._layout.transform
	local childCnt = transform.childCount

	for i = 1, childCnt do
		local go = transform:GetChild(i - 1).gameObject
		local button = Framework.ButtonAdapter.GetFrom(go, "Text/Button")

		button:RemoveClickListener()
	end
end

function PopupMenuView:_onClickClose()
	if self._popupConfig.onCloseHandler then
		if self._popupConfig.handlerTarget then
			self._popupConfig.onCloseHandler(self._popupConfig.handlerTarget)
		else
			self._popupConfig.onCloseHandler()
		end
	end

	self:close()
end

function PopupMenuView:_onSelectItemIdx(idx)
	if self._popupConfig.onSelectIndex then
		if self._popupConfig.handlerTarget then
			self._popupConfig.onSelectIndex(self._popupConfig.handlerTarget, idx)
		else
			self._popupConfig.onSelectIndex(idx)
		end
	end

	if self._popupConfig.closeInSelect then
		self:close()
	end
end

function PopupMenuView:_onCustomInputCallback(hover)
	if self._popupConfig.closeOnClickOutside and not hover and self:_isOnTop() then
		self:_onClickClose()
	end
end

return PopupMenuView
