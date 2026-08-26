-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueAttributeDescItem.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueAttributeDescItem", package.seeall)

local LiangYueAttributeDescItem = class("LiangYueAttributeDescItem")

function LiangYueAttributeDescItem:init(go)
	self.go = go
	self._txt_Num = gohelper.findChildText(go, "#txt_Num")
	self._txt_NumChanged = gohelper.findChildText(go, "#txt_Num1")
end

function LiangYueAttributeDescItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function LiangYueAttributeDescItem:setInfo(type, num)
	local text = string.format("%s%s", LiangYueEnum.CalculateSymbol[type], num)

	self._txt_Num.text = text

	if self._txt_NumChanged then
		self._txt_NumChanged.text = text
	end
end

function LiangYueAttributeDescItem:setTargetInfo(current, target, color)
	local text = string.format("%s/%s", current, target)

	self._txt_Num.text = text

	if self._txt_NumChanged then
		self._txt_NumChanged.text = text
	end

	self:setTxtColor(color)
end

function LiangYueAttributeDescItem:setTxtColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._txt_Num, color)

	if self._txt_NumChanged then
		SLFramework.UGUI.GuiHelper.SetColor(self._txt_NumChanged, color)
	end
end

return LiangYueAttributeDescItem
