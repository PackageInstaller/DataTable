-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapSceneElements.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapSceneElements", package.seeall)

local VersionActivity1_5DungeonMapSceneElements = class("VersionActivity1_5DungeonMapSceneElements", BaseView)

function VersionActivity1_5DungeonMapSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapSceneElements:addEvents()
	return
end

function VersionActivity1_5DungeonMapSceneElements:removeEvents()
	return
end

function VersionActivity1_5DungeonMapSceneElements:_editableInitView()
	self._elementCompDict = {}
	self._elementCompPoolDict = {}
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self._click:AddClickDownListener(self.onClickDown, self)
	self._click:AddClickUpListener(self.onClickUp, self)

	self.goTimeParentTr = gohelper.findChildComponent(self.viewGO, "#go_maptime", typeof(UnityEngine.RectTransform))
	self.goTimeContainer = self.goTimeParentTr.gameObject
	self.goTimeItem = gohelper.findChild(self.viewGO, "#go_maptime/#go_timeitem")

	gohelper.setActive(self.goTimeItem, false)
	gohelper.setActive(self.goTimeContainer, true)

	self.hadEverySecondTask = false
	self.elementTimeItemDict = {}
	self.timeItemPool = {}
	self.tempPos = Vector3.New(0, 0, 0)

	self:customAddEvent()
end

function VersionActivity1_5DungeonMapSceneElements:onOpen()
	return
end

function VersionActivity1_5DungeonMapSceneElements:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_5DungeonMapSceneElements:onDestroyView()
	self:clearElements()
	self._click:RemoveClickDownListener()
	self._click:RemoveClickUpListener()
end

function VersionActivity1_5DungeonMapSceneElements:customAddEvent()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnBeginDragMap, self.onBeginDragMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, self.onCreateMapRootGoDone, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnAddElements, self.onAddElements, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self.onChangeMap, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
end

function VersionActivity1_5DungeonMapSceneElements:onGamepadKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
		local maxIndex = allRaycastHit.Length - 1

		for i = 0, maxIndex do
			local hitInfo = allRaycastHit[i]
			local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, VersionActivity1_5DungeonMapElement)

			if comp then
				comp:_onClickDown()

				return
			end
		end
	end
end

function VersionActivity1_5DungeonMapSceneElements:setMouseElementDown(elementComp)
	self.mouseDownElement = elementComp
end

function VersionActivity1_5DungeonMapSceneElements:onBeginDragMap()
	self._clickDown = false
end

function VersionActivity1_5DungeonMapSceneElements:onClickDown()
	self._clickDown = true
end

function VersionActivity1_5DungeonMapSceneElements:onClickUp()
	local element = self.mouseDownElement

	self.mouseDownElement = nil

	if not self._clickDown then
		return
	end

	if not element then
		return
	end

	local id = element:getElementId()

	if DungeonMapModel.instance:elementIsFinished(id) then
		return
	end

	if not element:isValid() then
		return
	end

	element:onClick()
end

function VersionActivity1_5DungeonMapSceneElements:onClickElement(elementComp)
	self:hideTimeContainer()
	self:hideAllElements()
end

function VersionActivity1_5DungeonMapSceneElements:onHideInteractUI()
	self:showTimeContainer()
	self:showAllElements()
end

function VersionActivity1_5DungeonMapSceneElements:onCreateMapRootGoDone(sceneRoot)
	if self.elementPoolRoot then
		return
	end

	self.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(sceneRoot, self.elementPoolRoot)
	gohelper.setActive(self.elementPoolRoot, false)
	transformhelper.setLocalPos(self.elementPoolRoot.transform, 0, 0, 0)
end

function VersionActivity1_5DungeonMapSceneElements:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._sceneGo = param.mapSceneGo
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)
end

function VersionActivity1_5DungeonMapSceneElements:onDisposeScene()
	self:clearElements()
end

function VersionActivity1_5DungeonMapSceneElements:onDisposeOldMap(viewName)
	self:recycleAllElements()

	self._elementRoot = nil
end

function VersionActivity1_5DungeonMapSceneElements:hideAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:hideElement()
	end
end

function VersionActivity1_5DungeonMapSceneElements:showAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:showElement()
	end
end

function VersionActivity1_5DungeonMapSceneElements:clearElements()
	if self._elementCompDict then
		for _, v in pairs(self._elementCompDict) do
			v:onDestroy()
		end
	end

	if self._elementCompPoolDict then
		for _, v in pairs(self._elementCompPoolDict) do
			v:onDestroy()
		end
	end

	self._elementRoot = nil

	tabletool.clear(self._elementCompDict)
	tabletool.clear(self._elementCompPoolDict)
end

function VersionActivity1_5DungeonMapSceneElements:recycleAllElements()
	if self._elementCompDict then
		for _, elementComp in pairs(self._elementCompDict) do
			self._elementCompPoolDict[elementComp:getElementId()] = elementComp

			gohelper.addChild(self.elementPoolRoot, elementComp._go)
		end

		tabletool.clear(self._elementCompDict)
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnRecycleAllElement)
end

function VersionActivity1_5DungeonMapSceneElements:showElements()
	if self.activityDungeonMo:isHardMode() then
		self:recycleAllElements()

		return
	end

	local normalElementCoList, shareElementCoList = VersionActivity1_5DungeonModel.instance:getElementCoList(self._mapCfg.id)

	for _, elementCo in ipairs(normalElementCoList) do
		self:_addElement(elementCo)
	end

	for _, elementCo in ipairs(shareElementCoList) do
		self:_addElement(elementCo)
	end
end

function VersionActivity1_5DungeonMapSceneElements:_addElement(elementConfig)
	if self._elementCompDict[elementConfig.id] then
		return
	end

	local elementComp = self._elementCompPoolDict[elementConfig.id]

	if elementComp then
		self._elementCompPoolDict[elementConfig.id] = nil

		gohelper.addChild(self._elementRoot, elementComp._go)
		elementComp:updatePos()
		elementComp:refreshDispatchRemainTime()
	else
		local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

		gohelper.addChild(self._elementRoot, go)

		elementComp = MonoHelper.addLuaComOnceToGo(go, VersionActivity1_5DungeonMapElement, {
			elementConfig,
			self
		})
	end

	self._elementCompDict[elementConfig.id] = elementComp

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnAddOneElement, elementComp)
end

function VersionActivity1_5DungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementCompDict[id]

	elementComp:setFinish()

	self._elementCompDict[id] = nil
	self._elementCompPoolDict[id] = elementComp

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnRemoveElement, elementComp)
end

function VersionActivity1_5DungeonMapSceneElements:_addElementById(id)
	local config = lua_chapter_map_element.configDict[id]

	self:_addElement(config)
end

function VersionActivity1_5DungeonMapSceneElements:onRemoveElement(id)
	if not self._showRewardView then
		self:_removeElement(id)
	else
		self._needRemoveElementId = id
	end
end

function VersionActivity1_5DungeonMapSceneElements:onAddElements(elements)
	for _, elementId in ipairs(elements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)

		if VersionActivity1_5DungeonConfig.instance:checkElementBelongMapId(elementCo, self._mapCfg.id) then
			self:_addElement(elementCo)
		end
	end
end

function VersionActivity1_5DungeonMapSceneElements:getElementComp(elementId)
	return self._elementCompDict[elementId]
end

function VersionActivity1_5DungeonMapSceneElements:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity1_5DungeonMapSceneElements:endShowRewardView()
	self._showRewardView = false

	if self._needRemoveElementId then
		self:_removeElement(self._needRemoveElementId)

		self._needRemoveElementId = nil
	end
end

function VersionActivity1_5DungeonMapSceneElements:addTimeItem(elementComp)
	local dispatchId = tonumber(elementComp:getConfig().param)
	local dispatchMo = VersionActivity1_5DungeonModel.instance:getDispatchMo(dispatchId)

	if not dispatchMo or dispatchMo:isFinish() then
		return
	end

	local timeItem = self:getTimeItem()

	timeItem.txttime.text = dispatchMo:getRemainTimeStr()
	timeItem.elementComp = elementComp
	timeItem.dispatchMo = dispatchMo

	gohelper.setActive(timeItem.go, true)

	self.elementTimeItemDict[dispatchId] = timeItem

	self:setElementTimePos(timeItem)

	if not self.hadEverySecondTask then
		TaskDispatcher.runRepeat(self.everySecondCall, self, 1)

		self.hadEverySecondTask = true
	end
end

function VersionActivity1_5DungeonMapSceneElements:addTimeItemByDispatchId(dispatchId)
	for _, elementComp in pairs(self._elementCompDict) do
		if elementComp:isDispatch() and tonumber(elementComp:getConfig().param) == dispatchId then
			self:addTimeItem(elementComp)

			return
		end
	end
end

function VersionActivity1_5DungeonMapSceneElements:getTimeItem()
	if #self.timeItemPool ~= 0 then
		return table.remove(self.timeItemPool)
	end

	local timeItem = self:getUserDataTb_()

	timeItem.go = gohelper.cloneInPlace(self.goTimeItem)
	timeItem.rectTr = timeItem.go:GetComponent(typeof(UnityEngine.RectTransform))
	timeItem.txttime = gohelper.findChildText(timeItem.go, "#txt_time")

	return timeItem
end

function VersionActivity1_5DungeonMapSceneElements:recycleTimeItem(timeItem)
	timeItem.elementComp = nil
	timeItem.dispatchMo = nil

	gohelper.setActive(timeItem.go, false)
	table.insert(self.timeItemPool, timeItem)
end

function VersionActivity1_5DungeonMapSceneElements:everySecondCall()
	local needDestroyIdList = {}

	for dispatchId, timeItem in pairs(self.elementTimeItemDict) do
		local dispatchMo = timeItem.dispatchMo

		if not dispatchMo or dispatchMo:isFinish() then
			table.insert(needDestroyIdList, dispatchId)
		else
			timeItem.txttime.text = dispatchMo:getRemainTimeStr()
		end
	end

	for _, dispatchId in ipairs(needDestroyIdList) do
		local timeItem = self.elementTimeItemDict[dispatchId]

		timeItem.elementComp:onDispatchFinish()
		self:recycleTimeItem(timeItem)

		self.elementTimeItemDict[dispatchId] = nil
	end

	if tabletool.len(self.elementTimeItemDict) == 0 then
		self.hadEverySecondTask = false

		TaskDispatcher.cancelTask(self.everySecondCall, self)
	end
end

function VersionActivity1_5DungeonMapSceneElements:setElementTimePos(timeItem)
	local anchorPos = recthelper.worldPosToAnchorPos(self:getElementPos(timeItem.elementComp:getElementPos()), self.goTimeParentTr)

	recthelper.setAnchor(timeItem.rectTr, anchorPos.x, anchorPos.y)
end

function VersionActivity1_5DungeonMapSceneElements:onMapPosChanged()
	self:refreshAllElementTimePos()
end

function VersionActivity1_5DungeonMapSceneElements:refreshAllElementTimePos()
	for _, timeItem in pairs(self.elementTimeItemDict) do
		self:setElementTimePos(timeItem)
	end
end

function VersionActivity1_5DungeonMapSceneElements:getElementPos(x, y, z)
	self.tempPos:Set(x, y + VersionActivity1_5DungeonEnum.ElementTimeOffsetY, z)

	return self.tempPos
end

function VersionActivity1_5DungeonMapSceneElements:onChangeMap()
	for _, timeItem in pairs(self.elementTimeItemDict) do
		self:recycleTimeItem(timeItem)
	end

	self.elementTimeItemDict = {}
	self.hadEverySecondTask = false

	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_5DungeonMapSceneElements:hideTimeContainer()
	gohelper.setActive(self.goTimeContainer, false)
end

function VersionActivity1_5DungeonMapSceneElements:showTimeContainer()
	gohelper.setActive(self.goTimeContainer, true)
	self:refreshAllElementTimePos()
end

function VersionActivity1_5DungeonMapSceneElements:onAddDispatchInfo(dispatchId)
	if self.elementTimeItemDict[dispatchId] then
		return
	end

	self:addTimeItemByDispatchId(dispatchId)
end

function VersionActivity1_5DungeonMapSceneElements:onRemoveDispatchInfo(dispatchId)
	if not self.elementTimeItemDict[dispatchId] then
		return
	end

	self:recycleTimeItem(self.elementTimeItemDict[dispatchId])

	self.elementTimeItemDict[dispatchId] = nil
end

return VersionActivity1_5DungeonMapSceneElements
