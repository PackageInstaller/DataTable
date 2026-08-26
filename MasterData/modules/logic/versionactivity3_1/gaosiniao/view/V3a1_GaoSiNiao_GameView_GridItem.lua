-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/view/V3a1_GaoSiNiao_GameView_GridItem.lua

module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem", package.seeall)

local V3a1_GaoSiNiao_GameView_GridItem = class("V3a1_GaoSiNiao_GameView_GridItem", V3a1_GaoSiNiao_GameViewDragItemBase)

function V3a1_GaoSiNiao_GameView_GridItem:onInitView()
	self._goStartIcon = gohelper.findChild(self.viewGO, "#go_StartIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_GaoSiNiao_GameView_GridItem:addEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem:removeEvents()
	return
end

function V3a1_GaoSiNiao_GameView_GridItem:ctor(ctorParam)
	V3a1_GaoSiNiao_GameView_GridItem.super.ctor(self, ctorParam)

	self._mo = {}
end

function V3a1_GaoSiNiao_GameView_GridItem:addEventListeners()
	V3a1_GaoSiNiao_GameView_GridItem.super.addEventListeners(self)
end

function V3a1_GaoSiNiao_GameView_GridItem:removeEventListeners()
	V3a1_GaoSiNiao_GameView_GridItem.super.removeEventListeners(self)
end

function V3a1_GaoSiNiao_GameView_GridItem:onDestroyView()
	V3a1_GaoSiNiao_GameView_GridItem.super.onDestroyView(self)
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_Empty()
	local go = self.viewGO
	local item = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Empty)

	item:init(go)

	self._empty = item
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_Path()
	local go = gohelper.findChild(self.viewGO, "blood")
	local item = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Path)

	item:init(go)

	self._path = item
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_Wall()
	local go = gohelper.findChild(self.viewGO, "blood_qiang")
	local item = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Wall)

	item:init(go)

	self._wall = item
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_Start()
	local go = gohelper.findChild(self.viewGO, "blood_start")
	local item = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Start)

	item:init(go)

	self._start = item
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_End()
	local go = gohelper.findChild(self.viewGO, "blood_end")
	local item = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_End)

	item:init(go)

	self._end = item
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_Portal()
	local go = gohelper.findChild(self.viewGO, "blood_chuansongmen")
	local item = self:newObject(V3a1_GaoSiNiao_GameView_GridItem_Portal)

	item:init(go)

	self._portal = item
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView_Pieces()
	self:_editableInitView_Empty()
	self:_editableInitView_Path()
	self:_editableInitView_Wall()
	self:_editableInitView_Start()
	self:_editableInitView_End()
	self:_editableInitView_Portal()
end

function V3a1_GaoSiNiao_GameView_GridItem:_editableInitView()
	V3a1_GaoSiNiao_GameView_GridItem.super._editableInitView(self)
	self:_editableInitView_Pieces()

	self._goClickArea = gohelper.findChild(self.viewGO, "#go_ClickArea")
	self._goShadow = gohelper.findChild(self.viewGO, "#go_Shadow")
	self._vx_put = gohelper.findChild(self.viewGO, "vx_put")
	self._vx_finish = gohelper.findChild(self.viewGO, "vx_finish")
	self._vx_light = gohelper.findChild(self.viewGO, "vx_light")
	self._vx_putAnimator = self._vx_put:GetComponent(gohelper.Type_Animator)

	self:_setActive_goStartIcon(false)
	self:_setActive_goShadow(false)
	self:_setActive_vx_light(false)
	self:_setActive_vx_finish(false)
	self:_setActive_vx_put(false)
	self:initDragObj(self._goClickArea)
end

function V3a1_GaoSiNiao_GameView_GridItem:_isPortal()
	return self._mo:isPortal()
end

function V3a1_GaoSiNiao_GameView_GridItem:_isFixedPath()
	return self._mo:isFixedPath()
end

function V3a1_GaoSiNiao_GameView_GridItem:_isConnedStart()
	return self._mo:_isConnedStart()
end

function V3a1_GaoSiNiao_GameView_GridItem:_whoActivedPortalGrid()
	return self._mo:_whoActivedPortalGrid()
end

function V3a1_GaoSiNiao_GameView_GridItem:setData(mo)
	local last_eGridType = self:getType()

	V3a1_GaoSiNiao_GameView_GridItem.super.setData(self, mo)

	local eGridType = self:getType()

	if last_eGridType ~= eGridType then
		self:_switchType(eGridType)
	end

	self:_refreshSprite()
end

function V3a1_GaoSiNiao_GameView_GridItem:_switchType(eGridType)
	if self._impl then
		self._impl:setActive(false)
	end

	if eGridType == GaoSiNiaoEnum.GridType.Path then
		self._path:setIsFixedPath(true)
	else
		self._path:setIsFixedPath(false)
	end

	if eGridType == GaoSiNiaoEnum.GridType.Empty then
		self:asEmpty()
	elseif eGridType == GaoSiNiaoEnum.GridType.Wall then
		self:asWall()
	elseif eGridType == GaoSiNiaoEnum.GridType.Portal then
		self:asPortal()
	elseif eGridType == GaoSiNiaoEnum.GridType.End then
		self:asEnd()
	elseif eGridType == GaoSiNiaoEnum.GridType.Start then
		self:asStart()
	elseif eGridType == GaoSiNiaoEnum.GridType.Path then
		self:asFixedPath()
	else
		assert(false, "unsupported eGridType:" .. tostring(eGridType))
	end

	if self._impl then
		self._impl:setActive(true)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem:_hideOtherPiece()
	if self._impl ~= self._portal then
		self._portal:setActive(false)
	end

	if self._impl ~= self._start then
		self._start:setActive(false)
	end

	if self._impl ~= self._end then
		self._end:setActive(false)
	end

	if self._impl ~= self._wall then
		self._wall:setActive(false)
	end

	if self._impl ~= self._path then
		self._path:setActive(false)
	end

	if self._impl ~= self._empty then
		self._empty:setActive(false)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem:asEmpty()
	self._impl = self._empty

	self:_hideOtherPiece()
end

function V3a1_GaoSiNiao_GameView_GridItem:asWall()
	self._impl = self._wall

	self:_hideOtherPiece()
end

function V3a1_GaoSiNiao_GameView_GridItem:asPortal()
	self._impl = self._portal

	self:_hideOtherPiece()
end

function V3a1_GaoSiNiao_GameView_GridItem:asStart()
	self._impl = self._start

	self:_hideOtherPiece()
end

function V3a1_GaoSiNiao_GameView_GridItem:asEnd()
	self._impl = self._end

	self:_hideOtherPiece()
end

function V3a1_GaoSiNiao_GameView_GridItem:asFixedPath()
	self._impl = self._path

	self:_hideOtherPiece()
	self._path:selectPathType(self._mo.ePathType)
end

function V3a1_GaoSiNiao_GameView_GridItem:_refreshSprite()
	local bagItemObj = self:_placedBagItemObj()
	local isConnedStart = self:_isConnedStart()
	local isCompleted = self:isCompleted()
	local mo = self._mo
	local eGridType = mo.type
	local zRot = mo.zRot

	self:_setActive_goShadow(false)
	self:_setActive_goStartIcon(eGridType == GaoSiNiaoEnum.GridType.Start)

	local isConnedGrey = not isCompleted

	if isConnedStart then
		self._impl:setGray_Blood(isConnedGrey)
	else
		self._impl:hideBlood()
	end

	if self._impl ~= self._path then
		self._path:setActive(false)
		self._path:hideBlood()
	end

	if bagItemObj then
		local bagItemObjSprite, bagItemSpriteZRot = bagItemObj:getDraggingSpriteAndZRot()

		self._path:localRotateZ(bagItemSpriteZRot)
		self._path:selectPathType(bagItemObj:getType())
		self._path:setActive(true)

		if isConnedStart then
			self._path:setGray_Blood(isConnedGrey)
		end

		self:_setActive_goShadow(true)
	elseif self:_isPortal() then
		if isCompleted then
			if isConnedStart then
				self._portal:setIsConnectedNoAnim(isConnedStart)
				self._portal:setGray_Blood(isConnedGrey)
			end
		else
			self._portal:setIsConnected(isConnedStart)

			if isConnedStart then
				self:_rotateActivedPortal()
			else
				self._portal:resetRotate()
			end
		end
	elseif eGridType ~= GaoSiNiaoEnum.GridType.Path then
		self._impl:localRotateZ(zRot)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem:getType()
	return self._mo.type or GaoSiNiaoEnum.GridType.None
end

function V3a1_GaoSiNiao_GameView_GridItem:isSelectable()
	return self._mo:isEmpty() or self:isDraggable()
end

function V3a1_GaoSiNiao_GameView_GridItem:onSelect(isSelected)
	self._staticData.isSelected = isSelected

	self:onShowSelected(isSelected)
end

function V3a1_GaoSiNiao_GameView_GridItem:onShowSelected(isSelected)
	self:_setActive_vx_light(isSelected)
end

function V3a1_GaoSiNiao_GameView_GridItem:onCompleteGame()
	local isConnedStart = self:_isConnedStart()

	self:_setActive_vx_finish(isConnedStart)

	if isConnedStart then
		self._impl:setGray_Blood(false)
		self._path:setGray_Blood(false)
	end
end

function V3a1_GaoSiNiao_GameView_GridItem:onPushBagToGrid()
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_fang)
	self:_setActive_vx_put(true)
	self._vx_putAnimator:Play("gameview_put", -1, 0)
end

function V3a1_GaoSiNiao_GameView_GridItem:_onBeginDrag(dragObj)
	local p = self:parent()

	p:onBeginDrag_GridItemObj(self, dragObj)
end

function V3a1_GaoSiNiao_GameView_GridItem:_onDragging(dragObj)
	local p = self:parent()

	p:onDragging_GridItemObj(self, dragObj)
end

function V3a1_GaoSiNiao_GameView_GridItem:_onEndDrag(dragObj)
	local p = self:parent()

	p:onEndDrag_GridItemObj(self, dragObj)
end

function V3a1_GaoSiNiao_GameView_GridItem:_placedBagItemObj()
	return self:_dragContext():getPlacedBagItemObj(self)
end

function V3a1_GaoSiNiao_GameView_GridItem:_placedBagItemObjSprite()
	local bagItemObj = self:_placedBagItemObj()

	if bagItemObj then
		return bagItemObj:getDraggingSpriteAndZRot()
	end

	return nil
end

function V3a1_GaoSiNiao_GameView_GridItem:getDraggingSpriteAndZRot()
	local sprite, zRot = self:_placedBagItemObjSprite()

	return sprite or self._impl:getPieceSprite(), zRot or 0
end

function V3a1_GaoSiNiao_GameView_GridItem:isDraggable()
	local bagItemObj = self:_placedBagItemObj()

	if bagItemObj then
		return true
	end

	return self._mo.bMovable
end

function V3a1_GaoSiNiao_GameView_GridItem:_rotateActivedPortal()
	local whoGridItem = self:_whoActivedPortalGrid()
	local neighborGridList = whoGridItem:getNeighborWalkableGridList()
	local relativeZoneMask = GaoSiNiaoEnum.ZoneMask.None

	for i, gridItem in ipairs(neighborGridList) do
		if gridItem then
			if gridItem == self._mo then
				relativeZoneMask = GaoSiNiaoEnum.flipDir(GaoSiNiaoEnum.bitPos2Dir(i - 1))

				break
			end

			if gridItem:isPortal() then
				relativeZoneMask = GaoSiNiaoEnum.bitPos2Dir(i - 1)
			end
		end
	end

	self._portal:rotateByZoneMask(relativeZoneMask)
end

function V3a1_GaoSiNiao_GameView_GridItem:_setActive_goShadow(isActive)
	gohelper.setActive(self._goShadow, isActive)
end

function V3a1_GaoSiNiao_GameView_GridItem:_setActive_vx_light(isActive)
	gohelper.setActive(self._vx_light, isActive)
end

function V3a1_GaoSiNiao_GameView_GridItem:_setActive_vx_finish(isActive)
	gohelper.setActive(self._vx_finish, isActive)
end

function V3a1_GaoSiNiao_GameView_GridItem:_setActive_vx_put(isActive)
	gohelper.setActive(self._vx_put, isActive)
end

function V3a1_GaoSiNiao_GameView_GridItem:_setActive_goStartIcon(isActive)
	gohelper.setActive(self._goStartIcon, isActive)
end

return V3a1_GaoSiNiao_GameView_GridItem
