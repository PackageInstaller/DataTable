-- chunkname: @modules/logic/explore/view/ExploreMapView.lua

module("modules.logic.explore.view.ExploreMapView", package.seeall)

local ExploreMapView = class("ExploreMapView", BaseView)
local minScaleValue = 0.5
local maxScaleValue = 1.5

function ExploreMapView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._mapContainer = gohelper.findChild(self.viewGO, "container/#go_map").transform
	self._mapScrollRect = gohelper.findChild(self.viewGO, "container")
	self._mapItem = gohelper.findChild(self.viewGO, "container/#go_map/mapitems/#go_mapitem")
	self._heroItem = gohelper.findChild(self.viewGO, "container/#go_map/#go_hero").transform
	self._txtmapname = gohelper.findChildTextMesh(self.viewGO, "top/#txt_mapname")
	self._txtmapnameen = gohelper.findChildTextMesh(self.viewGO, "top/#txt_mapname/#txt_mapnameen")
	self._slider = gohelper.findChildSlider(self.viewGO, "Right/#go_mapSlider")
	self._gocategory = gohelper.findChild(self.viewGO, "#scroll_category")
	self._gocategoryParent = gohelper.findChild(self.viewGO, "#scroll_category/Viewport/Content")
	self._gocategoryItem = gohelper.findChild(self.viewGO, "#scroll_category/Viewport/Content/#go_categoryitem")
	self._btnCategory = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_tushi")
	self._gocategoryon = gohelper.findChild(self.viewGO, "Left/#btn_tushi/icon_on")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreMapView:addEvents()
	self._btnclose1:AddClickListener(self.closeThis, self)
	self._btnclose2:AddClickListener(self.closeThis, self)
	self._btnCategory:AddClickListener(self.showHideCategory, self)
	self._slider:AddOnValueChanged(self.onSliderValueChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, self.applyRolePos, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, self.applyRolePos, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, self.onRoleNodeChange, self)
	ExploreController.instance:registerCallback(ExploreEvent.UnitOutlineChange, self.outlineChange, self)
end

function ExploreMapView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btnCategory:RemoveClickListener()
	self._slider:RemoveOnValueChanged()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, self.applyRolePos, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, self.applyRolePos, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, self.onRoleNodeChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitOutlineChange, self.outlineChange, self)
end

function ExploreMapView:_editableInitView()
	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._mapContainer.gameObject)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetScrollWheelCb(self.onMouseScrollWheelChange, self)

	if BootNativeUtil.isMobilePlayer() then
		TaskDispatcher.runRepeat(self._checkMultDrag, self, 0, -1)
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._mapContainer.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function ExploreMapView:showHideCategory()
	local isShow = not self._gocategory.activeSelf

	gohelper.setActive(self._gocategory, isShow)
	gohelper.setActive(self._gocategoryon, isShow)
end

function ExploreMapView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)
	gohelper.setActive(self._mapItem, false)

	local mapId = ExploreModel.instance:getMapId()

	if mapId then
		::label_6_0::

		local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)
		local episodeCo = mapCo and lua_episode.configDict[mapCo.episodeId]

		if episodeCo then
			self._txtmapname.text = episodeCo.name
			self._txtmapnameen.text = episodeCo.name_En
		end

		self._mapItems = {}
		self._containWidth = recthelper.getWidth(self._mapScrollRect.transform)
		self._containHeight = recthelper.getHeight(self._mapScrollRect.transform)
		self._itemWidth = recthelper.getWidth(self._mapItem.transform)
		self._itemHeight = recthelper.getHeight(self._mapItem.transform)

		local bound = ExploreMapModel.instance.mapBound

		self._mapWidth = (bound.y - bound.x + 1) * self._itemWidth
		self._mapHeight = (bound.w - bound.z + 1) * self._itemHeight

		recthelper.setWidth(self._mapContainer, self._mapWidth)
		recthelper.setHeight(self._mapContainer, self._mapHeight)

		self._hero = ExploreController.instance:getMap():getHero()

		local heroPos = self._hero:getPos()

		self._offsetX = bound.x
		self._offsetY = bound.z

		local posX = (heroPos.x - self._offsetX - 0.5) * self._itemWidth
		local posY = (heroPos.z - self._offsetY - 0.5) * self._itemHeight

		transformhelper.setLocalPosXY(self._heroItem, posX, posY)

		local containerX = posX + self._itemWidth / 2
		local containerY = posY + self._itemHeight / 2

		transformhelper.setLocalPosXY(self._mapContainer, -containerX, -containerY)

		self._scale = 1

		self._slider:SetValue((1 - minScaleValue) / (maxScaleValue - minScaleValue))
		self:calcBound()
		gohelper.setActive(self._gocategory, false)
		gohelper.setActive(self._gocategoryon, false)

		if mapCo then
			local signsId = string.splitToNumber(mapCo.signsId or "", "#")
			local datas = {}

			if signsId then
				for _, id in ipairs(signsId) do
					local co = lua_explore_signs.configDict[id]

					table.insert(datas, co)
				end
			end

			gohelper.CreateObjList(self, self.onCategoryItem, datas, self._gocategoryParent, self._gocategoryItem)
		end
	end
end

function ExploreMapView:onCategoryItem(obj, data, index)
	local nameTxt = gohelper.findChildTextMesh(obj, "#txt_name")
	local icon = gohelper.findChildImage(obj, "#txt_name/icon")

	nameTxt.text = data.desc

	UISpriteSetMgr.instance:setExploreSprite(icon, data.icon)
end

function ExploreMapView:onSliderValueChange()
	self:setScale(minScaleValue + (maxScaleValue - minScaleValue) * self._slider:GetValue(), true)
end

function ExploreMapView:_onDragBegin(param, pointerEventData)
	self.startDragPos = pointerEventData.position
end

function ExploreMapView:_onDragEnd(param, pointerEventData)
	self.startDragPos = nil
end

function ExploreMapView:_onDrag(param, pointerEventData)
	if not self.startDragPos then
		return
	end

	if UnityEngine.Input.touchCount >= 2 then
		return
	end

	local x, y = transformhelper.getLocalPos(self._mapContainer)
	local nowPos = pointerEventData.position

	x = x + nowPos.x - self.startDragPos.x
	y = y + nowPos.y - self.startDragPos.y
	self.startDragPos = nowPos

	transformhelper.setLocalPosXY(self._mapContainer, x, y)
	self:calcBound()
end

function ExploreMapView:_checkMultDrag()
	local touchCount = UnityEngine.Input.touchCount

	if touchCount ~= 2 then
		return
	end

	local touch1 = UnityEngine.Input.GetTouch(0)
	local touch1Position = touch1.position
	local touch1DeltaPosition = touch1.deltaPosition
	local touch2 = UnityEngine.Input.GetTouch(1)
	local touch2Position = touch2.position
	local touch2DeltaPosition = touch2.deltaPosition

	if (touch1.phase == TouchPhase.Moved or touch1.phase == TouchPhase.Stationary) and (touch2.phase == TouchPhase.Moved or touch2.phase == TouchPhase.Stationary) then
		local touch1OriginalPosition = touch1Position - touch1DeltaPosition
		local touch2OriginalPosition = touch2Position - touch2DeltaPosition

		if Vector2.Distance(touch1Position, touch2Position) < 5 or Vector2.Distance(touch1OriginalPosition, touch2OriginalPosition) < 5 then
			return
		end

		local originalDistance = Vector2.Distance(touch1OriginalPosition, touch2OriginalPosition)
		local distance = Vector2.Distance(touch1Position, touch2Position)
		local scale = distance - originalDistance

		scale = (0.005 * scale + 1) * self._scale

		self:setScale(scale)
	end
end

function ExploreMapView:onScaleHandler(isEnLarger)
	self.startDragPos = nil

	self:setScale(self._scale * (1 + (isEnLarger and 0.1 or -0.1)))
end

function ExploreMapView:onMouseScrollWheelChange(deltaData)
	self:setScale(self._scale * (1 + deltaData))
end

function ExploreMapView:setScale(scale, noSetSlider)
	scale = Mathf.Clamp(scale, minScaleValue, maxScaleValue)

	if scale == self._scale then
		return
	end

	if not noSetSlider then
		self._slider:SetValue((scale - minScaleValue) / (maxScaleValue - minScaleValue))
	end

	local x, y = transformhelper.getLocalPos(self._mapContainer)

	x = x / self._scale * scale
	y = y / self._scale * scale
	self._scale = scale

	transformhelper.setLocalScale(self._mapContainer, self._scale, self._scale, 1)
	transformhelper.setLocalPosXY(self._mapContainer, x, y)

	for _, v in pairs(self._mapItems) do
		v:setScale(1 / self._scale)
	end

	self:calcBound()
end

function ExploreMapView:applyRolePos()
	if not self._hero then
		return
	end

	local heroPos = self._hero:getPos()
	local posX = (heroPos.x - self._offsetX - 0.5) * self._itemWidth
	local posY = (heroPos.z - self._offsetY - 0.5) * self._itemHeight

	transformhelper.setLocalPosXY(self._heroItem, posX, posY)
end

function ExploreMapView:onRoleNodeChange()
	self._fromX = nil

	self:calcBound()
end

function ExploreMapView:onClose()
	TaskDispatcher.cancelTask(self._checkMultDrag, self)

	self._hero = nil
end

function ExploreMapView:calcBound()
	local x, y = transformhelper.getLocalPos(self._mapContainer)
	local fromX = math.floor((-x - self._containWidth / 2) / self._itemWidth / self._scale)
	local toX = math.ceil((-x + self._containWidth / 2) / self._itemWidth / self._scale)
	local fromY = math.floor((-y - self._containHeight / 2) / self._itemHeight / self._scale)
	local toY = math.ceil((-y + self._containHeight / 2) / self._itemHeight / self._scale)

	self:showMapItem(fromX + self._offsetX, fromY + self._offsetY, toX + self._offsetX, toY + self._offsetY)
end

function ExploreMapView:showMapItem(fromX, fromY, toX, toY)
	if self._fromX == fromX and self._fromY == fromY and self._toX == toX and self._toY == toY then
		return
	end

	self._fromX, self._fromY, self._toX, self._toY = fromX, fromY, toX, toY

	local dirtyNeighbor = {}

	for x = fromX, toX do
		for y = fromY, toY do
			local key = ExploreHelper.getKeyXY(x, y)

			if not self._mapItems[key] and (ExploreMapModel.instance:getNodeIsShow(key) or ExploreMapModel.instance:getNodeIsBound(key)) then
				local go = gohelper.cloneInPlace(self._mapItem)

				gohelper.setActive(go, true)

				local mo = {}
				local leftKey = ExploreHelper.getKeyXY(x - 1, y)
				local rightKey = ExploreHelper.getKeyXY(x + 1, y)
				local topKey = ExploreHelper.getKeyXY(x, y + 1)
				local bottomKey = ExploreHelper.getKeyXY(x, y - 1)

				mo.bound = ExploreMapModel.instance:getNodeBoundType(key)
				mo.left = not ExploreMapModel.instance:getNodeIsShow(leftKey) and not ExploreMapModel.instance:getNodeIsBound(leftKey)
				mo.right = not ExploreMapModel.instance:getNodeIsShow(rightKey) and not ExploreMapModel.instance:getNodeIsBound(rightKey)
				mo.top = not ExploreMapModel.instance:getNodeIsShow(topKey) and not ExploreMapModel.instance:getNodeIsBound(topKey)
				mo.bottom = not ExploreMapModel.instance:getNodeIsShow(bottomKey) and not ExploreMapModel.instance:getNodeIsBound(bottomKey)

				if mo.bound then
					mo.left = mo.left and (mo.bound == 7 or mo.bound == 8)
					mo.right = mo.right and (mo.bound == 7 or mo.bound == 8)
					mo.top = mo.top and (mo.bound == 5 or mo.bound == 6)
					mo.bottom = mo.bottom and (mo.bound == 5 or mo.bound == 6)
				end

				mo.posX, mo.posY = (x - self._offsetX) * self._itemWidth, (y - self._offsetY) * self._itemHeight
				mo.key = key
				self._mapItems[key] = MonoHelper.addNoUpdateLuaComOnceToGo(go, ExploreMapItem, mo)

				self._mapItems[key]:setScale(1 / self._scale)

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
			elseif self._mapItems[key] and self._mapItems[key]._mo.bound ~= ExploreMapModel.instance:getNodeBoundType(key) then
				local leftKey = ExploreHelper.getKeyXY(x - 1, y)
				local rightKey = ExploreHelper.getKeyXY(x + 1, y)
				local topKey = ExploreHelper.getKeyXY(x, y + 1)
				local bottomKey = ExploreHelper.getKeyXY(x, y - 1)
				local mo = self._mapItems[key]._mo

				mo.left = not ExploreMapModel.instance:getNodeIsShow(leftKey) and not ExploreMapModel.instance:getNodeIsBound(leftKey)
				mo.right = not ExploreMapModel.instance:getNodeIsShow(rightKey) and not ExploreMapModel.instance:getNodeIsBound(rightKey)
				mo.top = not ExploreMapModel.instance:getNodeIsShow(topKey) and not ExploreMapModel.instance:getNodeIsBound(topKey)
				mo.bottom = not ExploreMapModel.instance:getNodeIsShow(bottomKey) and not ExploreMapModel.instance:getNodeIsBound(bottomKey)
				mo.bound = ExploreMapModel.instance:getNodeBoundType(key)

				self._mapItems[key]:updateMo(mo)
			end
		end
	end

	for key in pairs(dirtyNeighbor) do
		self._mapItems[key]:updateMo(self._mapItems[key]._mo)
	end
end

function ExploreMapView:outlineChange(nodeKey)
	if self._mapItems[nodeKey] then
		self._mapItems[nodeKey]:updateOutLineIcon()
	end
end

function ExploreMapView:onDestroyView()
	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end

	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
end

return ExploreMapView
