-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonSceneElements.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonSceneElements", package.seeall)

local AtomicDungeonSceneElements = class("AtomicDungeonSceneElements", BaseView)
local WAIT_TIME = 0.5

function AtomicDungeonSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._screenClick = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self._goarrow = gohelper.findChild(self.viewGO, "root/#go_arrow")
	self._goClickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._goelementClickRoot = gohelper.findChild(self.viewGO, "root/#go_elementClickRoot")
	self._goelementClickItem = gohelper.findChild(self.viewGO, "root/#go_elementClickRoot/#go_elementClickItem")
	self._goelementDragRoot = gohelper.findChild(self.viewGO, "root/#go_elementDragRoot")
	self._goelementDragItem = gohelper.findChild(self.viewGO, "root/#go_elementDragRoot/#go_elementDragItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonSceneElements:addEvents()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnInitElements, self.initElements, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnUpdateElementArrow, self.updateAllArrowPos, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnElementFinish, self.elementFinished, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.PlayElementAnim, self.playElementAnim, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDragDungeonScene, self.refreshElemenetSibling, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnOpenInteractView, self.onInteractElementHide, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseInteractView, self.onInteractElementShow, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnMapUpdate, self.onNewMapUnlock, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnPolygonKeyElementPutFinish, self.onPolygonKeyElementPutFinish, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnPolygonMapRangeChange, self.onPolygonMapRangeChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
end

function AtomicDungeonSceneElements:removeEvents()
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnInitElements, self.initElements, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnUpdateElementArrow, self.updateAllArrowPos, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnElementFinish, self.elementFinished, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.PlayElementAnim, self.playElementAnim, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnDragDungeonScene, self.refreshElemenetSibling, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnOpenInteractView, self.onInteractElementHide, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnCloseInteractView, self.onInteractElementShow, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnMapUpdate, self.onNewMapUnlock, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnPolygonKeyElementPutFinish, self.onPolygonKeyElementPutFinish, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnPolygonMapRangeChange, self.onPolygonMapRangeChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.Low)
	self._screenClick:RemoveClickUpListener()
end

function AtomicDungeonSceneElements:onElementClickDown(element)
	self.curClickElement = element
end

function AtomicDungeonSceneElements:onPolygonKeyElementClick(elementComp)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_common_click)
	self:onElementClickDown(elementComp)
	self:onScreenClickUp()
end

function AtomicDungeonSceneElements:onDungeonElementClick(elementComp)
	self:onElementClickDown(elementComp)
	self:onScreenClickUp()
end

function AtomicDungeonSceneElements:onScreenClickUp(delayClick)
	local isDraggingMap = AtomicDungeonModel.instance:getDraggingMapState()

	if not self.curClickElement or isDraggingMap then
		return
	end

	local clickElemenet = self.curClickElement

	if clickElemenet.isPolygonEnter then
		local sceneView = self.viewContainer:getDungeonSceneView()

		if sceneView then
			AtomicDungeonModel.instance:setCurMapId(clickElemenet.config.mapId)
			sceneView:enterPolygonMap()

			self.curClickElement = nil
		end

		return
	end

	local isFinish = AtomicDungeonModel.instance:isElementFinish(clickElemenet.config.id)

	if clickElemenet.config.isPermanent ~= 1 and (isFinish or gohelper.isNil(clickElemenet.go)) then
		return
	end

	TaskDispatcher.cancelTask(self.realClickElement, self)

	if delayClick then
		TaskDispatcher.runDelay(self.realClickElement, self, 0.3)
	else
		self:realClickElement()
	end
end

function AtomicDungeonSceneElements:realClickElement()
	local clickElemenet = self.curClickElement

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnClickElement, clickElemenet)

	self.curClickElement = nil

	local isInPolygon = AtomicDungeonModel.instance:getIsInPolygonState()

	if not self.curElementId or self.curElementId ~= clickElemenet.config.id then
		if not isInPolygon then
			local polygonUnlock = AtomicDungeonModel.instance:checkPolygonUnlock(self.curMapId)

			if not polygonUnlock then
				AtomicRpc.instance:sendAtomicMapSetCurrElementRequest(clickElemenet.config.id)
			end
		else
			local isKeyElement = AtomicDungeonConfig.instance:checkElementIsKey(clickElemenet.config)

			if not isKeyElement then
				AtomicRpc.instance:sendAtomicMapSetCurrElementRequest(clickElemenet.config.id)
			end
		end
	end

	if clickElemenet.config.type == AtomicDungeonEnum.ElementType.Dialog and clickElemenet.config.dialog > 0 then
		DialogueController.instance:enterDialogue(clickElemenet.config.dialog, function(clickElemenet)
			AtomicRpc.instance:sendAtomicMapInteractRequest(clickElemenet.config.id, {})
		end, clickElemenet)
	elseif clickElemenet.config.type == AtomicDungeonEnum.ElementType.DataBase then
		AtomicRpc.instance:sendAtomicMapInteractRequest(clickElemenet.config.id, {})

		local elementData = AtomicDungeonModel.instance:getElementStatData(clickElemenet.config.id)

		AtomicDungeonStatHelper.instance:sendElementInteractInfo(elementData)
	else
		AtomicDungeonController.instance:openDungeonInteractView(clickElemenet)
	end
end

function AtomicDungeonSceneElements:onGamepadKeyDown(key)
	if key ~= GamepadEnum.KeyCode.A then
		return
	end

	local screenPos = GamepadController.instance:getScreenPos()
	local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(screenPos)
	local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
	local maxIndex = allRaycastHit.Length - 1

	for i = 0, maxIndex do
		local hitInfo = allRaycastHit[i]
		local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, AtomicDungeonElement)

		if comp then
			comp:onClickDown()
		end
	end
end

function AtomicDungeonSceneElements:onElementBeginDrag(elementDrag, pointerEventData)
	AtomicDungeonModel.instance:setDraggingMapState(true)

	self.polygonSceneGOPos.x, self.polygonSceneGOPos.y = transformhelper.getLocalPos(self.polygonSceneGO.transform)
	self.keyElementWidth = recthelper.getWidth(elementDrag.go.transform)
	self.keyElementHeight = recthelper.getHeight(elementDrag.go.transform)

	gohelper.setAsLastSibling(elementDrag.go)
	gohelper.setAsLastSibling(elementDrag.comp.go)

	self.curDragKeyElementId = elementDrag.comp.config.id

	elementDrag.comp:setSelectState(false)
	elementDrag.comp:setDragState(true)
end

function AtomicDungeonSceneElements:onElementDrag(elementDrag, pointerEventData)
	AtomicDungeonModel.instance:setDraggingMapState(true)

	local anchorPos = recthelper.screenPosToWorldPos(pointerEventData.position, self.mainCamera, self.polygonSceneGO.transform.position)

	elementDrag.curPosX = anchorPos.x - self.polygonSceneGOPos.x - self.sceneRootPosX
	elementDrag.curPosY = anchorPos.y - self.polygonSceneGOPos.y - self.sceneRootPosY
	elementDrag.curPosX, elementDrag.curPosY = self:clampToScreen(elementDrag.curPosX, elementDrag.curPosY)
	elementDrag.curPosX, elementDrag.curPosY = self:getDragTargetPos(elementDrag.curPosX, elementDrag.curPosY)

	recthelper.setAnchor(elementDrag.comp.trans, elementDrag.curPosX, elementDrag.curPosY)
	self:refreshPolygonKeyLinePos(elementDrag.comp.config, elementDrag.curPosX, elementDrag.curPosY)
	AtomicDungeonModel.instance:setKeyElementData(elementDrag.comp.config.id, elementDrag.curPosX, elementDrag.curPosY)

	local touchElementList = AtomicDungeonModel.instance:getCurTouchElementId(elementDrag.curPosX, elementDrag.curPosY)

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnDraggingPolygonKeyElement, elementDrag.comp.config.id, touchElementList)
end

function AtomicDungeonSceneElements:onElementEndDrag(elementDrag, pointerEventData)
	AtomicDungeonModel.instance:setDraggingMapState(false)
	AtomicDungeonModel.instance:saveLocalKeyElementData()

	self.curClickElement = nil

	local touchElementList = AtomicDungeonModel.instance:getCurTouchElementId(elementDrag.curPosX, elementDrag.curPosY)

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnDragEndPolygonKeyElement, elementDrag.comp.config.id, touchElementList)
	elementDrag.comp:setSelectState(false)
	elementDrag.comp:setDragState(false)
end

function AtomicDungeonSceneElements:getDragTargetPos(posX, posY)
	local minPosX = self.keyElementWidth / 2 * AtomicDungeonEnum.PolygonElementScale
	local maxPosX = self.polygonBoxSizeX - self.keyElementWidth / 2 * AtomicDungeonEnum.PolygonElementScale
	local minPosY = self.keyElementHeight / 2 * AtomicDungeonEnum.PolygonElementScale - self.polygonBoxSizeY
	local maxPosY = -self.keyElementHeight / 2 * AtomicDungeonEnum.PolygonElementScale
	local targetPosX = Mathf.Clamp(posX, minPosX, maxPosX)
	local targetPosY = Mathf.Clamp(posY, minPosY, maxPosY)

	return targetPosX, targetPosY
end

function AtomicDungeonSceneElements:clampToScreen(localPosX, localPosY)
	if not self.polygonSceneGO then
		return localPosX, localPosY
	end

	local worldX = localPosX + self.polygonSceneGOPos.x + self.sceneRootPosX
	local worldY = localPosY + self.polygonSceneGOPos.y + self.sceneRootPosY
	local worldPos = Vector3(worldX, worldY, self.polygonSceneGO.transform.position.z)
	local viewportPos = self.mainCamera:WorldToViewportPoint(worldPos)
	local minVP = 0.1
	local maxVP = 0.9
	local clamped = false

	if minVP > viewportPos.x then
		viewportPos.x = minVP
		clamped = true
	elseif maxVP < viewportPos.x then
		viewportPos.x = maxVP
		clamped = true
	end

	if minVP > viewportPos.y then
		viewportPos.y = minVP
		clamped = true
	elseif maxVP < viewportPos.y then
		viewportPos.y = maxVP
		clamped = true
	end

	if not clamped then
		return localPosX, localPosY
	end

	local clampedWorldPos = self.mainCamera:ViewportToWorldPoint(viewportPos)
	local clampedLocalX = clampedWorldPos.x - self.polygonSceneGOPos.x - self.sceneRootPosX
	local clampedLocalY = clampedWorldPos.y - self.polygonSceneGOPos.y - self.sceneRootPosY

	return clampedLocalX, clampedLocalY
end

function AtomicDungeonSceneElements:_editableInitView()
	self.elementCompMap = self:getUserDataTb_()
	self.elementRootMap = self:getUserDataTb_()
	self.elementArrowMap = self:getUserDataTb_()
	self.elementClickMap = self:getUserDataTb_()
	self.elementDragMap = self:getUserDataTb_()
	self.polygonLineListMap = self:getUserDataTb_()
	self.curElementId = nil
	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.uiCamera = CameraMgr.instance:getUICamera()

	gohelper.setActive(self._goClickMask, false)
	gohelper.setActive(self._goelementClickItem, false)
	gohelper.setActive(self._goelementDragItem, false)
	AtomicDungeonModel.instance:setCanClickElementState(true)
end

function AtomicDungeonSceneElements:initElements(elementsRootGO, sceneGo, sceneRoot)
	self._screenClick:AddClickUpListener(self.onScreenClickUp, self)

	self.curMapId = AtomicDungeonModel.instance:getCurMapId()
	self.elementsRootGO = elementsRootGO
	self.sceneGO = sceneGo
	self.sceneRoot = sceneRoot
	self.polygonSceneGO = self.sceneGO and gohelper.findChild(self.sceneGO, "Trial")
	self.polygonSceneGOPos = Vector2()
	self.sceneRootPosX, self.sceneRootPosY = transformhelper.getLocalPos(self.sceneRoot.transform)

	self:initPolygonSceneSize()

	local rootGO = gohelper.findChild(self.elementsRootGO, "root")

	self.rootScale = transformhelper.getLocalScale(rootGO.transform)

	for type, rootPath in pairs(AtomicDungeonEnum.ElementTypeRoot) do
		self.elementRootMap[type] = self.elementRootMap[type] or gohelper.findChild(self.elementsRootGO, "root/" .. rootPath)
	end

	self.dungeonElementRoot = gohelper.findChild(rootGO, "dungeonElement")
	self.goLineContent = gohelper.findChild(rootGO, "go_lineContent")
	self.lineItem = gohelper.findChild(rootGO, "go_lineContent/go_line")

	gohelper.setActive(self.lineItem, false)
	self:removeAllElement()
	TaskDispatcher.cancelTask(self.addElements, self)

	local lastEleFightParam = AtomicDungeonModel.instance:getLastElementFightParam()
	local curFightEpisodeId = AtomicDungeonModel.instance:getCurFightEpisodeId()
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if lastEleFightParam and lastEleFightParam.lastElementId > 0 and curFightEpisodeId ~= lastEleFightParam.lastEpisodeId and not isInPolygonState then
		local lastElementCo = AtomicDungeonConfig.instance:getElementConfig(lastEleFightParam.lastElementId)
		local newElements = AtomicDungeonModel.instance:getNewElementList()

		if lastElementCo and #newElements > 0 then
			TaskDispatcher.runDelay(self.addElements, self, 1.5)
		else
			self:addElements()
		end
	else
		self:addElements()
	end

	self:cleanLastFightElementAndJumpNext()
end

function AtomicDungeonSceneElements:initPolygonSceneSize()
	if not self.polygonSceneGO then
		self.polygonBoxSizeX = 0
		self.polygonBoxSizeY = 0

		return
	end

	local sizeGo = gohelper.findChild(self.polygonSceneGO, "size")
	local box = sizeGo:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
	local boxScaleX, boxScaleY, boxScaleZ = transformhelper.getLocalScale(sizeGo.transform, 0, 0, 0)

	self.polygonBoxSizeX = box.size.x * boxScaleX
	self.polygonBoxSizeY = box.size.y * boxScaleY
end

function AtomicDungeonSceneElements:addElements()
	local elementCoList = AtomicDungeonModel.instance:getCurAllElementCoList(self.curMapId)

	for _, elementCo in ipairs(elementCoList) do
		local isElementFinish = AtomicDungeonModel.instance:isElementFinish(elementCo.id)
		local elementMo = AtomicDungeonModel.instance:getElementMo(elementCo.id)
		local isInNewList = AtomicDungeonModel.instance:checkElementInNewList(elementCo.id)

		if elementCo.isEmergency == 1 and elementMo and not elementMo:showEmergency() then
			-- block empty
		elseif not isInNewList and (not isElementFinish or elementCo.isPermanent == 1) then
			self:addOrUpdateElement(elementCo)
			self:addOrUpdateArrowItem(elementCo)
			self:addOrUpdatePolygonLine(elementCo)
		end
	end

	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()
	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	gohelper.setActive(self.goLineContent, isInPolygonState)

	if isInPolygonState then
		AtomicDungeonModel.instance:initKeyElementFinishState(self.curMapId)
		AtomicDungeonModel.instance:initKeyElementMap()
		AtomicDungeonModel.instance:initLocalKeyElementData()

		local canShowKeyElementCoList = AtomicDungeonModel.instance:getCurCanShowKeyElementCoList(self.curMapId)

		for _, keyElementCo in ipairs(canShowKeyElementCoList) do
			local isInNewList = AtomicDungeonModel.instance:checkElementInNewList(keyElementCo.id)

			if not isInNewList then
				self:addOrUpdateElement(keyElementCo)
				self:addOrUpdatePolygonLine(keyElementCo)
			end
		end
	end

	if isInMapSelectState or isInPolygonState then
		self:stopEmergencyElementTime()

		return
	end

	local polygonUnlock = AtomicDungeonModel.instance:checkPolygonUnlock(self.curMapId)
	local needPlayPolygonEnterFinish = AtomicDungeonModel.instance:getNeedPlayPolygonEnterFinish()
	local canShowPolygonSelect = AtomicDungeonModel.instance:checkCanShowPolygon(self.curMapId)

	if polygonUnlock and not canShowPolygonSelect or needPlayPolygonEnterFinish then
		local polygonEnterData = AtomicDungeonModel.instance:getPolygonEnterCoData(self.curMapId)

		self:addOrUpdateElement(polygonEnterData)
		self:addOrUpdateArrowItem(polygonEnterData)
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonEnterElementGuide)

		if needPlayPolygonEnterFinish then
			self:playElementFinishAnim(polygonEnterData.id)
			AtomicDungeonModel.instance:setNeedPlayPolygonEnterFinish(false)
		end
	end

	local preMapUnFinishDataBaseAndEmergencyElementList = AtomicDungeonModel.instance:getPreMapUnFinishDataBaseAndEmergencyElementList()

	for _, elemenetId in ipairs(preMapUnFinishDataBaseAndEmergencyElementList) do
		local elementCo = AtomicDungeonConfig.instance:getElementConfig(elemenetId)
		local isInNewList = AtomicDungeonModel.instance:checkElementInNewList(elementCo.id)

		if not isInNewList then
			self:addOrUpdateElement(elementCo)
		end
	end

	self:restartEmergencyElementTime()
	self:refreshElemenetSibling()
end

function AtomicDungeonSceneElements:addOrUpdateElement(elementCo, isNew)
	local elementComp = self.elementCompMap[elementCo.id]
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if not elementComp then
		if isInPolygonState then
			local elementPrefabUrl = self.viewContainer:getSetting().otherRes[2]
			local go = self.viewContainer:getResInst(elementPrefabUrl, self.elementRootMap[elementCo.type], tostring(elementCo.id))
			local isKeyElement = AtomicDungeonConfig.instance:checkElementIsKey(elementCo)

			if isKeyElement then
				elementComp = MonoHelper.addLuaComOnceToGo(go, AtomicDungeonPolygonKeyElement, {
					elementCo,
					self.mainCamera,
					self
				})

				self:addPolygonElementDrag(elementComp, go)
			else
				elementComp = MonoHelper.addLuaComOnceToGo(go, AtomicDungeonPolygonElement, {
					elementCo,
					self.mainCamera,
					self
				})
			end

			elementComp:playShowOrHideAnim(true)
		else
			local elementPrefabUrl = self.viewContainer:getSetting().otherRes[1]
			local go = self.viewContainer:getResInst(elementPrefabUrl, self.dungeonElementRoot, tostring(elementCo.id) .. "_" .. self.elementRootMap[elementCo.type].name)

			elementComp = MonoHelper.addLuaComOnceToGo(go, AtomicDungeonElement, {
				elementCo,
				self.mainCamera,
				self
			})

			self:addElementClick(elementComp, go)

			if isNew then
				elementComp:playAnim("open2")
			else
				elementComp:playShowOrHideAnim(true)
			end
		end
	else
		if isInPolygonState then
			local elementRoot = self.elementRootMap[elementCo.type]

			gohelper.addChild(elementRoot, elementComp.go)
		else
			gohelper.addChild(self.dungeonElementRoot, elementComp.go)
		end

		elementComp:updateInfo()
	end

	self.elementCompMap[elementCo.id] = elementComp

	if isInPolygonState and elementCo.id == AtomicDungeonEnum.PolygonNeedTwoKeyElementId then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonTwoKeyElementGuide)
	end
end

function AtomicDungeonSceneElements:getElemenetComp(elementId)
	return self.elementCompMap[elementId]
end

function AtomicDungeonSceneElements:onPolygonMapRangeChange(value)
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if not isInPolygonState then
		return
	end

	local canShowName = value >= AtomicDungeonEnum.ShowPolygonElementNameValue

	for elementId, elementComp in pairs(self.elementCompMap) do
		elementComp:setNameShowState(canShowName)
	end
end

function AtomicDungeonSceneElements:refreshElemenetSibling()
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if isInPolygonState then
		return
	end

	local elementCompList = {}

	for _, elementComp in pairs(self.elementCompMap) do
		table.insert(elementCompList, elementComp)
	end

	table.sort(elementCompList, function(a, b)
		return a:getCameraDistance() > b:getCameraDistance()
	end)

	for _, elementComp in pairs(elementCompList) do
		gohelper.setAsLastSibling(elementComp.go)

		local elementClick = self.elementClickMap[elementComp.config.id]

		if elementClick then
			gohelper.setAsLastSibling(elementClick.go)
		end
	end
end

function AtomicDungeonSceneElements:addElementClick(elementComp, elementGO)
	local elementId = elementComp.config.id
	local elementClick = self.elementClickMap[elementId]

	if not elementClick then
		elementClick = {
			go = gohelper.clone(self._goelementClickItem, self._goelementClickRoot, elementId)
		}
		elementClick.btnClick = gohelper.findChildButtonWithAudio(elementClick.go, "btn_click")

		elementClick.btnClick:AddClickListener(self.onDungeonElementClick, self, elementComp)

		local uiRootTrans = ViewMgr.instance:getUIRoot().transform

		elementClick.uiFollower = gohelper.onceAddComponent(elementClick.go, typeof(ZProj.UIFollower))

		elementClick.uiFollower:Set(self.mainCamera, self.uiCamera, uiRootTrans, elementGO.transform, 0, 1.1, 0, 0, 0)
		elementClick.uiFollower:SetEnable(true)
	end

	gohelper.setActive(elementClick.go, true)

	self.elementClickMap[elementId] = elementClick
end

function AtomicDungeonSceneElements:addPolygonElementDrag(elementComp, elementGO)
	local elementId = elementComp.config.id
	local elementDrag = self.elementDragMap[elementId]

	if not elementDrag then
		elementDrag = {
			go = gohelper.clone(self._goelementDragItem, self._goelementDragRoot, elementId),
			comp = elementComp
		}
		elementDrag.drag = SLFramework.UGUI.UIDragListener.Get(elementDrag.go)

		elementDrag.drag:AddDragBeginListener(self.onElementBeginDrag, self, elementDrag)
		elementDrag.drag:AddDragListener(self.onElementDrag, self, elementDrag)
		elementDrag.drag:AddDragEndListener(self.onElementEndDrag, self, elementDrag)

		if elementComp.config.canClick == 1 then
			elementDrag.click = gohelper.getClickWithAudio(elementDrag.go)

			elementDrag.click:AddClickListener(self.onPolygonKeyElementClick, self, elementDrag.comp)
		end

		local uiRootTrans = ViewMgr.instance:getUIRoot().transform

		elementDrag.uiFollower = gohelper.onceAddComponent(elementDrag.go, typeof(ZProj.UIFollower))

		elementDrag.uiFollower:Set(self.mainCamera, self.uiCamera, uiRootTrans, elementGO.transform, 0, 0, 0, 0, 0)
		elementDrag.uiFollower:SetEnable(true)
	end

	gohelper.setActive(elementDrag.go, true)

	self.elementDragMap[elementId] = elementDrag
end

function AtomicDungeonSceneElements:addOrUpdatePolygonLine(elementCo, needTween)
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if not isInPolygonState or string.nilorempty(elementCo.preId) then
		return
	end

	local preIdList = string.splitToNumber(elementCo.preId, "|")

	for index, preElementId in ipairs(preIdList) do
		local lineItemList = self.polygonLineListMap[elementCo.id]

		if not lineItemList then
			lineItemList = {}
			self.polygonLineListMap[elementCo.id] = lineItemList
		end

		local lineItem = lineItemList[index]

		if not lineItem then
			lineItem = {
				go = gohelper.clone(self.lineItem, self.goLineContent, "lineItem" .. elementCo.id),
				curElementId = elementCo.id,
				preElementId = preElementId
			}
			lineItem.comp = MonoHelper.addLuaComOnceToGo(lineItem.go, AtomicDungeonPolygonLineItem, {
				elementCo,
				preElementId,
				self
			})
			lineItemList[index] = lineItem
		end

		lineItem.comp:refreshUI(needTween)
	end

	if needTween then
		for _, lineItemList in pairs(self.polygonLineListMap) do
			for _, lineItem in ipairs(lineItemList) do
				if lineItem.preElementId == elementCo.id then
					lineItem.comp:refreshUI(needTween)
				end
			end
		end
	end
end

function AtomicDungeonSceneElements:refreshPolygonKeyLinePos(elementCo, curPosX, curPosY)
	local curPosData = {
		curPosX,
		curPosY
	}

	for elementId, lineItemList in pairs(self.polygonLineListMap) do
		for _, lineItem in ipairs(lineItemList) do
			if lineItem.preElementId == elementCo.id then
				lineItem.comp:refreshUI(false, curPosData)
			end
		end

		if elementId == elementCo.id then
			for _, lineItem in ipairs(lineItemList) do
				lineItem.comp:refreshUI(false, curPosData)
			end
		end
	end
end

function AtomicDungeonSceneElements:lineMoveTweenFinish(lineItem)
	recthelper.setWidth(lineItem.go.transform, lineItem.distance)
end

function AtomicDungeonSceneElements:elementFinished(finishElementId)
	local newUnlockMapList = AtomicDungeonModel.instance:getNewUnlockMapList()
	local isElementFinish = AtomicDungeonModel.instance:isElementFinish(finishElementId)
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if not isElementFinish then
		return
	end

	if #newUnlockMapList > 0 and not isInPolygonState then
		self.unlockMapFinishElementId = finishElementId

		return
	end

	self.dataBaseShowSequence = FlowSequence.New()

	local newUnlockDataBaseList = AtomicDungeonModel.instance:getNewUnlockDataBaseList()

	if #newUnlockDataBaseList > 0 then
		self.dataBaseShowSequence:addWork(AtomicCheckDataBaseToastShowWork.New())
	end

	self.dataBaseShowSequence:addWork(FunctionWork.New(function()
		self:playElementFinishAnim(finishElementId)
	end), self)

	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if #newUnlockMapList == 0 or isInPolygonState then
		self.dataBaseShowSequence:registerDoneListener(self.showNewElements, self)
	end

	self.dataBaseShowSequence:start()
end

function AtomicDungeonSceneElements:playElementFinishAnim(elementId)
	local elementComp = self.elementCompMap[elementId]
	local isInNewList = AtomicDungeonModel.instance:checkElementInNewList(elementId)

	if elementComp and not isInNewList and elementComp.config.isPermanent ~= 1 then
		elementComp:playShowOrHideAnim(false)

		local elementClick = self.elementClickMap[elementId]

		if elementClick then
			gohelper.setActive(elementClick.go, false)
		end

		self:removeArrow(elementId)
	end
end

function AtomicDungeonSceneElements:showNewElements(notAutoOpen)
	self:cleanDataBaseSequence()
	AtomicDungeonModel.instance:cleanNewUnlockMapList()

	self.notAutoOpenElement = notAutoOpen

	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()
	local newElements = AtomicDungeonModel.instance:getNewElementList()
	local allElementCoList = {}
	local curElementCoList = AtomicDungeonModel.instance:getCurAllElementCoList(self.curMapId)
	local allKeyElementCoList = AtomicDungeonModel.instance:getCurCanShowKeyElementCoList(self.curMapId)

	tabletool.addValues(allElementCoList, curElementCoList)

	if isInPolygonState then
		tabletool.addValues(allElementCoList, allKeyElementCoList)
	end

	AtomicDungeonModel.instance:initKeyElementMap()

	if isInPolygonState then
		local polygonMo = AtomicDungeonModel.instance:getPolygonMo(self.curMapId)

		if polygonMo then
			AtomicDungeonController.instance:openAtomicDungeonPolygonSuccView()

			return
		end
	end

	if not newElements or #newElements == 0 then
		TaskDispatcher.cancelTask(self.removeUnExitElement, self)
		TaskDispatcher.runDelay(self.removeUnExitElement, self, WAIT_TIME)

		for _, elementCo in ipairs(allElementCoList) do
			self:addOrUpdateElement(elementCo)
			self:addOrUpdatePolygonLine(elementCo)
		end

		AtomicDungeonController.instance:showElementTipToast()
		AtomicDungeonController.instance:showAlarmTipToast()
		gohelper.setActive(self._goClickMask, false)

		return
	end

	local curNewElementList = {}
	local hasEmergencyElement = false

	for index, elementCo in ipairs(newElements) do
		if elementCo.mapId == self.curMapId or elementCo.isEmergency == 1 and AtomicDungeonConfig.instance:getDungeonMapId(elementCo.mapId) == AtomicDungeonConfig.instance:getDungeonMapId(self.curMapId) then
			table.insert(curNewElementList, elementCo)
		end

		if elementCo.isEmergency == 1 then
			hasEmergencyElement = true
		end
	end

	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	if not isInMapSelectState and not isInPolygonState then
		local polygonUnlock = AtomicDungeonModel.instance:checkPolygonUnlock(self.curMapId)

		if polygonUnlock then
			local polygonEnterData = AtomicDungeonModel.instance:getPolygonEnterCoData(self.curMapId)

			table.insert(curNewElementList, polygonEnterData)
		end
	end

	if isInPolygonState then
		for _, elementCo in ipairs(allElementCoList) do
			local needRefresh = true

			for _, newElementCo in ipairs(curNewElementList) do
				if elementCo.id == newElementCo.id then
					needRefresh = false

					break
				end
			end

			if needRefresh then
				self:addOrUpdatePolygonLine(elementCo)
				self:addOrUpdateElement(elementCo)
			end
		end

		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonElementFinishGuide)
	end

	if hasEmergencyElement then
		TaskDispatcher.cancelTask(self.sendAddEmergencyCurrentSeconds, self)
		TaskDispatcher.runRepeat(self.sendAddEmergencyCurrentSeconds, self, AtomicDungeonEnum.SendEmergencyAddSecondTime)
		self:sendAddEmergencyCurrentSeconds()
	end

	self:showNewElementsAnim(curNewElementList)
end

function AtomicDungeonSceneElements:showNewElementsAnim(curNewElementList)
	if #curNewElementList == 0 then
		AtomicDungeonModel.instance:cleanNewElements()

		return
	end

	local normalElementList = {}

	self.animElementList = {}

	for index, elementCo in ipairs(curNewElementList) do
		if elementCo.needFollow == 1 then
			table.insert(self.animElementList, elementCo)
			self:addOrUpdateArrowItem(elementCo)
		else
			table.insert(normalElementList, elementCo)
			self:addOrUpdateElement(elementCo, true)
		end
	end

	TaskDispatcher.cancelTask(self.removeUnExitElement, self)
	TaskDispatcher.runDelay(self.removeUnExitElement, self, WAIT_TIME)

	self.showSequence = FlowSequence.New()

	self.showSequence:addWork(TimerWork.New(WAIT_TIME))

	local needPopupCommonProView = AtomicDungeonModel.instance:getNeedPopupCommonProViewState()

	if needPopupCommonProView then
		self.showSequence:addWork(AtomicCheckCommonPropViewCloseWork.New())
		self.showSequence:addWork(TimerWork.New(WAIT_TIME))
	end

	self.showSequence:addWork(AtomicCheckTipToastWork.New())
	self.showSequence:addWork(TimerWork.New(WAIT_TIME * 0.5))

	if #self.animElementList > 0 then
		table.sort(self.animElementList, AtomicDungeonSceneElements.sortElementList)

		for _, elementCo in ipairs(self.animElementList) do
			self.showSequence:addWork(FunctionWork.New(AtomicDungeonSceneElements.addNewElement, {
				self,
				elementCo
			}))
			self.showSequence:addWork(TimerWork.New(WAIT_TIME * 0.5))
		end

		self.nextElementId = self.animElementList[1].id

		for index, elementCo in ipairs(self.animElementList) do
			if elementCo.mapId == self.curMapId then
				self.nextElementId = elementCo.id

				break
			end
		end

		local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

		if self.nextElementId > 0 and isInPolygonState then
			self.showSequence:addWork(FunctionWork.New(AtomicDungeonSceneElements.focusNewElement, self))
		end
	end

	self.showSequence:registerDoneListener(self.stopShowElementsSequence, self)
	self.showSequence:start()
	gohelper.setActive(self._goClickMask, true)
	AtomicDungeonModel.instance:setCanClickElementState(false)
end

function AtomicDungeonSceneElements.sortElementList(elementCoA, elementCoB)
	return elementCoA.id < elementCoB.id
end

function AtomicDungeonSceneElements.addNewElement(params)
	local self, elementCo = params[1], params[2]
	local elementMo = AtomicDungeonModel.instance:getElementMo(elementCo.id)
	local polygonEnterData = AtomicDungeonModel.instance:getPolygonEnterCoData(self.curMapId)
	local isPolygonEnter = polygonEnterData and polygonEnterData.id == elementCo.id
	local keyElementMo = AtomicDungeonModel.instance:getKeyElementMo(elementCo.id)

	if not elementMo and not isPolygonEnter and not keyElementMo or elementMo and elementMo:isExpired() then
		return
	end

	if isPolygonEnter then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonEnterElementGuide)
	end

	self:addOrUpdateElement(elementCo, true)
	self:addOrUpdateArrowItem(elementCo)
	self:addOrUpdatePolygonLine(elementCo, true)
end

function AtomicDungeonSceneElements:focusNewElement()
	local elementMo = AtomicDungeonModel.instance:getElementMo(self.nextElementId)
	local keyElementMo = AtomicDungeonModel.instance:getKeyElementMo(self.nextElementId)

	if not elementMo and not keyElementMo or elementMo and elementMo:isExpired() then
		return
	end

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnFocusElement, self.nextElementId, true)
end

function AtomicDungeonSceneElements:stopShowElementsSequence()
	if self.showSequence then
		self.showSequence:unregisterDoneListener(self.stopShowElementsSequence, self)
		self.showSequence:destroy()

		self.showSequence = nil

		AtomicDungeonModel.instance:cleanNewElements()
	end

	AtomicDungeonModel.instance:setNeedPopupCommonProState(false)
	gohelper.setActive(self._goClickMask, false)
	AtomicDungeonModel.instance:setCanClickElementState(true)
	self:refreshElemenetSibling()

	if self.nextElementId then
		self.nextElementId = nil
	end

	local canShowpolygon = AtomicDungeonModel.instance:isHaveUnlockPolygon()
	local isTalentUnlock = AtomicDungeonModel.instance:checkTalentUnlock()
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()

	if isTalentUnlock then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnTalentUnlockGuide)
	end

	if canShowpolygon and not isInPolygonState then
		AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonUnlockGuide)
	end
end

function AtomicDungeonSceneElements:playElementAnim(elementId, animName)
	for _, elementComp in pairs(self.elementCompMap) do
		elementComp:playAnim(AtomicDungeonEnum.ElementAnimName.Idle)
	end

	local elementComp = self.elementCompMap[elementId]

	if elementComp then
		elementComp:playAnim(animName)
	end
end

function AtomicDungeonSceneElements:onInteractElementShow(elementId)
	self:setInteractElementShowState(elementId, true)
end

function AtomicDungeonSceneElements:onInteractElementHide(elementId)
	self:setInteractElementShowState(elementId, false)
end

function AtomicDungeonSceneElements:setInteractElementShowState(curElementId, showState)
	for elementId, elementComp in pairs(self.elementCompMap) do
		if elementId ~= curElementId then
			elementComp:playShowOrHideAnim(showState)
		else
			elementComp:playAnim(AtomicDungeonEnum.ElementAnimName.Idle)
		end
	end
end

function AtomicDungeonSceneElements:cleanLastFightElementAndJumpNext()
	self.lastFightElementId = nil

	local lastEleFightParam = AtomicDungeonModel.instance:getLastElementFightParam()

	if lastEleFightParam and lastEleFightParam.lastElementId > 0 then
		local elementCo = AtomicDungeonConfig.instance:getElementConfig(lastEleFightParam.lastElementId)

		if not elementCo then
			logError("请检查配置:" .. lastEleFightParam.lastElementId)

			return
		end

		local isElementFinish = AtomicDungeonModel.instance:isElementFinish(lastEleFightParam.lastElementId)

		if not isElementFinish then
			local elementComp = self.elementCompMap[lastEleFightParam.lastElementId]

			if elementComp then
				self.curClickElement = elementComp

				self:onScreenClickUp()
			end
		else
			self.lastFightElementId = elementCo.id

			self:addOrUpdateElement(elementCo)
			self:addOrUpdatePolygonLine(elementCo)
			TaskDispatcher.runDelay(self.setElementFinished, self, 1.5)

			local elementData = AtomicDungeonModel.instance:getElementStatData(lastEleFightParam.lastElementId)

			AtomicDungeonStatHelper.instance:sendElementInteractInfo(elementData)
		end
	end

	AtomicDungeonModel.instance:cleanLastElementFightParam()
	AtomicDungeonModel.instance:cleanFightResultData()
end

function AtomicDungeonSceneElements:setElementFinished()
	self:onNewMapUnlock()

	if not self.lastFightElementId or not self.elementCompMap[self.lastFightElementId] then
		return
	end

	local newUnlockMapList = AtomicDungeonModel.instance:getNewUnlockMapList()
	local isNewMapUnlock = AtomicDungeonModel.instance:checkNewUnlockDungeonMap()

	if #newUnlockMapList > 0 and isNewMapUnlock then
		self:playElementFinishAnim(self.lastFightElementId)
	else
		self:elementFinished(self.lastFightElementId)
	end
end

function AtomicDungeonSceneElements:onNewMapUnlock()
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()
	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	if isInPolygonState or isInMapSelectState then
		return
	end

	local newUnlockMapList = AtomicDungeonModel.instance:getNewUnlockMapList()

	if #newUnlockMapList == 0 then
		return
	end

	local isNewMapUnlock = AtomicDungeonModel.instance:checkNewUnlockDungeonMap()

	if not isNewMapUnlock then
		AtomicDungeonModel.instance:cleanNewUnlockMapList()

		return
	end

	self.dataBaseShowSequence = FlowSequence.New()

	local newUnlockDataBaseList = AtomicDungeonModel.instance:getNewUnlockDataBaseList()

	if #newUnlockDataBaseList > 0 then
		self.dataBaseShowSequence:addWork(AtomicCheckDataBaseToastShowWork.New())
	end

	self.dataBaseShowSequence:addWork(FunctionWork.New(AtomicDungeonSceneElements.doNewMapUnlock, {
		self,
		newUnlockMapList
	}))
	self.dataBaseShowSequence:addWork(TimerWork.New(WAIT_TIME * 0.5))
	self.dataBaseShowSequence:registerDoneListener(self.showNewElements, self)
	self.dataBaseShowSequence:start()
end

function AtomicDungeonSceneElements.doNewMapUnlock(params)
	local self, newUnlockMapList = params[1], params[2]
	local newUnlockMapId = newUnlockMapList[#newUnlockMapList]

	self.curMapId = AtomicDungeonModel.instance:getCurMapId()

	local oldElementList = AtomicDungeonModel.instance:getCurAllElementCoList(self.curMapId)
	local preMapUnFinishDataBaseAndEmergencyElementList = AtomicDungeonModel.instance:getPreMapUnFinishDataBaseAndEmergencyElementList()

	for _, elementCo in ipairs(oldElementList) do
		if not tabletool.indexOf(preMapUnFinishDataBaseAndEmergencyElementList, elementCo.id) then
			self:playElementFinishAnim(elementCo.id)
		end
	end

	if self.unlockMapFinishElementId then
		self:playElementFinishAnim(self.unlockMapFinishElementId)

		self.unlockMapFinishElementId = nil
	end

	local newMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(newUnlockMapId)
	local newMapInfoConfig = AtomicDungeonConfig.instance:getMapInfoConfig(newMapConfig.infoId)

	if newMapInfoConfig.type == AtomicDungeonEnum.MapType.Normal then
		AtomicDungeonModel.instance:setCurMapId(newUnlockMapId)

		self.curMapId = newUnlockMapId
	end
end

function AtomicDungeonSceneElements:removeUnExitElement()
	local elementCoList = AtomicDungeonModel.instance:getCurAllElementCoList(self.curMapId)
	local allKeyElementCoList = AtomicDungeonModel.instance:getCurCanShowKeyElementCoList(self.curMapId)
	local curMapConfig = AtomicDungeonConfig.instance:getDungeonMapConfig(self.curMapId)
	local preMapUnFinishDataBaseAndEmergencyElementList = AtomicDungeonModel.instance:getPreMapUnFinishDataBaseAndEmergencyElementList()

	for elementId, elementComp in pairs(self.elementCompMap) do
		local needRemove = true
		local elementMo = AtomicDungeonModel.instance:getElementMo(elementId)

		if tabletool.indexOf(preMapUnFinishDataBaseAndEmergencyElementList, elementId) then
			needRemove = false
		end

		for _, elementCo in ipairs(elementCoList) do
			if elementCo.id == elementId and elementCo.isEmergency == 1 and elementMo and not elementMo:showEmergency() then
				needRemove = true

				break
			end

			if elementCo.id == elementId then
				needRemove = false

				break
			end
		end

		for _, keyElementCo in ipairs(allKeyElementCoList) do
			if keyElementCo.id == elementId then
				needRemove = false
			end
		end

		if (elementComp.type == AtomicDungeonEnum.ElementType.PolygonEnter and elementComp.config.id == curMapConfig.arenaId or nil) and false then
			self:removeElement(elementId)
			self:removeArrow(elementId)
		end
	end
end

function AtomicDungeonSceneElements:removeAllElement()
	for elementId, elementComp in pairs(self.elementCompMap) do
		self:removeElement(elementId)
		self:removeArrow(elementId)
	end

	self:removeAllPolygonLine()
	self:cleanTween()
end

function AtomicDungeonSceneElements:removeElement(elementId)
	local elementComp = self.elementCompMap[elementId]

	if elementComp and elementComp.go then
		gohelper.destroy(elementComp.go)
	end

	self.elementCompMap[elementId] = nil

	local elementClick = self.elementClickMap[elementId]

	if elementClick then
		elementClick.btnClick:RemoveClickListener()
		gohelper.destroy(elementClick.go)
	end

	self.elementClickMap[elementId] = nil

	local elementDrag = self.elementDragMap[elementId]

	if elementDrag then
		elementDrag.drag:RemoveDragBeginListener()
		elementDrag.drag:RemoveDragListener()
		elementDrag.drag:RemoveDragEndListener()

		if elementDrag.click then
			elementDrag.click:RemoveClickListener()
		end

		gohelper.destroy(elementDrag.go)
	end

	self.elementDragMap[elementId] = nil
end

function AtomicDungeonSceneElements:addOrUpdateArrowItem(elementCo)
	local elementComp = self.elementCompMap[elementCo.id]

	if elementComp and elementComp:needShowArrow() then
		local arrowItem = self.elementArrowMap[elementCo.id]

		if not arrowItem then
			arrowItem = self:getUserDataTb_()

			local itemPath = self.viewContainer:getSetting().otherRes[3]

			arrowItem.go = self:getResInst(itemPath, self._goarrow, tostring(elementCo.id) .. "arrowItem")
			arrowItem.rotateGO = gohelper.findChild(arrowItem.go, "Image")
			arrowItem.arrowClick = gohelper.findChildButtonWithAudio(arrowItem.go, "click")

			arrowItem.arrowClick:AddClickListener(self.arrowItemClick, self, elementCo.id)

			local rotateX, rotateY, rotateZ = transformhelper.getLocalRotation(arrowItem.rotateGO.transform)

			arrowItem.initRotation = {
				rotateX,
				rotateY,
				rotateZ
			}
			self.elementArrowMap[elementCo.id] = arrowItem
		end

		self:updateArrowPos(elementCo.id)
	end
end

function AtomicDungeonSceneElements:updateAllArrowPos()
	for elementId, elementComp in pairs(self.elementCompMap) do
		self:updateArrowPos(elementId)
	end
end

function AtomicDungeonSceneElements:updateArrowPos(elementId)
	local isInPolygonState = AtomicDungeonModel.instance:getIsInPolygonState()
	local arrowItem = self.elementArrowMap[elementId]
	local elementComp = self.elementCompMap[elementId]

	if not arrowItem or not elementComp then
		return
	end

	if not isInPolygonState then
		gohelper.setActive(arrowItem.go, false)

		return
	end

	local elementTrans = elementComp.trans
	local viewPortPos = self.mainCamera:WorldToViewportPoint(elementTrans.position)
	local isInCameraView = viewPortPos.x >= 0 and viewPortPos.x <= 1 and viewPortPos.y >= 0 and viewPortPos.y <= 1 and viewPortPos.z > 0
	local isElementFinish = AtomicDungeonModel.instance:isElementFinish(elementId)

	gohelper.setActive(arrowItem.go, not isInCameraView and not isElementFinish)

	if isInCameraView or isElementFinish then
		return
	end

	local arrowPosRateX = Mathf.Clamp(viewPortPos.x, 0.02, 0.98)
	local arrowPosRateY = Mathf.Clamp(viewPortPos.y, 0.035, 0.965)
	local width = recthelper.getWidth(self._goarrow.transform)
	local height = recthelper.getHeight(self._goarrow.transform)

	recthelper.setAnchor(arrowItem.go.transform, width * (arrowPosRateX - 0.5), height * (arrowPosRateY - 0.5))

	if viewPortPos.x >= 0 and viewPortPos.x <= 1 then
		if viewPortPos.y < 0 then
			transformhelper.setLocalRotation(arrowItem.rotateGO.transform, arrowItem.initRotation[1], arrowItem.initRotation[2], arrowItem.initRotation[3] + 180)

			return
		elseif viewPortPos.y > 1 then
			transformhelper.setLocalRotation(arrowItem.rotateGO.transform, arrowItem.initRotation[1], arrowItem.initRotation[2], arrowItem.initRotation[3])

			return
		end
	end

	if viewPortPos.y >= 0 and viewPortPos.y <= 1 then
		if viewPortPos.x < 0 then
			transformhelper.setLocalRotation(arrowItem.rotateGO.transform, arrowItem.initRotation[1], arrowItem.initRotation[2], arrowItem.initRotation[3] + 90)

			return
		elseif viewPortPos.x > 1 then
			transformhelper.setLocalRotation(arrowItem.rotateGO.transform, arrowItem.initRotation[1], arrowItem.initRotation[2], arrowItem.initRotation[3] - 90)

			return
		end
	end

	local angle = Mathf.Atan2(viewPortPos.y, viewPortPos.x) * Mathf.Rad2Deg - 90

	transformhelper.setLocalRotation(arrowItem.rotateGO.transform, arrowItem.initRotation[1], arrowItem.initRotation[2], arrowItem.initRotation[3] + angle)
end

function AtomicDungeonSceneElements:arrowItemClick(elementId)
	self.curClickElement = nil

	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnFocusElement, elementId)
end

function AtomicDungeonSceneElements:removeArrow(elementId)
	local arrowItem = self.elementArrowMap[elementId]

	if arrowItem and arrowItem.go then
		arrowItem.arrowClick:RemoveClickListener()
		gohelper.destroy(arrowItem.go)

		self.elementArrowMap[elementId] = nil
	end
end

function AtomicDungeonSceneElements:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		local storyOptionParam = AtomicDungeonModel.instance:getStoryOptionParam()

		if storyOptionParam and storyOptionParam.optionId > 0 then
			local optionConfig = AtomicDungeonConfig.instance:getOptionConfig(storyOptionParam.optionId)

			if optionConfig and optionConfig.notFinish ~= 1 then
				local optionParam = {}

				optionParam.optionId = storyOptionParam.optionId

				AtomicRpc.instance:sendAtomicMapInteractRequest(storyOptionParam.elementId, optionParam)
				AtomicDungeonModel.instance:setStoryOptionParam(nil)
			end
		end
	elseif viewName == ViewName.AtomicDungeonPolygonSuccView then
		local navigateView = self.viewContainer:getNavigateButtonsView()

		navigateView:_btncloseOnClick()
	end

	local isInPolygon = AtomicDungeonModel.instance:getIsInPolygonState()
	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()
	local isMainViewInTop = ViewHelper.instance:checkViewOnTheTop(ViewName.AtomicDungeonMainView)

	if isMainViewInTop and not isInPolygon and not isInMapSelectState and viewName ~= ViewName.AtomicDungeonInteractView then
		self:restartEmergencyElementTime()
	end
end

function AtomicDungeonSceneElements:_onOpenViewFinish(viewName)
	local isInPolygon = AtomicDungeonModel.instance:getIsInPolygonState()

	if isInPolygon then
		return
	end

	local isMainViewInTop = ViewHelper.instance:checkViewOnTheTop(ViewName.AtomicDungeonMainView)

	if not isMainViewInTop and viewName ~= ViewName.AtomicDungeonInteractView then
		self:stopEmergencyElementTime()
	end
end

function AtomicDungeonSceneElements:stopEmergencyElementTime()
	for elementId, elementComp in pairs(self.elementCompMap) do
		local elementMo = AtomicDungeonModel.instance:getElementMo(elementId)

		if elementMo and elementMo.config.isEmergency == 1 and elementMo:showEmergency() then
			elementComp:stopAddEmergencyCurrentSeconds()
		end
	end

	TaskDispatcher.cancelTask(self.sendAddEmergencyCurrentSeconds, self)
	self:sendAddEmergencyCurrentSeconds()
end

function AtomicDungeonSceneElements:restartEmergencyElementTime()
	for elementId, elementComp in pairs(self.elementCompMap) do
		local elementMo = AtomicDungeonModel.instance:getElementMo(elementId)

		if elementMo and elementMo.config.isEmergency == 1 and elementMo:showEmergency() then
			elementComp:restartAddEmergencyCurrentSeconds()
		end
	end

	TaskDispatcher.cancelTask(self.sendAddEmergencyCurrentSeconds, self)
	TaskDispatcher.runRepeat(self.sendAddEmergencyCurrentSeconds, self, AtomicDungeonEnum.SendEmergencyAddSecondTime)
	self:sendAddEmergencyCurrentSeconds()
end

function AtomicDungeonSceneElements:sendAddEmergencyCurrentSeconds()
	local maxAddSeconds = 0
	local emergencyElementIdList = {}

	for elementId, elementComp in pairs(self.elementCompMap) do
		local elementMo = AtomicDungeonModel.instance:getElementMo(elementId)

		if elementMo and elementMo.config.isEmergency == 1 then
			maxAddSeconds = math.max(maxAddSeconds, elementMo.emergencyAddSeconds)

			elementMo:markSendingEmergencySeconds()
			table.insert(emergencyElementIdList, elementId)
		end
	end

	if #emergencyElementIdList == 0 or maxAddSeconds == 0 then
		if #emergencyElementIdList == 0 then
			TaskDispatcher.cancelTask(self.sendAddEmergencyCurrentSeconds, self)
		end

		return
	end

	AtomicRpc.instance:sendAtomicUpdateEmergencyTimeRequest(emergencyElementIdList, maxAddSeconds)
end

function AtomicDungeonSceneElements:onPolygonKeyElementPutFinish(elementId)
	local elementMo = AtomicDungeonModel.instance:getElementMo(elementId)
	local isAllKeyElementPut = elementMo:checkIsAllKeyElementPut()
	local isElementFinish = AtomicDungeonModel.instance:isElementFinish(elementId)

	if isAllKeyElementPut and not isElementFinish then
		AtomicRpc.instance:sendAtomicMapInteractRequest(elementId, {})

		local elementData = AtomicDungeonModel.instance:getElementStatData(elementId)

		AtomicDungeonStatHelper.instance:sendElementInteractInfo(elementData)
	end

	self:checkKeyElementFinish()
end

function AtomicDungeonSceneElements:checkKeyElementFinish()
	if self.curDragKeyElementId and self.curDragKeyElementId > 0 then
		local elementComp = self.elementCompMap[self.curDragKeyElementId]

		if elementComp and elementComp.iskey then
			local canShow = AtomicDungeonModel.instance:checkKeyElementCanShow(self.curDragKeyElementId)

			if not canShow then
				elementComp:playShowOrHideAnim(false)
				elementComp:setNameShowState(false)
				AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnPolygonKeyElementFinish, self.curDragKeyElementId)

				local elementDrag = self.elementDragMap[self.curDragKeyElementId]

				if elementDrag then
					gohelper.setActive(elementDrag.go, false)
				end

				local lineItemList = self.polygonLineListMap[self.curDragKeyElementId]

				for index, lineItem in pairs(lineItemList) do
					lineItem.comp:playHideAnim()
				end

				gohelper.setActive(self._goClickMask, true)
				TaskDispatcher.runDelay(self.removeCurDragKeyElemenet, self, WAIT_TIME)

				local elementData = AtomicDungeonModel.instance:getElementStatData(self.curDragKeyElementId)

				AtomicDungeonStatHelper.instance:sendElementInteractInfo(elementData)
			end
		end
	end
end

function AtomicDungeonSceneElements:removeCurDragKeyElemenet()
	self:removeElement(self.curDragKeyElementId)

	local lineItemList = self.polygonLineListMap[self.curDragKeyElementId]

	if lineItemList and #lineItemList > 0 then
		for _, lineItem in pairs(lineItemList) do
			gohelper.destroy(lineItem.go)
		end

		self.polygonLineListMap[self.curDragKeyElementId] = nil
	end

	self.curDragKeyElementId = nil

	gohelper.setActive(self._goClickMask, false)
end

function AtomicDungeonSceneElements:removeAllPolygonLine()
	for id, lineItemList in pairs(self.polygonLineListMap) do
		for _, lineItem in pairs(lineItemList) do
			gohelper.destroy(lineItem.go)
		end

		self.polygonLineListMap[id] = nil
	end
end

function AtomicDungeonSceneElements:cleanTween()
	for id, lineItemList in pairs(self.polygonLineListMap) do
		for _, lineItem in pairs(lineItemList) do
			lineItem.comp:cleanTween()
		end
	end
end

function AtomicDungeonSceneElements:onDisposeOldMap()
	self.nextElementId = nil

	self:removeAllElement()
	self:stopShowElementsSequence()

	self.elementRootMap = self:getUserDataTb_()
end

function AtomicDungeonSceneElements:onDestroyView()
	self:stopEmergencyElementTime()
	self:removeAllElement()
	AtomicDungeonModel.instance:setCanClickElementState(true)

	local isInMapSelectState = AtomicDungeonModel.instance:getIsInMapSelectState()

	if not isInMapSelectState then
		AtomicDungeonModel.instance:cleanNewElements()
	end

	TaskDispatcher.cancelTask(self.removeUnExitElement, self)
	TaskDispatcher.cancelTask(self.addElements, self)
	TaskDispatcher.cancelTask(self.setElementFinished, self)
	TaskDispatcher.cancelTask(self.realClickElement, self)
	TaskDispatcher.cancelTask(self.removeCurDragKeyElemenet, self)
	TaskDispatcher.cancelTask(self.sendAddEmergencyCurrentSeconds, self)
	AtomicDungeonModel.instance:cleanNewUnlockMapList()
	AtomicDungeonModel.instance:cleanNewUnlockDataBaseList()
	self:cleanShowSequence()
	self:cleanDataBaseSequence()
end

function AtomicDungeonSceneElements:cleanShowSequence()
	if self.showSequence then
		self.showSequence:unregisterDoneListener(self.stopShowElementsSequence, self)
		self.showSequence:destroy()

		self.showSequence = nil
	end
end

function AtomicDungeonSceneElements:cleanDataBaseSequence()
	if self.dataBaseShowSequence then
		self.dataBaseShowSequence:unregisterDoneListener(self.showNewElements, self)
		self.dataBaseShowSequence:destroy()

		self.dataBaseShowSequence = nil
	end

	self.unlockMapFinishElementId = nil
end

return AtomicDungeonSceneElements
