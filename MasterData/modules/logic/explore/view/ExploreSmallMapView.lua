-- chunkname: @modules/logic/explore/view/ExploreSmallMapView.lua

module("modules.logic.explore.view.ExploreSmallMapView", package.seeall)

local ExploreSmallMapView = class("ExploreSmallMapView", BaseView)

function ExploreSmallMapView:onInitView()
	self._btnsmallmap = gohelper.findChildButtonWithAudio(self.viewGO, "topright/minimap/#btn_smallmap")
	self._keytips = gohelper.findChild(self._btnsmallmap.gameObject, "#go_pcbtn1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreSmallMapView:addEvents()
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, self.applyRolePos, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, self.applyRolePos, self)
	ExploreController.instance:registerCallback(ExploreEvent.AreaShow, self._areaShowChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.UnitOutlineChange, self.outlineChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.MapRotate, self.applyRolePos, self)
	self._btnsmallmap:AddClickListener(self._openSmallMap, self)
end

function ExploreSmallMapView:removeEvents()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, self.applyRolePos, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, self.applyRolePos, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.AreaShow, self._areaShowChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitOutlineChange, self.outlineChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.MapRotate, self.applyRolePos, self)
	self._btnsmallmap:RemoveClickListener()
end

function ExploreSmallMapView:_editableInitView()
	self._mapItems = {}
	self._mapItemsNoUse = {}

	local maskTr = gohelper.findChild(self.viewGO, "topright/minimap/mask").transform

	self._maskHalfWidth = recthelper.getWidth(maskTr) / 2
	self._maskHalfHeight = recthelper.getHeight(maskTr) / 2
	self._container = gohelper.findChild(self.viewGO, "topright/minimap/mask/container").transform
	self._mapItem = gohelper.findChild(self.viewGO, "topright/minimap/mask/container/#go_mapitem")
	self._itemWidth = recthelper.getWidth(self._mapItem.transform)
	self._itemHeight = recthelper.getHeight(self._mapItem.transform)

	local bound = ExploreMapModel.instance.mapBound

	self._offsetX = bound.x
	self._offsetY = bound.z
	self._mapWidth = (bound.y - bound.x + 1) * self._itemWidth
	self._mapHeight = (bound.w - bound.z + 1) * self._itemHeight

	recthelper.setWidth(self._container, self._mapWidth)
	recthelper.setHeight(self._container, self._mapHeight)
	self:applyRolePos()
	self:showKeyTips()
end

function ExploreSmallMapView:_openSmallMap()
	ViewMgr.instance:openView(ViewName.ExploreMapView)
end

function ExploreSmallMapView:outlineChange(nodeKey)
	if self._mapItems[nodeKey] then
		self._mapItems[nodeKey]:updateOutLineIcon()
	end
end

function ExploreSmallMapView:_areaShowChange()
	self._fromX = nil

	self:applyRolePos()
end

function ExploreSmallMapView:applyRolePos(pos)
	if not pos then
		self._hero = self._hero or ExploreController.instance:getMap():getHero()

		if not self._hero then
			return
		end

		pos = self._hero:getPos()
	end

	local offsetX = -self._offsetX
	local offsetZ = -self._offsetY
	local rotate = ExploreMapModel.instance.nowMapRotate
	local realX = -(offsetX + pos.x) * self._itemWidth
	local realY = -(offsetZ + pos.z) * self._itemWidth
	local fromX = math.floor((-realX - self._maskHalfWidth) / self._itemWidth)
	local toX = math.ceil((-realX + self._maskHalfWidth) / self._itemWidth)
	local fromY = math.floor((-realY - self._maskHalfHeight) / self._itemHeight)
	local toY = math.ceil((-realY + self._maskHalfHeight) / self._itemHeight)

	if rotate ~= 0 then
		local preX = realX

		realX = realY * math.sin(-rotate * Mathf.Deg2Rad) + realX * math.cos(-rotate * Mathf.Deg2Rad)
		realY = realY * math.cos(-rotate * Mathf.Deg2Rad) + preX * math.sin(rotate * Mathf.Deg2Rad)
	end

	transformhelper.setLocalPosXY(self._container, realX, realY)
	transformhelper.setLocalRotation(self._container, 0, 0, rotate)
	self:showMapItem(fromX + self._offsetX, fromY + self._offsetY, toX + self._offsetX, toY + self._offsetY)
end

function ExploreSmallMapView:showMapItem(fromX, fromY, toX, toY)
	if self._fromX == fromX and self._fromY == fromY and self._toX == toX and self._toY == toY then
		for _, v in pairs(self._mapItems) do
			v:updateRotate()
		end

		return
	end

	self._fromX, self._fromY, self._toX, self._toY = fromX, fromY, toX, toY

	for _, v in pairs(self._mapItems) do
		v:markUse(false)
	end

	local addListMos = {}
	local dirtyNeighbor = {}

	for x = fromX, toX do
		for y = fromY, toY do
			local key = ExploreHelper.getKeyXY(x, y)

			if ExploreMapModel.instance:getNodeIsShow(key) then
				if self._mapItems[key] then
					self._mapItems[key]:markUse(true)

					self._mapItems[key]._mo.rotate = true

					self._mapItems[key]:updateRotate()
				else
					local mo = {}
					local leftKey = ExploreHelper.getKeyXY(x - 1, y)
					local rightKey = ExploreHelper.getKeyXY(x + 1, y)
					local topKey = ExploreHelper.getKeyXY(x, y + 1)
					local bottomKey = ExploreHelper.getKeyXY(x, y - 1)

					mo.left = not ExploreMapModel.instance:getNodeIsShow(leftKey)
					mo.right = not ExploreMapModel.instance:getNodeIsShow(rightKey)
					mo.top = not ExploreMapModel.instance:getNodeIsShow(topKey)
					mo.bottom = not ExploreMapModel.instance:getNodeIsShow(bottomKey)
					mo.key = key
					mo.posX, mo.posY = (x - self._offsetX) * self._itemWidth, (y - self._offsetY) * self._itemHeight
					mo.rotate = true
					addListMos[key] = mo

					if self._mapItems[leftKey] then
						self._mapItems[leftKey]._mo.right = false
						dirtyNeighbor[leftKey] = true
					end

					if self._mapItems[rightKey] then
						self._mapItems[rightKey]._mo.left = false
						dirtyNeighbor[rightKey] = true
					end

					if self._mapItems[topKey] then
						self._mapItems[topKey]._mo.bottom = false
						dirtyNeighbor[topKey] = true
					end

					if self._mapItems[bottomKey] then
						self._mapItems[bottomKey]._mo.top = false
						dirtyNeighbor[bottomKey] = true
					end
				end
			end
		end
	end

	for k, v in pairs(self._mapItems) do
		if not v:getIsUse() then
			table.insert(self._mapItemsNoUse, v)

			self._mapItems[k] = nil
			dirtyNeighbor[k] = nil
		end
	end

	local len = #self._mapItemsNoUse

	for key, mo in pairs(addListMos) do
		if len > 0 then
			self._mapItems[key] = self._mapItemsNoUse[len]
			self._mapItemsNoUse[len] = nil
			len = len - 1

			self._mapItems[key]:markUse()
			self._mapItems[key]:updateMo(mo)
			self._mapItems[key]:updateRotate()
		else
			local go = gohelper.cloneInPlace(self._mapItem)

			gohelper.setActive(go, true)

			self._mapItems[key] = MonoHelper.addNoUpdateLuaComOnceToGo(go, ExploreMapItem, mo)
		end
	end

	for key in pairs(dirtyNeighbor) do
		self._mapItems[key]:updateMo(self._mapItems[key]._mo)
		self._mapItems[key]:updateRotate()
	end

	for i = 1, len do
		self._mapItemsNoUse[i]:setActive(false)
	end
end

function ExploreSmallMapView:showKeyTips()
	PCInputController.instance:showkeyTips(self._keytips, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.map)
end

return ExploreSmallMapView
