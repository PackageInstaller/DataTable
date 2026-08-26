-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/scene/VersionActivity2_4DungeonMapSceneElements.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.scene.VersionActivity2_4DungeonMapSceneElements", package.seeall)

local VersionActivity2_4DungeonMapSceneElements = class("VersionActivity2_4DungeonMapSceneElements", BaseView)
local FOCUS_TIME = 0.5
local WAIT_TIME = 0.5

function VersionActivity2_4DungeonMapSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4DungeonMapSceneElements:addEvents()
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
	self.addEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self._click:AddClickUpListener(self.onClickUp, self)
	self._click:AddClickDownListener(self.onClickDown, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.showNewElements, self)
end

function VersionActivity2_4DungeonMapSceneElements:removeEvents()
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
	self.removeEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
	self._click:RemoveClickUpListener()
	self._click:RemoveClickDownListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.showNewElements, self)
end

function VersionActivity2_4DungeonMapSceneElements:_editableInitView()
	self._elementCompDict = {}
	self._elementCompPoolDict = {}
	self._arrowList = {}
	self.hadEverySecondTask = false
	self.tempPos = Vector3.New(0, 0, 0)
end

function VersionActivity2_4DungeonMapSceneElements:onOpen()
	return
end

function VersionActivity2_4DungeonMapSceneElements:onGamepadKeyDown(key)
	if key ~= GamepadEnum.KeyCode.A then
		return
	end

	local screenPos = GamepadController.instance:getScreenPos()
	local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(screenPos)
	local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
	local maxIndex = allRaycastHit.Length - 1

	for i = 0, maxIndex do
		local hitInfo = allRaycastHit[i]
		local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, VersionActivity2_4DungeonMapElement)

		if comp then
			comp:_onClickDown()
		end
	end
end

function VersionActivity2_4DungeonMapSceneElements:onBeginDragMap()
	self._clickDown = false
end

function VersionActivity2_4DungeonMapSceneElements:onCreateMapRootGoDone(sceneRoot)
	if self.elementPoolRoot then
		return
	end

	self.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(sceneRoot, self.elementPoolRoot)
	gohelper.setActive(self.elementPoolRoot, false)
	transformhelper.setLocalPos(self.elementPoolRoot.transform, 0, 0, 0)
end

function VersionActivity2_4DungeonMapSceneElements:loadSceneFinish(param)
	self._mapCfg = param.mapConfig
	self._sceneGo = param.mapSceneGo
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)
end

function VersionActivity2_4DungeonMapSceneElements:manualClickElement(id)
	local mapElement = self:getElementComp(tonumber(id))

	if not mapElement then
		return
	end

	if not mapElement:isValid() then
		return
	end

	mapElement:onClick()
end

function VersionActivity2_4DungeonMapSceneElements:setMouseElementDown(elementComp)
	self.mouseDownElement = elementComp
end

function VersionActivity2_4DungeonMapSceneElements:getElementComp(elementId)
	return self._elementCompDict[elementId]
end

function VersionActivity2_4DungeonMapSceneElements:onClickElement(elementId)
	self:hideAllElements()
end

function VersionActivity2_4DungeonMapSceneElements:hideAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:hideElement()
	end

	gohelper.setActive(self._goarrow, false)
end

function VersionActivity2_4DungeonMapSceneElements:onHideInteractUI()
	self:showAllElements()
end

function VersionActivity2_4DungeonMapSceneElements:showAllElements()
	for _, elementComp in pairs(self._elementCompDict) do
		elementComp:showElement()
	end

	gohelper.setActive(self._goarrow, true)
end

function VersionActivity2_4DungeonMapSceneElements:_updateElementArrow()
	for _, v in pairs(self._elementCompDict) do
		self:_updateArrow(v)
	end
end

function VersionActivity2_4DungeonMapSceneElements:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity2_4DungeonMapSceneElements:endShowRewardView()
	self._showRewardView = false

	if self._needRemoveElementId then
		self:_removeElement(self._needRemoveElementId)
		TaskDispatcher.runDelay(self.showNewElements, self, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		self._needRemoveElementId = nil
	else
		self:showNewElements()
	end
end

function VersionActivity2_4DungeonMapSceneElements:onRemoveElement(id)
	if not self._showRewardView then
		self:_removeElement(id)
		self:showNewElements()
	else
		self._needRemoveElementId = id

		local config = lua_chapter_map_element.configDict[id]
		local isDialog = config.type == DungeonEnum.ElementType.EnterDialogue

		if isDialog then
			DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
		end
	end

	local arrowItem = self._arrowList[id]

	if arrowItem then
		arrowItem.arrowClick:RemoveClickListener()

		self._arrowList[id] = nil

		gohelper.destroy(arrowItem.go)
	end
end

function VersionActivity2_4DungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementCompDict[id]

	self._elementCompDict[id] = nil

	if elementComp then
		elementComp:setFinish()

		self._elementCompPoolDict[id] = elementComp
	end

	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.OnRemoveElement, elementComp)
end

function VersionActivity2_4DungeonMapSceneElements:showNewElements()
	local newElements = DungeonMapModel.instance:getNewElements()

	if not newElements then
		return
	end

	local animElements = {}

	for _, elementId in ipairs(newElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local isBelongCurMap = VersionActivity2_4DungeonConfig.instance:checkElementBelongMapId(elementCo, self._mapCfg.id)

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

function VersionActivity2_4DungeonMapSceneElements:_showElementAnim(animElements, normalElements)
	if not animElements or #animElements <= 0 then
		VersionActivity2_4DungeonMapSceneElements._addAnimElementDone({
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
		self._showSequence:addWork(FunctionWork.New(VersionActivity2_4DungeonMapSceneElements._doFocusElement, {
			self,
			id
		}))
		self._showSequence:addWork(TimerWork.New(FOCUS_TIME))
		self._showSequence:addWork(FunctionWork.New(VersionActivity2_4DungeonMapSceneElements._doAddElement, {
			self,
			id
		}))
		self._showSequence:addWork(TimerWork.New(WAIT_TIME))
	end

	self._showSequence:addWork(FunctionWork.New(VersionActivity2_4DungeonMapSceneElements._addAnimElementDone, {
		self,
		normalElements
	}))
	self._showSequence:registerDoneListener(self._stopShowSequence, self)
	self._showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.FocusNewElement)
end

function VersionActivity2_4DungeonMapSceneElements._doFocusElement(params)
	local elementId = params[2]

	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.FocusElement, elementId, true)
end

function VersionActivity2_4DungeonMapSceneElements._doAddElement(params)
	local self, elementId = params[1], params[2]

	self:_addElementById(elementId)

	local comp = self._elementCompDict[elementId]

	if not comp then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function VersionActivity2_4DungeonMapSceneElements._addAnimElementDone(params)
	local self = params[1]
	local normalElements = params[2]

	if not normalElements or #normalElements <= 0 then
		return
	end

	for _, v in ipairs(normalElements) do
		self:_addElement(v)
	end
end

function VersionActivity2_4DungeonMapSceneElements:_addElementById(id)
	local config = lua_chapter_map_element.configDict[id]

	self:_addElement(config)
end

function VersionActivity2_4DungeonMapSceneElements:_addElement(elementConfig)
	if self._elementCompDict[elementConfig.id] then
		return
	end

	local elementComp = self._elementCompPoolDict[elementConfig.id]

	if elementComp then
		self._elementCompPoolDict[elementConfig.id] = nil

		gohelper.addChild(self._elementRoot, elementComp._go)
		elementComp:updatePos()
	else
		local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

		gohelper.addChild(self._elementRoot, go)

		elementComp = MonoHelper.addLuaComOnceToGo(go, VersionActivity2_4DungeonMapElement, {
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

	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.OnAddOneElement, elementComp)
end

function VersionActivity2_4DungeonMapSceneElements:showElements()
	if not self._mapCfg then
		return
	end

	if self.activityDungeonMo:isHardMode() then
		for _, v in pairs(self._arrowList) do
			v.arrowClick:RemoveClickListener()
			gohelper.destroy(v.go)
		end

		self._arrowList = self:getUserDataTb_()

		return
	end

	local animElements = {}
	local normalElements = {}
	local newElements = DungeonMapModel.instance:getNewElements()
	local elementCoList = VersionActivity2_4DungeonModel.instance:getElementCoList(self._mapCfg.id)

	for _, elementCo in ipairs(elementCoList) do
		local isNew = newElements and tabletool.indexOf(newElements, elementCo.id)

		if isNew and elementCo.showCamera == 1 then
			table.insert(animElements, elementCo.id)
		else
			table.insert(normalElements, elementCo)
		end
	end

	self:_showElementAnim(animElements, normalElements)
	DungeonMapModel.instance:clearNewElements()

	if self._initClickElementId then
		self:manualClickElement(self._initClickElementId)

		self._initClickElementId = nil
	end
end

function VersionActivity2_4DungeonMapSceneElements:recycleAllElements()
	if self._elementCompDict then
		for _, elementComp in pairs(self._elementCompDict) do
			local elementId = elementComp:getElementId()

			self._elementCompPoolDict[elementId] = elementComp

			gohelper.addChild(self.elementPoolRoot, elementComp._go)
		end

		tabletool.clear(self._elementCompDict)
	end

	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.OnRecycleAllElement)
end

function VersionActivity2_4DungeonMapSceneElements:_arrowClick(elementId)
	self.mouseDownElement = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	VersionActivity2_4DungeonController.instance:dispatchEvent(VersionActivity2_4DungeonEvent.FocusElement, elementId)
end

function VersionActivity2_4DungeonMapSceneElements:_updateArrow(elementComp)
	local arrowItem = self._arrowList[elementComp:getElementId()]

	if not arrowItem then
		return
	end

	local isShowArrow = elementComp:isConfigShowArrow()

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

function VersionActivity2_4DungeonMapSceneElements:onClickUp()
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

function VersionActivity2_4DungeonMapSceneElements:onClickDown()
	self._clickDown = true
end

function VersionActivity2_4DungeonMapSceneElements:setInitClickElement(elementId)
	self._initClickElementId = elementId
end

function VersionActivity2_4DungeonMapSceneElements:clearElements()
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

function VersionActivity2_4DungeonMapSceneElements:onChangeMap()
	self.hadEverySecondTask = false

	self:_stopShowSequence()

	self._needRemoveElementId = nil
end

function VersionActivity2_4DungeonMapSceneElements:_stopShowSequence()
	if self._showSequence then
		self._showSequence:unregisterDoneListener(self._stopShowSequence, self)
		self._showSequence:destroy()

		self._showSequence = nil

		UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.FocusNewElement)
	end
end

function VersionActivity2_4DungeonMapSceneElements:onDisposeScene()
	self:clearElements()
	self:_stopShowSequence()

	self._needRemoveElementId = nil
end

function VersionActivity2_4DungeonMapSceneElements:onDisposeOldMap(viewName)
	self:recycleAllElements()

	self._elementRoot = nil

	for _, v in pairs(self._arrowList) do
		v.arrowClick:RemoveClickListener()
		gohelper.destroy(v.go)
	end

	self._arrowList = self:getUserDataTb_()

	self:_stopShowSequence()

	self._needRemoveElementId = nil
end

function VersionActivity2_4DungeonMapSceneElements:onClose()
	return
end

function VersionActivity2_4DungeonMapSceneElements:onDestroyView()
	self:clearElements()
	DungeonMapModel.instance:clearNewElements()
	self:_stopShowSequence()
	TaskDispatcher.cancelTask(self.showNewElements, self)
	self:onDisposeOldMap()
end

return VersionActivity2_4DungeonMapSceneElements
