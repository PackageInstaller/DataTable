-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameActUnitItem.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameActUnitItem", package.seeall)

local WuErLiXiGameActUnitItem = class("WuErLiXiGameActUnitItem", LuaCompBase)

function WuErLiXiGameActUnitItem:init(go, dragGo)
	self.go = go
	self._goDrag = dragGo
	self._itemWidth = recthelper.getWidth(self.go.transform)
	self._imageicon = gohelper.findChildImage(go, "icon")
	self._gowall = gohelper.findChild(go, "icon_wall")
	self._imageiconbg = gohelper.findChildImage(go, "image_BG")
	self._txtcount = gohelper.findChildText(go, "txt_count")
	self._txtname = gohelper.findChildText(go, "#txt_Num")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._imageicon.gameObject)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)

	self._bgiconwidthoffset = recthelper.getWidth(self._imageiconbg.gameObject.transform) - recthelper.getWidth(self._imageicon.gameObject.transform)
end

function WuErLiXiGameActUnitItem:_onBeginDrag(unitTransform, pointerEventData)
	local count = WuErLiXiMapModel.instance:getLimitSelectUnitCount(self._mo)

	if count < 1 then
		return
	end

	gohelper.setActive(self._goDrag, false)
	self:_setDragItem()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
	self._goDrag.transform:SetParent(self.go.transform.parent.parent)

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	transformhelper.setLocalScale(self._goDrag.transform, 1, 1, 1)
end

function WuErLiXiGameActUnitItem:_setDragItem()
	self._imagedragicon = gohelper.findChildImage(self._goDrag, "icon")
	self._imagedragiconbg = gohelper.findChildImage(self._goDrag, "image_BG")
	self._txtdragname = gohelper.findChildText(self._goDrag, "#txt_Num")

	local spriteName = WuErLiXiHelper.getUnitSpriteName(self._mo.type, false)

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imagedragicon, spriteName)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imagedragiconbg, "v2a4_wuerlixi_node_icon2")

	self._txtdragname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(self._mo.id)

	TaskDispatcher.runDelay(self._setDragPos, self, 0.05)
end

function WuErLiXiGameActUnitItem:_setDragPos()
	gohelper.setActive(self._goDrag, true)
	self._imagedragicon:SetNativeSize()
	self._imagedragiconbg:SetNativeSize()

	local actUnitIconWidth = recthelper.getWidth(self._imagedragicon.gameObject.transform)

	if self._mo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if self._mo.dir == WuErLiXiEnum.Dir.Up or self._mo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(self._imagedragiconbg.gameObject.transform, actUnitIconWidth + self._bgiconwidthoffset)
			recthelper.setWidth(self._goDrag.transform, actUnitIconWidth + self._bgiconwidthoffset)
		else
			recthelper.setHeight(self._imagedragiconbg.gameObject.transform, actUnitIconWidth + self._bgiconwidthoffset)
			recthelper.setHeight(self._goDrag.transform, actUnitIconWidth + self._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(self._goDrag.transform, self._itemWidth)
		recthelper.setHeight(self._goDrag.transform, self._itemWidth)
	end

	transformhelper.setLocalRotation(self._imagedragicon.gameObject.transform, 0, 0, -90 * self._mo.dir)
end

function WuErLiXiGameActUnitItem:_onDrag(param, pointerEventData)
	local count = WuErLiXiMapModel.instance:getLimitSelectUnitCount(self._mo)

	if count < 1 then
		return
	end

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	WuErLiXiMapModel.instance:clearSelectUnit()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.UnitDraging, pos, self._mo, self._mo.type)
end

function WuErLiXiGameActUnitItem:_onEndDrag(equipTransform, pointerEventData)
	local count = WuErLiXiMapModel.instance:getLimitSelectUnitCount(self._mo)

	if count < 1 then
		return
	end

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	gohelper.setActive(self._goDrag, false)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.ActUnitDragEnd, pos, self._mo)
end

function WuErLiXiGameActUnitItem:setItem(mo)
	self._mo = mo

	gohelper.setActive(self.go, false)

	local spriteName = WuErLiXiHelper.getUnitSpriteName(self._mo.type, false)

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, spriteName)
	gohelper.setActive(self._gowall, self._mo.type == WuErLiXiEnum.UnitType.Obstacle)
	TaskDispatcher.runDelay(self.setPos, self, 0.05)

	local count = WuErLiXiMapModel.instance:getLimitSelectUnitCount(self._mo)

	self._txtcount.text = luaLang("multiple") .. tostring(count)
	self._txtname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(self._mo.id)
end

function WuErLiXiGameActUnitItem:setPos()
	gohelper.setActive(self.go, true)
	self._imageicon:SetNativeSize()
	self._imageiconbg:SetNativeSize()

	local actUnitIconWidth = recthelper.getWidth(self._imageicon.gameObject.transform)

	if self._mo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if self._mo.dir == WuErLiXiEnum.Dir.Up or self._mo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(self._imageiconbg.gameObject.transform, actUnitIconWidth + self._bgiconwidthoffset)
			recthelper.setWidth(self.go.transform, actUnitIconWidth + self._bgiconwidthoffset)
		else
			recthelper.setHeight(self._imageiconbg.gameObject.transform, actUnitIconWidth + self._bgiconwidthoffset)
			recthelper.setHeight(self.go.transform, actUnitIconWidth + self._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(self.go.transform, self._itemWidth)
		recthelper.setHeight(self.go.transform, self._itemWidth)
	end

	transformhelper.setLocalRotation(self._imageicon.gameObject.transform, 0, 0, -90 * self._mo.dir)
end

function WuErLiXiGameActUnitItem:resetItem()
	local count = WuErLiXiMapModel.instance:getLimitSelectUnitCount(self._mo)

	self._txtcount.text = luaLang("multiple") .. tostring(count)
end

function WuErLiXiGameActUnitItem:hide()
	gohelper.setActive(self.go, false)
end

function WuErLiXiGameActUnitItem:refreshCount()
	return
end

function WuErLiXiGameActUnitItem:destroy()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
end

return WuErLiXiGameActUnitItem
