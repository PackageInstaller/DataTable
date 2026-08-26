-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_BagItem.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_BagItem", package.seeall)

local V3a1_GaoSiNiao_GameView_BagItem = class("V3a1_GaoSiNiao_GameView_BagItem", V3a1_GaoSiNiao_GameViewDragItemBase)

function V3a1_GaoSiNiao_GameView_BagItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_BagItem:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_BagItem:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_BagItem:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_BagItem.super.ctor(self, ctorParam)

	self._mo = {}
end

function V3a1_GaoSiNiao_GameView_BagItem:addEventListeners()
	V3a1_GaoSiNiao_GameView_BagItem.super.addEventListeners(self)
end

function V3a1_GaoSiNiao_GameView_BagItem:removeEventListeners()
	V3a1_GaoSiNiao_GameView_BagItem.super.removeEventListeners(self)
end

function V3a1_GaoSiNiao_GameView_BagItem:onDestroyView()
	V3a1_GaoSiNiao_GameView_BagItem.super.onDestroyView(self)
end

function V3a1_GaoSiNiao_GameView_BagItem:_editableInitView()
	V3a1_GaoSiNiao_GameView_BagItem.super._editableInitView(self)
	self:initDragObj(self.viewGO)

	self._gocontent = gohelper.findChild(self.viewGO, "go_content")
	self._imageIcon = gohelper.findChildImage(self._gocontent, "image_icon")
	self._imageIconTran = self._imageIcon.transform
	self._txtNum = gohelper.findChildText(self._gocontent, "image_NumBG/txt_Num")
end

function V3a1_GaoSiNiao_GameView_BagItem:_setSprite(spriteName)
	local c = self:baseViewContainer()

	c:setSprite(self._imageIcon, spriteName)
end

function V3a1_GaoSiNiao_GameView_BagItem:setData(mo)
	V3a1_GaoSiNiao_GameView_BagItem.super.setData(self, mo)

	local count = mo.count

	self:_refreshSprite()
	self:setCount(count)
end

function V3a1_GaoSiNiao_GameView_BagItem:_refreshSprite()
	local pathSpriteName, _, zRot = self:getSpriteNamesAndZRot()

	self:_setSprite(pathSpriteName)
	self:localRotateZ(zRot, self._imageIconTran)
end

function V3a1_GaoSiNiao_GameView_BagItem:getSpriteNamesAndZRot()
	local ePathType = self._mo.type
	local pathInfo = GaoSiNiaoEnum.PathInfo[ePathType]
	local spriteId = pathInfo.spriteId
	local zRot = pathInfo.zRot
	local s1 = GaoSiNiaoConfig.instance:getPathSpriteName(spriteId)
	local s2 = GaoSiNiaoConfig.instance:getBloodSpriteName(spriteId)

	return s1, s2, zRot
end

function V3a1_GaoSiNiao_GameView_BagItem:setCount(count)
	self._mo.count = count

	self:setShowCount(count)
end

function V3a1_GaoSiNiao_GameView_BagItem:setShowCount(count)
	local hexColor = count <= 0 and "#DA9390" or "#E3E3E3"

	self._txtNum.text = gohelper.getRichColorText(count, hexColor)
end

function V3a1_GaoSiNiao_GameView_BagItem:getCount()
	return self._mo.count or 0
end

function V3a1_GaoSiNiao_GameView_BagItem:getType()
	return self._mo.type or GaoSiNiaoEnum.PathType.None
end

function V3a1_GaoSiNiao_GameView_BagItem:in_ZoneMask()
	return self._mo:in_ZoneMask()
end

function V3a1_GaoSiNiao_GameView_BagItem:out_ZoneMask()
	return self._mo:out_ZoneMask()
end

function V3a1_GaoSiNiao_GameView_BagItem:_onBeginDrag(dragObj)
	local p = self:parent()

	p:onBeginDrag_BagItemObj(self, dragObj)
end

function V3a1_GaoSiNiao_GameView_BagItem:_onDragging(dragObj)
	local p = self:parent()

	p:onDragging_BagItemObj(self, dragObj)
end

function V3a1_GaoSiNiao_GameView_BagItem:_onEndDrag(dragObj)
	local p = self:parent()

	p:onEndDrag_BagItemObj(self, dragObj)
end

function V3a1_GaoSiNiao_GameView_BagItem:getDraggingSpriteAndZRot()
	local _, _, zRot = transformhelper.getLocalRotation(self._imageIconTran)

	return self._imageIcon.sprite, zRot
end

function V3a1_GaoSiNiao_GameView_BagItem:isDraggable()
	if self:getCount() <= 0 then
		return false
	end

	return true
end

return V3a1_GaoSiNiao_GameView_BagItem
