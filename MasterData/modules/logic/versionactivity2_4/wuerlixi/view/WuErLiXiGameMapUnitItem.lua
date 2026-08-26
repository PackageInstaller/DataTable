-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameMapUnitItem.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapUnitItem", package.seeall)

local WuErLiXiGameMapUnitItem = class("WuErLiXiGameMapUnitItem", LuaCompBase)

function WuErLiXiGameMapUnitItem:init(go, dragGO)
	self.go = go
	self._itemCanvas = gohelper.onceAddComponent(self.go, typeof(UnityEngine.CanvasGroup))
	self._anim = self.go:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self.go, false)

	self._itemWidth = recthelper.getWidth(self.go.transform)
	self._goDrag = dragGO
	self._nodeItem = {}
	self._imageicon = gohelper.findChildImage(go, "icon")
	self._goiconwallidle = gohelper.findChild(go, "icon_wallidle")
	self._goiconwallact = gohelper.findChild(go, "icon_wallact")
	self._goiconendactived = gohelper.findChild(go, "icon_endactived")
	self._imageiconlock = gohelper.findChildImage(go, "icon_lockframe")
	self._txtname = gohelper.findChildText(go, "#txt_Num")
	self._goput = gohelper.findChild(go, "#go_Put")
	self._click = gohelper.getClick(self._imageicon.gameObject)

	self._click:AddClickListener(self._onNodeClick, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._imageicon.gameObject)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)

	self._bgiconwidthoffset = recthelper.getWidth(self._imageiconlock.gameObject.transform) - recthelper.getWidth(self._imageicon.gameObject.transform)
end

function WuErLiXiGameMapUnitItem:_onNodeClick()
	if self._unitMo and self._nodeMo and self._nodeMo.initUnit == 0 then
		WuErLiXiMapModel.instance:setCurSelectUnit(self._nodeMo.x, self._nodeMo.y)

		local dir = (self._unitMo.dir + 1) % 4
		local couldSetDir = WuErLiXiMapModel.instance:isSetDirEnable(self._unitMo.unitType, dir, self._nodeMo.x, self._nodeMo.y)

		if couldSetDir then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_revolve)
			WuErLiXiMapModel.instance:setUnitDir(self._nodeMo, dir, self._unitMo.dir)
		end

		WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeClicked)
	end
end

function WuErLiXiGameMapUnitItem:_onBeginDrag(unitTransform, pointerEventData)
	if not self._nodeMo then
		return
	end

	if not self._nodeMo.unit then
		return
	end

	if self._nodeMo.initUnit > 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
	gohelper.setActive(self._goDrag, false)
	self:_setDragItem()
	self._goDrag.transform:SetParent(self.go.transform.parent.parent)

	local pos = pointerEventData.position

	WuErLiXiMapModel.instance:clearSelectUnit()

	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	transformhelper.setLocalScale(self._goDrag.transform, 1, 1, 1)

	self._itemCanvas.alpha = 0
end

function WuErLiXiGameMapUnitItem:_setDragItem()
	self._imagedragicon = gohelper.findChildImage(self._goDrag, "icon")
	self._imagedragiconbg = gohelper.findChildImage(self._goDrag, "image_BG")
	self._txtdragname = gohelper.findChildText(self._goDrag, "#txt_Num")

	local spriteName = WuErLiXiHelper.getUnitSpriteName(self._unitMo.unitType, false)

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imagedragicon, spriteName)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imagedragiconbg, "v2a4_wuerlixi_node_icon2")

	self._txtdragname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(self._unitMo.id)

	TaskDispatcher.runDelay(self._setDragPos, self, 0.05)
end

function WuErLiXiGameMapUnitItem:_setDragPos()
	gohelper.setActive(self._goDrag, true)
	self._imagedragicon:SetNativeSize()
	self._imagedragiconbg:SetNativeSize()

	local actUnitIconWidth = recthelper.getWidth(self._imagedragicon.gameObject.transform)

	if self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if self._unitMo.dir == WuErLiXiEnum.Dir.Up or self._unitMo.dir == WuErLiXiEnum.Dir.Down then
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

	transformhelper.setLocalRotation(self._imagedragicon.gameObject.transform, 0, 0, -90 * self._unitMo.dir)
end

function WuErLiXiGameMapUnitItem:_onDrag(param, pointerEventData)
	if not self._nodeMo then
		return
	end

	if not self._nodeMo.unit then
		return
	end

	if self._nodeMo.initUnit > 0 then
		return
	end

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.UnitDraging, pos, self._nodeMo, self._unitMo.unitType)
end

function WuErLiXiGameMapUnitItem:_onEndDrag(equipTransform, pointerEventData)
	if not self._nodeMo then
		return
	end

	if not self._nodeMo.unit then
		return
	end

	if self._nodeMo.initUnit > 0 then
		return
	end

	local pos = pointerEventData.position
	local anchorPos = recthelper.screenPosToAnchorPos(pos, self._goDrag.transform.parent)

	recthelper.setAnchor(self._goDrag.transform, anchorPos.x, anchorPos.y)
	gohelper.setActive(self._goDrag, false)

	self._itemCanvas.alpha = 1

	TaskDispatcher.cancelTask(self._setDragPos, self)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitDragEnd, pos, self._unitMo)
end

function WuErLiXiGameMapUnitItem:setItem(mo, nodeItem)
	if not nodeItem then
		logError("请检查配置，并将元件设置在已有的节点上！")

		return
	end

	self._unitMo = mo
	self._nodeMo = nodeItem:getNodeMo()
	self._nodeItem = nodeItem
	self.go.name = self._nodeMo.x .. "_" .. self._nodeMo.y

	local spriteName = WuErLiXiHelper.getUnitSpriteName(self._unitMo.unitType, self._nodeMo:isNodeShowActive())

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, spriteName)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageiconlock, "v2a4_wuerlixi_unit_icon7_1")
	gohelper.setActive(self._imageiconlock.gameObject, self._unitMo.unitType == WuErLiXiEnum.UnitType.Switch)
	gohelper.setActive(self._goiconwallact, self._unitMo.unitType == WuErLiXiEnum.UnitType.Obstacle and self._nodeMo.initUnit == 0)
	gohelper.setActive(self._goiconwallidle, self._unitMo.unitType == WuErLiXiEnum.UnitType.Obstacle and self._nodeMo.initUnit ~= 0)

	local unitActive = self._unitMo:isUnitActive()

	gohelper.setActive(self._imageicon.gameObject, self._unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not unitActive)
	gohelper.setActive(self._goiconendactived, unitActive and self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd)

	if unitActive and not self._lastActive then
		if self._unitMo.unitType == WuErLiXiEnum.UnitType.Switch then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			self._anim:Play("active", 0, 0)
		elseif self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			self._anim:Play("active", 0, 0)
		elseif self._unitMo.unitType == WuErLiXiEnum.UnitType.Key then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			self._anim:Play("active", 0, 0)
		elseif self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			self._anim:Play("active", 0, 0)
		else
			self._anim:Play("idle", 0, 0)
		end
	else
		self._anim:Play("idle", 0, 0)
	end

	self._lastActive = unitActive
	self._txtname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(self._unitMo.id)

	TaskDispatcher.runDelay(self.setPos, self, 0.05)
end

function WuErLiXiGameMapUnitItem:setPos()
	self._nodeItem = self._nodeItem

	gohelper.setActive(self.go, true)
	self._imageicon:SetNativeSize()

	self.go.transform.position = self._nodeItem.go.transform.position

	transformhelper.setLocalRotation(self._imageicon.gameObject.transform, 0, 0, -90 * self._unitMo.dir)
end

function WuErLiXiGameMapUnitItem:hide()
	gohelper.setActive(self.go, false)
end

function WuErLiXiGameMapUnitItem:showPut(show)
	if self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if self._unitMo.dir == WuErLiXiEnum.Dir.Up or self._unitMo.dir == WuErLiXiEnum.Dir.Down then
			transformhelper.setLocalScale(self._goput.transform, 3, 1, 1)
		else
			transformhelper.setLocalScale(self._goput.transform, 1, 3, 1)
		end
	else
		transformhelper.setLocalScale(self._goput.transform, 1, 1, 1)
	end

	gohelper.setActive(self._goput, show)
end

function WuErLiXiGameMapUnitItem:destroy()
	if self.go then
		gohelper.destroy(self.go)

		self.go = nil
	end

	TaskDispatcher.cancelTask(self.setPos, self)
	self._click:RemoveClickListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
end

return WuErLiXiGameMapUnitItem
