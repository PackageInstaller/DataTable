-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonSceneElements.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonSceneElements", package.seeall)

local OdysseyDungeonSceneElements = class("OdysseyDungeonSceneElements", BaseView)
local WAIT_TIME = 0.5

function OdysseyDungeonSceneElements:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._screenClick = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)
	self._goarrow = gohelper.findChild(self.viewGO, "root/#go_arrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonSceneElements:addEvents()
	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	end

	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnInitElements, self.initElements, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementArrow, self.updateAllArrowPos, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnElementFinish, self.elementFinished, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.CreateNewElement, self.showNewElements, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.PlayElementAnim, self.playElementAnim, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
end

function OdysseyDungeonSceneElements:removeEvents()
	self.removeEventCb(self, GamepadController.instance, GamepadEvent.KeyDown, self.onGamepadKeyDown, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnInitElements, self.initElements, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnUpdateElementArrow, self.updateAllArrowPos, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnElementFinish, self.elementFinished, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, self.onDisposeOldMap, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.CreateNewElement, self.showNewElements, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.PlayElementAnim, self.playElementAnim, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self._screenClick:RemoveClickUpListener()
end

function OdysseyDungeonSceneElements:onElementClickDown(element)
	self.curClickElement = element
end

function OdysseyDungeonSceneElements:onScreenClickUp(delayClick)
	local isDraggingMap = OdysseyDungeonModel.instance:getDraggingMapState()

	if not self.curClickElement or isDraggingMap then
		return
	end

	local clickElemenet = self.curClickElement
	local isFinish = OdysseyDungeonModel.instance:isElementFinish(clickElemenet.config.id)

	if isFinish or gohelper.isNil(clickElemenet.go) then
		return
	end

	TaskDispatcher.cancelTask(self.realClickElement, self)

	if delayClick then
		TaskDispatcher.runDelay(self.realClickElement, self, 0.3)
	else
		self:realClickElement()
	end
end

function OdysseyDungeonSceneElements:realClickElement()
	local clickElemenet = self.curClickElement

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnClickElement, clickElemenet)

	self.curClickElement = nil

	if not self.curHeroPosElementCo or self.curHeroPosElementCo.id ~= clickElemenet.config.id then
		self:setHeroItemPos(clickElemenet.config)
		self:playShowOrHideHeroAnim(true, clickElemenet.config.id)
		OdysseyRpc.instance:sendOdysseyMapSetCurrElementRequest(clickElemenet.config.id)
	end

	OdysseyDungeonController.instance:openDungeonInteractView(clickElemenet)
end

function OdysseyDungeonSceneElements:onGamepadKeyDown(key)
	if key ~= GamepadEnum.KeyCode.A then
		return
	end

	local screenPos = GamepadController.instance:getScreenPos()
	local ray = CameraMgr.instance:getMainCamera():ScreenPointToRay(screenPos)
	local allRaycastHit = UnityEngine.Physics2D.RaycastAll(ray.origin, ray.direction)
	local maxIndex = allRaycastHit.Length - 1

	for i = 0, maxIndex do
		local hitInfo = allRaycastHit[i]
		local comp = MonoHelper.getLuaComFromGo(hitInfo.transform.parent.gameObject, OdysseyDungeonElement)

		if comp then
			comp:onClickDown()
		end
	end
end

function OdysseyDungeonSceneElements:_editableInitView()
	self.elementCompMap = self:getUserDataTb_()
	self.elementRootMap = self:getUserDataTb_()
	self.elementArrowMap = self:getUserDataTb_()
	self.curHeroPosElementCo = nil
	self.mainCamera = CameraMgr.instance:getMainCamera()
end

function OdysseyDungeonSceneElements:initElements(elementsRootGO)
	self._screenClick:AddClickUpListener(self.onScreenClickUp, self)

	self.curMapId = OdysseyDungeonModel.instance:getCurMapId()
	self.elementsRootGO = elementsRootGO

	local rootGO = gohelper.findChild(self.elementsRootGO, "root")

	self.rootScale = transformhelper.getLocalScale(rootGO.transform)
	self.heroItem = gohelper.findChild(self.elementsRootGO, "root/hero/#go_heroItem")
	self.animHeroItem = self.heroItem:GetComponent(typeof(UnityEngine.Animator))

	for type, rootPath in pairs(OdysseyEnum.ElementTypeRoot) do
		self.elementRootMap[type] = self.elementRootMap[type] or gohelper.findChild(self.elementsRootGO, "root/" .. rootPath)
	end

	self:removeAllElement()
	TaskDispatcher.cancelTask(self.addElements, self)

	local lastEleFightParam = OdysseyDungeonModel.instance:getLastElementFightParam()
	local curFightEpisodeId = OdysseyDungeonModel.instance:getCurFightEpisodeId()

	if lastEleFightParam and lastEleFightParam.lastElementId > 0 and curFightEpisodeId ~= lastEleFightParam.lastEpisodeId then
		local lastElementCo = OdysseyConfig.instance:getElementConfig(lastEleFightParam.lastElementId)
		local newElements = OdysseyDungeonModel.instance:getNewElementList()

		if lastElementCo and lastElementCo.isPermanent ~= 1 and #newElements > 0 then
			TaskDispatcher.runDelay(self.addElements, self, 1.5)
		else
			self:addElements()
		end
	else
		self:addElements()
	end

	self:cleanLastFightElementAndJumpNext()

	local curHeroInElementId = OdysseyDungeonModel.instance:getCurInElementId()

	if curHeroInElementId > 0 then
		local curInElementCo = OdysseyConfig.instance:getElementConfig(curHeroInElementId)

		gohelper.setActive(self.heroItem, curInElementCo and curInElementCo.mapId == self.curMapId)

		if curInElementCo.mapId == self.curMapId then
			self:setHeroItemPos(curInElementCo)
			self:playShowOrHideHeroAnim(true)
		end
	else
		gohelper.setActive(self.heroItem, true)

		local mapConfig = OdysseyConfig.instance:getDungeonMapConfig(self.curMapId)
		local posParam = string.splitToNumber(mapConfig.initPos, "#")

		if not -(posParam[1] / self.rootScale) then
			local heroPosX = 0

			if not -(posParam[2] / self.rootScale) then
				local heroPosY = 0

				transformhelper.setLocalPos(self.heroItem.transform, heroPosX, heroPosY, 0)
			end
		end
	end
end

function OdysseyDungeonSceneElements:addElements()
	local elementCoList = OdysseyDungeonModel.instance:getCurAllElementCoList(self.curMapId)

	for _, elementCo in ipairs(elementCoList) do
		self:addOrUpdateElement(elementCo)
		self:addOrUpdateArrowItem(elementCo)
	end
end

function OdysseyDungeonSceneElements:addOrUpdateElement(elementCo)
	local elementComp = self.elementCompMap[elementCo.id]

	if not elementComp then
		local elementPrefabUrl = self.viewContainer:getSetting().otherRes[1]
		local go = self.viewContainer:getResInst(elementPrefabUrl, self.elementRootMap[elementCo.type], tostring(elementCo.id))

		elementComp = MonoHelper.addLuaComOnceToGo(go, OdysseyDungeonElement, {
			elementCo,
			self
		})

		elementComp:playShowOrHideAnim(true)
	else
		local elementRoot = self.elementRootMap[elementCo.type]

		gohelper.addChild(elementRoot, elementComp.go)
		elementComp:updateInfo()
	end

	self.elementCompMap[elementCo.id] = elementComp
end

function OdysseyDungeonSceneElements:addOrUpdateArrowItem(elementCo)
	local elementComp = self.elementCompMap[elementCo.id]

	if elementComp and elementComp:needShowArrow() then
		local arrowItem = self.elementArrowMap[elementCo.id]

		if not arrowItem then
			arrowItem = self:getUserDataTb_()

			local itemPath = self.viewContainer:getSetting().otherRes[2]

			arrowItem.go = self:getResInst(itemPath, self._goarrow, tostring(elementCo.id) .. "arrowItem")
			arrowItem.rotateGO = gohelper.findChild(arrowItem.go, "icon/arrow")
			arrowItem.arrowClick = gohelper.findChildButtonWithAudio(arrowItem.go, "click")

			arrowItem.arrowClick:AddClickListener(self.arrowItemClick, self, elementCo.id)

			local rotateX, rotateY, rotateZ = transformhelper.getLocalRotation(arrowItem.rotateGO.transform)

			arrowItem.initRotation = {
				rotateX,
				rotateY,
				rotateZ
			}
			arrowItem.elementItemIcon = gohelper.findChild(arrowItem.go, "icon/elementItemIcon")
			arrowItem.optionItem = gohelper.findChild(arrowItem.elementItemIcon, "optionItem")
			arrowItem.optionItemIcon = gohelper.findChildImage(arrowItem.elementItemIcon, "optionItem/#image_optionIcon")
			arrowItem.dialogItem = gohelper.findChild(arrowItem.elementItemIcon, "dialogItem")
			arrowItem.dialogItemIcon = gohelper.findChildSingleImage(arrowItem.elementItemIcon, "dialogItem/#image_dialogHero")
			arrowItem.fightItem = gohelper.findChild(arrowItem.elementItemIcon, "fightItem")
			arrowItem.fightItemIcon = gohelper.findChildImage(arrowItem.elementItemIcon, "fightItem/#image_fightIcon")
			self.elementArrowMap[elementCo.id] = arrowItem
		end

		self:updateArrowPos(elementCo.id)
		self:updateArrowElementIcon(arrowItem, elementCo)
	end
end

function OdysseyDungeonSceneElements:updateArrowElementIcon(arrowItem, elementCo)
	local elementType = elementCo.type

	for type, root in pairs(OdysseyEnum.ElementTypeRoot) do
		gohelper.setActive(arrowItem[root .. "Item"], elementType == type)
	end

	if elementType == OdysseyEnum.ElementType.Option then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arrowItem.optionItemIcon, elementCo.icon)
	elseif elementType == OdysseyEnum.ElementType.Dialog then
		arrowItem.dialogItemIcon:LoadImage(ResUrl.getRoomHeadIcon(elementCo.icon))
	elseif elementType == OdysseyEnum.ElementType.Fight then
		UISpriteSetMgr.instance:setSp01OdysseyDungeonElementSprite(arrowItem.fightItemIcon, elementCo.icon)
	end
end

function OdysseyDungeonSceneElements:updateAllArrowPos()
	for elementId, elementComp in pairs(self.elementCompMap) do
		self:updateArrowPos(elementId)
	end
end

function OdysseyDungeonSceneElements:updateArrowPos(elementId)
	local arrowItem = self.elementArrowMap[elementId]
	local elementComp = self.elementCompMap[elementId]

	if not arrowItem or not elementComp then
		return
	end

	local elementTrans = elementComp.trans
	local viewPortPos = self.mainCamera:WorldToViewportPoint(elementTrans.position)
	local isInCameraView = viewPortPos.x >= 0 and viewPortPos.x <= 1 and viewPortPos.y >= 0 and viewPortPos.y <= 1 and viewPortPos.z > 0

	gohelper.setActive(arrowItem.go, not isInCameraView)

	if isInCameraView then
		return
	end

	local arrowPosRateX = Mathf.Clamp(viewPortPos.x, 0.0416, 0.958)
	local arrowPosRateY = Mathf.Clamp(viewPortPos.y, 0.074, 0.926)
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

function OdysseyDungeonSceneElements:getElemenetComp(elementId)
	return self.elementCompMap[elementId]
end

function OdysseyDungeonSceneElements:arrowItemClick(elementId)
	self.curClickElement = nil

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, elementId)
end

function OdysseyDungeonSceneElements:setHeroItemPos(elementConfig)
	if self.heroItem then
		gohelper.setActive(self.heroItem, true)

		local elementPos = string.splitToNumber(elementConfig.pos, "#")
		local heroPosOffset = string.splitToNumber(elementConfig.heroPos, "#")
		local curHeroItemPos = {
			elementPos[1] + heroPosOffset[1],
			elementPos[2] + heroPosOffset[2],
			elementPos[3]
		}

		transformhelper.setLocalPos(self.heroItem.transform, curHeroItemPos[1], curHeroItemPos[2], curHeroItemPos[3])

		self.curHeroPosElementCo = elementConfig
	end
end

function OdysseyDungeonSceneElements:playShowOrHideHeroAnim(show, elementId)
	local curHeroInElementId = OdysseyDungeonModel.instance:getCurInElementId()

	if show and elementId == curHeroInElementId then
		self.animHeroItem:Play("idle", 0, 0)
		self.animHeroItem:Update(0)

		return
	end

	self.animHeroItem:Play(show and "open" or "close", 0, 0)

	if show then
		AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_disp)
	end
end

function OdysseyDungeonSceneElements:elementFinished(finishElementId)
	local isElementFinish = OdysseyDungeonModel.instance:isElementFinish(finishElementId)

	if isElementFinish then
		local needShowRewardView = OdysseyDungeonController.instance:checkNeedPopupRewardView()

		if not needShowRewardView then
			self:playHeroItemFadeAnim(finishElementId)
		end

		self:playElementFinishAnim(finishElementId)
		self:showNewElements()
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.RefreshDungeonView)
	end
end

function OdysseyDungeonSceneElements:showNewElements(notAutoOpen)
	self.notAutoOpenElement = notAutoOpen

	local newElements = OdysseyDungeonModel.instance:getNewElementList()

	if not newElements or #newElements == 0 then
		TaskDispatcher.cancelTask(self.removeUnExitElement, self)
		TaskDispatcher.runDelay(self.removeUnExitElement, self, WAIT_TIME)

		return
	end

	local curNewElementList = {}

	for index, elementCo in ipairs(newElements) do
		if elementCo.mapId == self.curMapId then
			table.insert(curNewElementList, elementCo)
		end
	end

	self:showNewElementsAnim(curNewElementList)

	if OdysseyDungeonModel.instance:checkHasFightTypeElement(OdysseyEnum.FightType.Myth) then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.MythUnlockGuide)
	end

	OdysseyDungeonModel.instance:cleanNewElements()
end

function OdysseyDungeonSceneElements:showNewElementsAnim(curNewElementList)
	if #curNewElementList == 0 then
		return
	end

	local normalElementList = {}

	self.animElementList = {}

	for index, elementCo in ipairs(curNewElementList) do
		if elementCo.needFollow == OdysseyEnum.DungeonElementNeedFollow then
			table.insert(self.animElementList, elementCo)
			self:addOrUpdateArrowItem(elementCo)
		else
			table.insert(normalElementList, elementCo)
			self:addOrUpdateElement(elementCo)
			AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_icons)
		end
	end

	TaskDispatcher.cancelTask(self.removeUnExitElement, self)
	TaskDispatcher.runDelay(self.removeUnExitElement, self, WAIT_TIME)

	if #self.animElementList == 0 then
		return
	end

	table.sort(self.animElementList, OdysseyDungeonSceneElements.sortElementList)

	self.showSequence = FlowSequence.New()

	self.showSequence:addWork(TimerWork.New(WAIT_TIME))

	for _, elementCo in ipairs(self.animElementList) do
		self.showSequence:addWork(FunctionWork.New(OdysseyDungeonSceneElements.addNewElement, {
			self,
			elementCo
		}))
		self.showSequence:addWork(TimerWork.New(WAIT_TIME))
	end

	self.nextElementId = self.animElementList[1].id

	self.showSequence:addWork(OdysseyCheckCloseRewardWork.New(self.nextElementId, true))
	self.showSequence:registerDoneListener(self.stopShowElementsSequence, self)
	self.showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(OdysseyEnum.BlockKey.FocusNewElement)
end

function OdysseyDungeonSceneElements.sortElementList(elementCoA, elementCoB)
	return elementCoA.id < elementCoB.id
end

function OdysseyDungeonSceneElements.addNewElement(params)
	local self, elementCo = params[1], params[2]

	self:addOrUpdateElement(elementCo)
	self:addOrUpdateArrowItem(elementCo)
end

function OdysseyDungeonSceneElements.doFocusElement(params)
	local self, elementId, isForceFocus = params[1], params[2], params[3]

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusElement, elementId, isForceFocus)
end

function OdysseyDungeonSceneElements:stopShowElementsSequence()
	if self.showSequence then
		self.showSequence:unregisterDoneListener(self.stopShowElementsSequence, self)
		self.showSequence:destroy()

		self.showSequence = nil
	end

	UIBlockMgr.instance:endBlock(OdysseyEnum.BlockKey.FocusNewElement)

	if self.nextElementId then
		local elementComp = self.elementCompMap[self.nextElementId]

		if elementComp and not self.notAutoOpenElement then
			self.curClickElement = elementComp

			local isNotOpenGuiding = GuideModel.instance:isGuideRunning(OdysseyEnum.NotOpenInteractWithGuideId)

			if not isNotOpenGuiding then
				self:onScreenClickUp(true)
			end
		end

		self.nextElementId = nil
	end
end

function OdysseyDungeonSceneElements:_onCloseView(viewName)
	if viewName == ViewName.StoryView then
		local storyOptionParam = OdysseyDungeonModel.instance:getStoryOptionParam()

		if storyOptionParam and storyOptionParam.optionId > 0 then
			local optionConfig = OdysseyConfig.instance:getOptionConfig(storyOptionParam.optionId)

			if optionConfig and optionConfig.notFinish ~= OdysseyEnum.ElementOptionNotFinish then
				local optionParam = {}

				optionParam.optionId = storyOptionParam.optionId

				OdysseyRpc.instance:sendOdysseyMapInteractRequest(storyOptionParam.elementId, storyOptionParam)
				OdysseyDungeonModel.instance:setStoryOptionParam(nil)
			end
		end
	end
end

function OdysseyDungeonSceneElements:playElementFinishAnim(elementId)
	local elementComp = self.elementCompMap[elementId]

	if elementComp then
		elementComp:playShowOrHideAnim(false)
		self:removeArrow(elementId)
	end
end

function OdysseyDungeonSceneElements:playHeroItemFadeAnim(elementId)
	local curHeroInElementId = OdysseyDungeonModel.instance:getCurInElementId()

	if self:checkHasNeedFollowNewElemenet() and elementId == curHeroInElementId then
		self:playShowOrHideHeroAnim(false)
	end
end

function OdysseyDungeonSceneElements:playElementAnim(elementId, animName)
	for _, elementComp in pairs(self.elementCompMap) do
		elementComp:playAnim(OdysseyEnum.ElementAnimName.Idle)
	end

	local elementComp = self.elementCompMap[elementId]

	if elementComp then
		elementComp:playAnim(animName)
	end
end

function OdysseyDungeonSceneElements:checkHasNeedFollowNewElemenet()
	local newElements = OdysseyDungeonModel.instance:getNewElementList()

	for index, elementCo in ipairs(newElements) do
		if elementCo.mapId == self.curMapId and elementCo.needFollow == OdysseyEnum.DungeonElementNeedFollow then
			return true
		end
	end

	return false
end

function OdysseyDungeonSceneElements:cleanLastFightElementAndJumpNext()
	self.lastFightElementId = nil

	local lastEleFightParam = OdysseyDungeonModel.instance:getLastElementFightParam()

	if lastEleFightParam and lastEleFightParam.lastElementId > 0 then
		local elementCo = OdysseyConfig.instance:getElementConfig(lastEleFightParam.lastElementId)
		local isElementFinish = OdysseyDungeonModel.instance:isElementFinish(lastEleFightParam.lastElementId)

		if not isElementFinish or elementCo.isPermanent == 1 then
			local elementComp = self.elementCompMap[lastEleFightParam.lastElementId]

			if elementComp then
				self.curClickElement = elementComp

				self:onScreenClickUp()
			end
		else
			self.lastFightElementId = elementCo.id

			self:addOrUpdateElement(elementCo)
			TaskDispatcher.runDelay(self.setElementFinished, self, 1)
		end
	end

	TaskDispatcher.runDelay(self.playSubTaskFinishEffect, self, 1)
	OdysseyDungeonModel.instance:cleanLastElementFightParam()
end

function OdysseyDungeonSceneElements:playSubTaskFinishEffect()
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.PlaySubTaskFinishEffect)
end

function OdysseyDungeonSceneElements:setElementFinished()
	if not self.lastFightElementId and self.elementCompMap[self.lastFightElementId] then
		return
	end

	self:elementFinished(self.lastFightElementId)
end

function OdysseyDungeonSceneElements:removeAllElement()
	for elementId, elementComp in pairs(self.elementCompMap) do
		self:removeElement(elementId)
		self:removeArrow(elementId)
	end
end

function OdysseyDungeonSceneElements:removeUnExitElement()
	local elementCoList = OdysseyDungeonModel.instance:getCurAllElementCoList(self.curMapId)

	for elementId, elementComp in pairs(self.elementCompMap) do
		local needRemove = true

		for _, elementCo in ipairs(elementCoList) do
			if elementCo.id == elementId then
				needRemove = false

				break
			end
		end

		if needRemove then
			self:removeElement(elementId)
			self:removeArrow(elementId)
		end
	end
end

function OdysseyDungeonSceneElements:removeElement(elementId)
	local elementComp = self.elementCompMap[elementId]

	if elementComp and elementComp.go then
		gohelper.destroy(elementComp.go)
	end

	self.elementCompMap[elementId] = nil
end

function OdysseyDungeonSceneElements:removeArrow(elementId)
	local arrowItem = self.elementArrowMap[elementId]

	if arrowItem and arrowItem.go then
		arrowItem.arrowClick:RemoveClickListener()
		arrowItem.dialogItemIcon:UnLoadImage()
		gohelper.destroy(arrowItem.go)

		self.elementArrowMap[elementId] = nil
	end
end

function OdysseyDungeonSceneElements:onDisposeOldMap()
	self.nextElementId = nil

	self:removeAllElement()
	self:stopShowElementsSequence()

	self.elementRootMap = self:getUserDataTb_()
end

function OdysseyDungeonSceneElements:onClose()
	self:onDisposeOldMap()
	TaskDispatcher.cancelTask(self.showNewElements, self)
	TaskDispatcher.cancelTask(self.setElementFinished, self)
	TaskDispatcher.cancelTask(self.realClickElement, self)
	TaskDispatcher.cancelTask(self.playSubTaskFinishEffect, self)
	TaskDispatcher.cancelTask(self.removeUnExitElement, self)
	TaskDispatcher.cancelTask(self.addElements, self)
end

function OdysseyDungeonSceneElements:onDestroyView()
	self:removeAllElement()
end

return OdysseyDungeonSceneElements
