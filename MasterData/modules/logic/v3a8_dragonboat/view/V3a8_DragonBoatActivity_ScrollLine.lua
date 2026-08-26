-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_ScrollLine.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_ScrollLine", package.seeall)

local V3a8_DragonBoatActivity_ScrollLine = class("V3a8_DragonBoatActivity_ScrollLine", RougeSimpleItemBase)

function V3a8_DragonBoatActivity_ScrollLine:onInitView()
	self._txtbule = gohelper.findChildText(self.viewGO, "#txt_bule")
	self._txtred = gohelper.findChildText(self.viewGO, "#txt_red")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8_DragonBoatActivity_ScrollLine:addEvents()
	return
end

function V3a8_DragonBoatActivity_ScrollLine:removeEvents()
	return
end

local csTweenHelper = ZProj.TweenHelper

function V3a8_DragonBoatActivity_ScrollLine:ctor(...)
	V3a8_DragonBoatActivity_ScrollLine.super.ctor(self, ...)
end

function V3a8_DragonBoatActivity_ScrollLine:onDestroyView()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")
	V3a8_DragonBoatActivity_ScrollLine.super.onDestroyView(self)
end

function V3a8_DragonBoatActivity_ScrollLine:_editableInitView()
	V3a8_DragonBoatActivity_ScrollLine.super._editableInitView(self)

	self._line_redGo = gohelper.findChild(self.viewGO, "line_red")
	self._line_redTrans = self._line_redGo.transform
	self._line_buleGo = gohelper.findChild(self.viewGO, "#line_bule")
	self._line_buleTrans = self._line_buleGo.transform
	self._maxWidth = recthelper.getWidth(self._line_redTrans)

	self:_setBluePercent01(0.5)
end

function V3a8_DragonBoatActivity_ScrollLine:bluePercent01()
	local c = self:baseViewContainer()

	return c:bluePercent01()
end

function V3a8_DragonBoatActivity_ScrollLine:setData(mo)
	V3a8_DragonBoatActivity_ScrollLine.super.setData(self, mo)
	self:setBluePercent01(self:bluePercent01(), false)
end

function V3a8_DragonBoatActivity_ScrollLine:refresh()
	self:setBluePercent01(self:bluePercent01(), true)
end

local kFmt = "%.0f%%"
local kDuration = 1

function V3a8_DragonBoatActivity_ScrollLine:setBluePercent01(bluePercent01, bTween)
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenId")

	if bTween then
		local fromBluePercent01 = self:_calcWidthToPercent01(recthelper.getWidth(self._line_buleTrans))

		self._tweenId = csTweenHelper.DOTweenFloat(fromBluePercent01, bluePercent01, kDuration, self._tweenUpdateCb, function()
			self:setBluePercent01(bluePercent01, false)
		end, self)
	else
		self:_setBluePercent01(bluePercent01)
	end
end

function V3a8_DragonBoatActivity_ScrollLine:_setBluePercent01(bluePercent01)
	bluePercent01 = GameUtil.saturate(bluePercent01)

	local blueWidth = self._maxWidth * bluePercent01

	recthelper.setWidth(self._line_buleTrans, blueWidth)

	local percent100 = bluePercent01 * 100

	self._txtbule.text = string.format(kFmt, percent100)
	self._txtred.text = string.format(kFmt, 100 - percent100)
end

function V3a8_DragonBoatActivity_ScrollLine:_tweenUpdateCb(bluePercent01)
	self:_setBluePercent01(bluePercent01)
end

function V3a8_DragonBoatActivity_ScrollLine:_calcWidthToPercent01(width)
	return width / self._maxWidth
end

return V3a8_DragonBoatActivity_ScrollLine
