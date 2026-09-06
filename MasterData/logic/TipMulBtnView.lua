-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/TipMulBtnView.lua

module("logic.extensions.tips.view.TipMulBtnView", package.seeall)

local TipMulBtnView = class("TipMulBtnView", TipsViewBase)

function TipMulBtnView:ctor()
	TipMulBtnView.super.ctor(self)
end

function TipMulBtnView:bindEvents()
	TipMulBtnView.super.bindEvents(self)
end

function TipMulBtnView:unbindEvents()
	TipMulBtnView.super.unbindEvents(self)

	for i = 1, #self.buttons do
		self.buttons[i]:RemoveClickListener()
	end
end

function TipMulBtnView:buildUI()
	TipMulBtnView.super.buildUI(self)

	self._mulLines = self:getGo("mul"):GetComponent("UILayoutMulLines")
end

function TipMulBtnView:destroyUI()
	TipMulBtnView.super:destroyUI()
end

function TipMulBtnView:onEnter()
	TipMulBtnView.super.onEnter(self)

	self._popupConfig = self:getOpenParam()[1]
	self.buttons = {}

	local itemCnt = #self._popupConfig.buttons
	local transform = self._mulLines.transform
	local childCnt = transform.childCount

	while childCnt < itemCnt do
		childCnt = childCnt + 1

		UGUIToolHelper.AddChild(self._mulLines.gameObject, transform:GetChild(0).gameObject)
	end

	for i = 1, itemCnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local text = goutil.findChild(go, "Text"):GetComponent("Text")

		text.text = self._popupConfig.buttons[i]

		local button = Framework.ButtonAdapter.Get(go)

		table.insert(self.buttons, button)
		button:AddClickListener(function()
			self:_onSelectItemIdx(i)
			self:close()
		end, self)
	end

	for i = itemCnt + 1, childCnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._mulLines:Layout()

	self.mainGO.transform.localPosition = self._popupConfig.pos
end

function TipMulBtnView:_onSelectItemIdx(idx)
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

return TipMulBtnView
