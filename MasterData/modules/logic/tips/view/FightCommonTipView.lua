-- chunkname: @modules/logic/tips/view/FightCommonTipView.lua

module("modules.logic.tips.view.FightCommonTipView", package.seeall)

local FightCommonTipView = class("FightCommonTipView", BaseView)

function FightCommonTipView:onInitView()
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.viewWidth = recthelper.getWidth(self.viewRect)
	self.viewHeight = recthelper.getHeight(self.viewRect)
	self.rootRect = gohelper.findChildComponent(self.viewGO, "layout", gohelper.Type_RectTransform)
	self._txttitle = gohelper.findChildText(self.viewGO, "layout/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "layout/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCommonTipView:addEvents()
	return
end

function FightCommonTipView:removeEvents()
	return
end

function FightCommonTipView:_editableInitView()
	self.blockGraphic = gohelper.findChildComponent(self.viewGO, "close_block", gohelper.Type_Graphic)
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "close_block")

	self.click:AddClickListener(self.closeThis, self)
end

function FightCommonTipView:onUpdateParam()
	self:refreshUI()
end

function FightCommonTipView:onOpen()
	self:refreshUI()
end

function FightCommonTipView:refreshUI()
	self._txttitle.text = self.viewParam.title
	self._txtdesc.text = self.viewParam.desc

	local srcWidth = recthelper.getWidth(self.rootRect)

	self.rootRect.pivot = self.viewParam.pivot
	self.rootRect.anchorMin = self.viewParam.anchorMinAndMax
	self.rootRect.anchorMax = self.viewParam.anchorMinAndMax
	self.offsetPosX = self.viewParam.offsetPosX
	self.offsetPosY = self.viewParam.offsetPosY

	recthelper.setWidth(self.rootRect, srcWidth)
	self:setPos()
	self:checkIgnoreClick()
end

function FightCommonTipView:setPos()
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(self.viewParam.screenPos, self.viewRect)
	local anchorMinAndMax = self.viewParam.anchorMinAndMax

	if anchorMinAndMax == FightCommonTipController.Pivot.TopLeft then
		anchorX = anchorX + self.viewWidth * 0.5
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.TopCenter then
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.TopRight then
		anchorX = anchorX - self.viewWidth * 0.5
		anchorY = anchorY - self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.CenterLeft then
		anchorX = anchorX + self.viewWidth * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.Center then
		-- block empty
	elseif anchorMinAndMax == FightCommonTipController.Pivot.CenterRight then
		anchorX = anchorX - self.viewWidth * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.BottomLeft then
		anchorX = anchorX + self.viewWidth * 0.5
		anchorY = anchorY + self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.BottomCenter then
		anchorY = anchorY + self.viewHeight * 0.5
	elseif anchorMinAndMax == FightCommonTipController.Pivot.BottomRight then
		anchorX = anchorX - self.viewWidth * 0.5
		anchorY = anchorY + self.viewHeight * 0.5
	end

	anchorX = anchorX + self.offsetPosX
	anchorY = anchorY + self.offsetPosY

	recthelper.setAnchor(self.rootRect, anchorX, anchorY)
end

function FightCommonTipView:checkIgnoreClick()
	self.blockGraphic.raycastTarget = not self.viewParam.ignoreClick
end

function FightCommonTipView:onDestroyView()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end
end

return FightCommonTipView
