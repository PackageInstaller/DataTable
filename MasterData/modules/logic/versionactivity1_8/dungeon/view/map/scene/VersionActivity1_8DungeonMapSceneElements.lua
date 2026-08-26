-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/scene/VersionActivity1_8DungeonMapSceneElements.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapSceneElements", package.seeall)

local VersionActivity1_8DungeonMapSceneElements = class("VersionActivity1_8DungeonMapSceneElements", BaseView)
local FOCUS_TIME = 0.5
local WAIT_TIME = 0.5

function VersionActivity1_8DungeonMapSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self.goTimeParentTr = gohelper.findChildComponent(self.viewGO, "#go_maptime", typeof(UnityEngine.RectTransform))
	self.goTimeContainer = self.goTimeParentTr.gameObject
	self.goTimeItem = gohelper.findChild(self.viewGO, "#go_maptime/#go_timeitem")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DungeonMapSceneElements:addEvents()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnBeginDragMap, self.onBeginDragMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, self.onCreateMapRootGoDone, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.GuideClickElement, self.manualClickElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, self._updateElementArrow, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self.onChangeMap, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.onChangeInProgressMissionGroup, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self._onRepairComponent, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.addEventCb(self, DispatchController.instance, DispatchEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
	self._click:AddClickUpListener(self.onClickUp, self)
	self._click:AddClickDownListener(self.onClickDown, self)
end

function VersionActivity1_8DungeonMapSceneElements:removeEvents()
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnBeginDragMap, self.onBeginDragMap, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, self.onCreateMapRootGoDone, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.GuideClickElement, self.manualClickElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, self._updateElementArrow, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self.showElements, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, self.onDisposeScene, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self.onChangeMap, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, self.onChangeInProgressMissionGroup, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self._onRepairComponent, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.AddDispatchInfo, self.onAddDispatchInfo, self)
	self.removeEventCb(self, DispatchController.instance, DispatchEvent.RemoveDispatchInfo, self.onRemoveDispatchInfo, self)
	self._click:RemoveClickUpListener()
	self._click:RemoveClickDownListener()
end

function VersionActivity1_8DungeonMapSceneElements:onGamepadKeyDown(key)
	if key ~= GamepadEnum.KeyCode.A then
		return
	end

	local screenPos = GamepadController.instance:getScreenPos()
	local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(screenPos)
	local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
	local maxIndex = allRaycastHit.Length - 1

	for i = 0, maxIndex do
		local hitInfo = allRaycastHit[i]
		local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, VersionActivity1_8DungeonMapElement)

		if comp then
			comp:_onClickDown()
		end
	end
end

function VersionActivity1_8DungeonMapSceneElements:onBeginDragMap()
	self._clickDown = false
end

function VersionActivity1_8DungeonMapSceneElements:onCreateMapRootGoDone(sceneRoot)
	if self.elementPoolRoot then
		return
	end

	self.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(sceneRoot, self.elementPoolRoot)
	gohelper.setActive(self.elementPoolRoot, false)
	transformhelper.setLocalPos(self.elementPoolRoot.transform, 0, 0, 0)
end

function VersionActivity1_8DungeonMapSceneElements:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity1_8DungeonMapSceneElements:endShowRewardView()
	self._showRewardView = false

	if self._needRemoveElementId then
		self:_removeElement(self._needRemoveElementId)
		TaskDispatcher.runDelay(self.showNewElements, self, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		self._needRemoveElementId = nil
	else
		self:showNewElements()
	end
end

function VersionActivity1_8DungeonMapSceneElements:showNewElements()
	local newElements = DungeonMapModel.instance:getNewElements()

	if not newElements then
		return
	end

	local animElements = {}

	for _, elementId in ipairs(newElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local isBelongCurMap = VersionActivity1_8DungeonConfig.instance:checkElementBelongMapId(elementCo, self._mapCfg.id)

		if isBelongCurMap and elementCo.showCamera == 1 then
			animElements[#animElements + 1] = elementId
		end
	end

	if #animElements <= 0 then
		return
	end

	self:_showElementAnim(animElements)
	DungeonMapModel.instance:clearNewElements()
end

function VersionActivity1_8DungeonMapSceneElements:onRemoveElement(id)
	if not self._showRewardView then
		self:_removeElement(id)
		self:showNewElements()
	else
		self._needRemoveElementId = id
	end

	local arrowItem = self._arrowList[id]

	if arrowItem then
		arrowItem.arrowClick:RemoveClickListener()

		self._arrowList[id] = nil

		gohelper.destroy(arrowItem.go)
	end
end

function VersionActivity1_8DungeonMapSceneElements:manualClickElement(id)
	local mapElement = self:getElementComp(tonumber(id))

	if not mapElement then
		return
	end

	if not mapElement:isValid() then
		return
	end

	mapElement:onClick()
end

function VersionActivity1_8DungeonMapSceneElements:_updateElementArrow()
	for _, v in pairs(self._elementCompDict) do
		self:_updateArrow(v)
	end
end

function VersionActivity1_8DungeonMapSceneElements:showElements()
	if self.activityDungeonMo:isHardMode() then
		self:recycleAllElements()

		return
	end

	local animElements = {}
	local normalElements = {}
	local newElements = DungeonMapModel.instance:getNewElements()
	local notShowNewElement = VersionActivity1_8DungeonModel.instance:isNotShowNewElement()
	local elementCoList = VersionActivity1_8DungeonModel.instance:getElementCoList(self._mapCfg.id)

	for _, elementCo in ipairs(elementCoList) do
		local isNew = newElements and tabletool.indexOf(newElements, elementCo.id)

		if isNew and elementCo.showCamera == 1 then
			if not notShowNewElement then
				table.insert(animElements, elementCo.id)
			end
		else
			table.insert(normalElements, elementCo)
		end
	end

	self:_showElementAnim(animElements, normalElements)

	if notShowNewElement then
		VersionActivity1_8DungeonModel.instance:setIsNotShowNewElement(false)
	else
		DungeonMapModel.instance:clearNewElements()
	end

	if self._initClickElementId then
		self:manualClickElement(self._initClickElementId)

		self._initClickElementId = nil
	end
end

function VersionActivity1_8DungeonMapSceneElements:_showElementAnim(animElements, normalElements)
	if not animElements or #animElements <= 0 then
		VersionActivity1_8DungeonMapSceneElements._addAnimElementDone({
			self,
			normalElements
		})

		return
	end

	self:_stopShowSequence()

	self._showSequence = FlowSequence.New()

	self._showSequence:addWork(TimerWork.New(WAIT_TIME))
	table.sort(animElements)

	for _, id in ipairs(animElements) do
		self._showSequence:addWork(FunctionWork.New(VersionActivity1_8DungeonMapSceneElements._doFocusElement, {
			self,
			id
		}))
		self._showSequence:addWork(TimerWork.New(FOCUS_TIME))
		self._showSequence:addWork(FunctionWork.New(VersionActivity1_8DungeonMapSceneElements._doAddElement, {
			self,
			id
		}))
		self._showSequence:addWork(TimerWork.New(WAIT_TIME))
	end

	self._showSequence:addWork(FunctionWork.New(VersionActivity1_8DungeonMapSceneElements._addAnimElementDone, {
		self,
		normalElements
	}))
	self._showSequence:registerDoneListener(self._stopShowSequence, self)
	self._showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.FocusNewElement)
end

function VersionActivity1_8DungeonMapSceneElements._doFocusElement(params)
	local elementId = params[2]

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, elementId, true)
end

function VersionActivity1_8DungeonMapSceneElements._doAddElement(params)
	local self, elementId = params[1], params[2]

	self:_addElementById(elementId)

	local comp = self._elementCompDict[elementId]

	if not comp then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function VersionActivity1_8DungeonMapSceneElements._addAnimElementDone(params)
	local self = params[1]
	local normalElements = params[2]

	if not normalElements or #normalElements <= 0 then
		return
	end

	for _, v in ipairs(normalElements) do
		self:_addElement(v)
	end
end

function VersionActivity1_8DungeonMapSceneElements:_stopShowSequence()
	if self._showSequence then
		self._showSequence:unregisterDoneListener(self._stopShowSequence, self)
		self._showSequence:destroy()

		self._showSequence = nil

		UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.FocusNewElement)
	end
end

function VersionActivity1_8DungeonMapSceneElements:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._sceneGo = param.mapSceneGo
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)
end

function VersionActivity1_8DungeonMapSceneElements:onDisposeOldMap(viewName)
	self:recycleAllElements()

	self._elementRoot = nil

	for _, v in pairs(self._arrowList) do
		v.arrowClick:RemoveClickListener()
		gohelper.destroy(v.go)
	end

	self._arrowList = self:getUserDataTb_()

	self:_stopShowSequence()

	self._needRemoveElementId = nil
	self._waitCloseFactoryView = false
end

function VersionActivity1_8DungeonMapSceneElements:onDisposeScene()
	self:clearElements()
	self:_stopShowSequence()

	self._needRemoveElementId = nil
	self._waitCloseFactoryView = false
end

function VersionActivity1_8DungeonMapSceneElements:onChangeMap()
	for _, timeItem in pairs(self.elementTimeItemDict) do
		self:recycleTimeItem(timeItem)
	end

	self.elementTimeItemDict = {}
	self.hadEverySecondTask = false

	TaskDispatcher.cancelTask(self.everySecondCall, self)
	self:_stopShowSequence()

	self._needRemoveElementId = nil
	self._waitCloseFactoryView = false
end

function VersionActivity1_8DungeonMapSceneElements:_onCloseView()
	if self._waitCloseFactoryView then
		local isOpenFactoryMap = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
		local isOpenFactoryBlueprint = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

		if not isOpenFactoryMap and not isOpenFactoryBlueprint then
			self:showNewElements()

			self._waitCloseFactoryView = false
		end
	end
end

function VersionActivity1_8DungeonMapSceneElements:onMapPosChanged()
	self:refreshAllElementTimePos()
end

function VersionActivity1_8DungeonMapSceneElements:onClickElement(elementId)
	self:hideTimeContainer()
	self:hideAllElements()
end

function VersionActivity1_8DungeonMapSceneElements:hideTimeContainer()
	gohelper.setActive(self.goTimeContainer, false)
end

function VersionActivity1_8DungeonMapSceneElements:onHideInteractUI()
	self:showTimeContainer()
	self:showAllElements()
end

function VersionActivity1_8DungeonMapSceneElements:showTimeContainer()
	gohelper.setActive(self.goTimeContainer, true)
	self:refreshAllElementTimePos()
end

function VersionActivity1_8DungeonMapSceneElements:onChangeInProgressMissionGroup()
	self:_updateElementArrow()
end

function VersionActivity1_8DungeonMapSceneElements:_onRepairComponent(componentId)
	if not componentId then
		return
	end

	local isOpenFactoryMap = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
	local isOpenFactoryBlueprint = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

	if isOpenFactoryMap or isOpenFactoryBlueprint then
		self._waitCloseFactoryView = true
	else
		self:showNewElements()
	end
end

function VersionActivity1_8DungeonMapSceneElements:onAddDispatchInfo(dispatchId)
	if self.elementTimeItemDict[dispatchId] then
		return
	end

	self:addTimeItemByDispatchId(dispatchId)
end

function VersionActivity1_8DungeonMapSceneElements:onRemoveDispatchInfo(dispatchId)
	if not self.elementTimeItemDict[dispatchId] then
		return
	end

	self:recycleTimeItem(self.elementTimeItemDict[dispatchId])

	self.elementTimeItemDict[dispatchId] = nil
end

function VersionActivity1_8DungeonMapSceneElements:onClickUp()
	local element = self.mouseDownElement

	self.mouseDownElement = nil

	if not self._clickDown or not element then
		return
	end

	local id = element:getElementId()
	local isFinish = DungeonMapModel.instance:elementIsFinished(id)

	if isFinish then
		return
	end

	local isValid = element:isValid()

	if not isValid then
		return
	end

	element:onClick()
end

function VersionActivity1_8DungeonMapSceneElements:onClickDown()
	self._clickDown = true
end

function VersionActivity1_8DungeonMapSceneElements:_editableInitView()
	self._elementCompDict = {}
	self._elementCompPoolDict = {}
	self._arrowList = {}
	self.hadEverySecondTask = false
	self.elementTimeItemDict = {}
	self.timeItemPool = {}
	self.tempPos = Vector3.New(0, 0, 0)

	gohelper.setActive(self.goTimeItem, false)
	gohelper.setActive(self.goTimeContainer, true)
end

function VersionActivity1_8DungeonMapSceneElements:onOpen()
	return
end

function VersionActivity1_8DungeonMapSceneElements:setInitClickElement(elementId)
	self._initClickElementId = elementId
end

function VersionActivity1_8DungeonMapSceneElements:setMouseElementDown(elementComp)
	self.mouseDownElement = elementComp
end

function VersionActivity1_8DungeonMapSceneElements:getElementComp(elementId)
	return self._elementCompDict[elementId]
end

function VersionActivity1_8DungeonMapSceneElements:hideAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:hideElement()
	end

	gohelper.setActive(self._goarrow, false)
end

function VersionActivity1_8DungeonMapSceneElements:showAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:showElement()
	end

	gohelper.setActive(self._goarrow, true)
end

function VersionActivity1_8DungeonMapSceneElements:_addElementById(id)
	local config = lua_chapter_map_element.configDict[id]

	self:_addElement(config)
end

function VersionActivity1_8DungeonMapSceneElements:_addElement(elementConfig)
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

		elementComp = MonoHelper.addLuaComOnceToGo(go, VersionActivity1_8DungeonMapElement, {
			elementConfig,
			self
		})
	end

	self._elementCompDict[elementConfig.id] = elementComp

	local hasArrow = elementComp:isConfigShowArrow()

	if hasArrow then
		local itemPath = self.viewContainer:getSetting().otherRes[3]
		local itemGo = self:getResInst(itemPath, self._goarrow)
		local rotationGo = gohelper.findChild(itemGo, "mesh")
		local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
		local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

		arrowClick:AddClickListener(self._arrowClick, self, elementConfig.id)

		local arrowItem = self:getUserDataTb_()

		arrowItem.go = itemGo
		arrowItem.rotationTrans = rotationGo.transform
		arrowItem.initRotation = {
			rx,
			ry,
			rz
		}
		arrowItem.arrowClick = arrowClick
		self._arrowList[elementConfig.id] = arrowItem

		self:_updateArrow(elementComp)
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnAddOneElement, elementComp)
end

function VersionActivity1_8DungeonMapSceneElements:_arrowClick(elementId)
	self.mouseDownElement = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, elementId)
end

function VersionActivity1_8DungeonMapSceneElements:_updateArrow(elementComp)
	local arrowItem = self._arrowList[elementComp:getElementId()]

	if not arrowItem then
		return
	end

	local isShowArrow = elementComp:showArrow()

	if not isShowArrow then
		gohelper.setActive(arrowItem.go, false)

		return
	end

	local t = elementComp._transform
	local camera = CameraMgr.instance:getMainCamera()
	local pos = camera:WorldToViewportPoint(t.position)
	local x = pos.x
	local y = pos.y
	local isShowElement = x >= 0 and x <= 1 and y >= 0 and y <= 1

	gohelper.setActive(arrowItem.go, not isShowElement)

	if isShowElement then
		return
	end

	local viewportX = math.max(0.02, math.min(x, 0.98))
	local viewportY = math.max(0.035, math.min(y, 0.965))
	local width = recthelper.getWidth(self._goarrow.transform)
	local height = recthelper.getHeight(self._goarrow.transform)

	recthelper.setAnchor(arrowItem.go.transform, width * (viewportX - 0.5), height * (viewportY - 0.5))

	local initRotation = arrowItem.initRotation

	if x >= 0 and x <= 1 then
		if y < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 180)

			return
		elseif y > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 0)

			return
		end
	end

	if y >= 0 and y <= 1 then
		if x < 0 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 270)

			return
		elseif x > 1 then
			transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], 90)

			return
		end
	end

	local angle = 90 - Mathf.Atan2(y, x) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(arrowItem.rotationTrans, initRotation[1], initRotation[2], angle)
end

function VersionActivity1_8DungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementCompDict[id]

	self._elementCompDict[id] = nil

	if elementComp then
		elementComp:setFinish()

		self._elementCompPoolDict[id] = elementComp
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnRemoveElement, elementComp)
end

function VersionActivity1_8DungeonMapSceneElements:recycleAllElements()
	if self._elementCompDict then
		for _, elementComp in pairs(self._elementCompDict) do
			local elementId = elementComp:getElementId()

			self._elementCompPoolDict[elementId] = elementComp

			gohelper.addChild(self.elementPoolRoot, elementComp._go)
		end

		tabletool.clear(self._elementCompDict)
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnRecycleAllElement)
end

function VersionActivity1_8DungeonMapSceneElements:clearElements()
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

function VersionActivity1_8DungeonMapSceneElements:everySecondCall()
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

function VersionActivity1_8DungeonMapSceneElements:addTimeItemByDispatchId(dispatchId)
	for _, elementComp in pairs(self._elementCompDict) do
		local isDispatch = elementComp:isDispatch()

		if isDispatch then
			local elementDispatchId = tonumber(elementComp:getConfig().param)

			if elementDispatchId == dispatchId then
				self:addTimeItem(elementComp)

				return
			end
		end
	end
end

function VersionActivity1_8DungeonMapSceneElements:addTimeItem(elementComp)
	local elementId = elementComp:getElementId()
	local dispatchId = tonumber(elementComp:getConfig().param)
	local dispatchMo = DispatchModel.instance:getDispatchMo(elementId, dispatchId)

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

function VersionActivity1_8DungeonMapSceneElements:getTimeItem()
	if #self.timeItemPool ~= 0 then
		return table.remove(self.timeItemPool)
	end

	local timeItem = self:getUserDataTb_()

	timeItem.go = gohelper.cloneInPlace(self.goTimeItem)
	timeItem.rectTr = timeItem.go:GetComponent(typeof(UnityEngine.RectTransform))
	timeItem.txttime = gohelper.findChildText(timeItem.go, "#txt_time")

	return timeItem
end

function VersionActivity1_8DungeonMapSceneElements:recycleTimeItem(timeItem)
	timeItem.elementComp = nil
	timeItem.dispatchMo = nil

	gohelper.setActive(timeItem.go, false)
	table.insert(self.timeItemPool, timeItem)
end

function VersionActivity1_8DungeonMapSceneElements:refreshAllElementTimePos()
	for _, timeItem in pairs(self.elementTimeItemDict) do
		self:setElementTimePos(timeItem)
	end
end

function VersionActivity1_8DungeonMapSceneElements:setElementTimePos(timeItem)
	local x, y, z = timeItem.elementComp:getElementPos()
	local timePos = self:getElementTimePos(x, y, z)
	local anchorPos = recthelper.worldPosToAnchorPos(timePos, self.goTimeParentTr)

	recthelper.setAnchor(timeItem.rectTr, anchorPos.x, anchorPos.y)
end

function VersionActivity1_8DungeonMapSceneElements:getElementTimePos(x, y, z)
	self.tempPos:Set(x, y + VersionActivity1_8DungeonEnum.ElementTimeOffsetY, z)

	return self.tempPos
end

function VersionActivity1_8DungeonMapSceneElements:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivity1_8DungeonMapSceneElements:onDestroyView()
	self:clearElements()
	DungeonMapModel.instance:clearNewElements()
	self:_stopShowSequence()
	TaskDispatcher.cancelTask(self.showNewElements, self)
end

return VersionActivity1_8DungeonMapSceneElements
