-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/comp/SpineInterfaceComp.lua

module("logic.extensions.spineinterface.comp.SpineInterfaceComp", package.seeall)

local SpineInterfaceComp = class("SpineInterfaceComp")

function SpineInterfaceComp:ctor()
	self._boxSlotList = {}
	self._boxAtts = {}
	self._boxWorldVertices = {}
	self._boxVectors = {}
	self._boxSlotIndexs = {}
	self._boxAttNames = {}
	self._fmodEvtInst = {}
	self._skinId = 0
	self._spineCtrl = SimpleSpineCtrl.New()
	self._spineLoadHelp = SpineLoadHelp.New()
	self._pointerInfo = MsPointerInfo.New()
	self._paramMoMgr = MsParamMoMgr.New()
	self._memberMoMgr = MsSpineMemberMoMgr.New()
	self._fsmComp = MsFsmComp.New()
	self._fsmList = {}
	self._elapseSeconds = 0
	self._realElapseSeconds = 0
	self._spineParamHasUpdateMarkList = {}
	self._trackIndexsOfUsing = {}

	self:_resetForbidOp()

	self._isLoadSpine = false
	self._isHostSuspended = false
	self._multiLoader = MultiResLoader.New()
	self._motionMoQueue = {}
	self._interactionSession = SpineInteractionSession.New(self)
	self._uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	self._uiCanvas = GlobalModel.instance.uiCanvas
	self._mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	self._uiScale = self._uiCanvas.referencePixelsPerUnit
	self._uiCanvasTran = GlobalModel.instance.uiCanvas:GetComponent(goutil.Type_RectTransform)
	self._boundingBoxAttachmentType = SystemReflexHelp.getType("Spine.BoundingBoxAttachment")
	self._singleType = SystemReflexHelp.getType("System.Single")
	self._showObjTimersInfo = {}
	self._boneBinder = SpineBoneBinder.New()
end

function SpineInterfaceComp.add(compRoot)
	local comp = Framework.LuaComponentContainer.Add(compRoot, SpineInterfaceComp)

	comp:_onInit(compRoot)

	return comp
end

function SpineInterfaceComp.getOrAdd(comp, compRoot)
	comp = comp or SpineInterfaceComp.add(compRoot)

	return comp
end

function SpineInterfaceComp.reloadSpineGo(comp, compRoot, skinId, spineGo, spineGoRect, camera)
	comp = SpineInterfaceComp.getOrAdd(comp, compRoot)

	comp:onReloadSpine(spineGo, spineGoRect, skinId, camera)

	return comp
end

function SpineInterfaceComp.reloadPhotoShow(comp, compRoot, photoShow, requireShowLihui)
	comp = SpineInterfaceComp.getOrAdd(comp, compRoot)

	if photoShow then
		if not photoShow._raceId then
			local skinId = 0

			if photoShow and (not requireShowLihui or photoShow._showLihui) then
				local spineGo = photoShow._role
				local spineGoRect = photoShow._go:GetComponent(goutil.Type_RectTransform)
				local camera = photoShow._photoEffect._photo.producer.rtCamera

				comp:onReloadSpine(spineGo, spineGoRect, skinId, camera)
			end

			return comp, skinId
		end
	end
end

function SpineInterfaceComp:_onInit(compRoot)
	self._compRoot = compRoot

	local triggerGo = self._compRoot

	if triggerGo then
		self._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onBeginDragHandler(_go, eventData)
		end)
		self._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onEndDragHandler(_go, eventData)
		end)
		self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDragHandler(_go, eventData)
		end)
		self._pointerClickHandler = PointerClickHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onPointerClickHandler(_go, eventData)
		end)
		self._pointerDownHandler = PointerDownHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onPointerDownHandler(_go, eventData)
		end)
		self._pointerUpHandler = PointerUpHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onPointerUpHandler(_go, eventData)
		end)
	end

	GlobalDispatcher:addListener(GlobalNotify.SpineInterFaceBoundingBoxDrawUi, self._handleSwitchBoundingBoxDrawUi, self)
	GlobalDispatcher:addListener(GlobalNotify.SpineInterFaceEventNotifyDoMotions, self._spineInterFaceEventNotifyDoMotions, self)

	self._DOUBLE_CLICK_TIME = 0.2
	self._PRESS_TIME = 0.3
	self._currDonwTime = 0
	self._isPointDown = false
	self._isPress = false
	self._clickCount = 0
	self._onUpEventData = nil
	self._isDragging = false
end

function SpineInterfaceComp:onClear()
	self._elapseSeconds = 0
	self._realElapseSeconds = 0

	self:onUnReloadSpine()
end

function SpineInterfaceComp:_spineInterFaceEventNotifyDoMotions(skinId, behaviorLayerId, behaviorId)
	if not self:isSpineReloaded() or self._skinId ~= skinId then
		return
	end

	self:_resetForbidOp()
	self:_checkTrigger(MsEnum.TriggerType_EventNotify, nil, behaviorLayerId, behaviorId)
end

function SpineInterfaceComp:notifyInteraction(eventName, finishCallback)
	if not self:isSpineReloaded() then
		printError(string.format("spineinterface notifyInteraction before loaded, eventName = %s", eventName))

		return false
	end

	local behavior = SpineInterfaceController.instance:getInteractionBehavior(self._skinId, eventName)

	if behavior == nil then
		return false
	end

	if self._interactionSession == nil then
		return false
	end

	self:_resetForbidOp()

	local isTriggered = self._interactionSession:notifyInteraction(behavior.behaviorLayerId, behavior.behaviorId, finishCallback)

	if not isTriggered then
		printError(string.format("spineinterface interaction target state is not active, skinId = %s, eventName = %s, behaviorLayerId = %s, behaviorId = %s", self._skinId, eventName, behavior.behaviorLayerId, behavior.behaviorId))
	end

	return isTriggered
end

function SpineInterfaceComp:getSkinId()
	return self._skinId
end

function SpineInterfaceComp:_handleSceneResolutionChange()
	self:_updateRectFullScreenSize()
end

function SpineInterfaceComp:Update()
	self._elapseSeconds, self._realElapseSeconds = Time.deltaTime, Time.unscaledDeltaTime

	if not self:isSpineReloaded() then
		return
	end

	self._pointerInfo:onUpdate(self._elapseSeconds, self._realElapseSeconds)

	local isDo = false

	for paramId, isHas in pairs(self._spineParamHasUpdateMarkList) do
		if isHas then
			self._memberMoMgr:setMemberValue(paramId, self._paramMoMgr:getParamValue(MsEnum.ParamMgrType.Spine, paramId))

			isDo = true
		end
	end

	if isDo then
		self:_clearSpineParamHasUpdateMarkList()
	end

	local spineParamMoList = self._paramMoMgr:getParamMoList(MsEnum.ParamMgrType.Spine)

	if spineParamMoList then
		for paramId, paramMo in ipairs(spineParamMoList) do
			local memberValue = self._memberMoMgr:getMemberValue(paramId)

			paramMo:setValue(memberValue)
		end
	end

	self._fsmComp:onUpdate(self._elapseSeconds, self._realElapseSeconds)

	if self:_isForbidOp() == false then
		if BagPetSkinController.instance:getAutoSkipStartAni() then
			local key = string.format("PJAQM_SKIN_ENTER_PLAYED_%s", self._skinId)
			local isDone = GameUtil.getUserDayData(key)

			if checknumber(isDone) == 0 then
				GameUtil.saveUserDayData(key, 1)
				self:_checkTrigger(MsEnum.TriggerEvent_LimitEnterState)
			end
		else
			self:_checkTrigger(MsEnum.TriggerEvent_LimitEnterState)
		end

		self:_checkTrigger(MsEnum.TriggerEvent_EnterState)
	end

	if self:_isForbidOp() == false then
		self:_checkTrigger(MsEnum.TriggerEvent_Timer)
	end

	if self:_isForbidOp() == false then
		local state

		for _, fsm in ipairs(self._fsmList) do
			state = fsm:getCurState()
			self._temp_nextStateId = state:getNextStateId()
			self._temp_condValidator = state:getCondValidator()
			self._temp_isFitCond = false

			if self._temp_nextStateId ~= nil then
				if state:isNeedToNextState() then
					state:setIsNeedToNextState(false)

					self._temp_isFitCond = true
				elseif not string.nilorempty(self._temp_condValidator) then
					self._temp_isFitCond = GameUtil.expScript(self._temp_condValidator, function(str)
						return self:_isEnoughParam(str)
					end)
				end
			end

			if self._temp_isFitCond then
				local fsmId = state:getFsmId()
				local fitFsm

				for _, fsm in ipairs(self._fsmList) do
					if fsmId == fsm:getFsmId() then
						fitFsm = fsm

						break
					end
				end

				if fitFsm then
					fitFsm:changeState(self._temp_nextStateId)
				else
					printError(string.format("behavior change, but fsm not found, fsmId = %s", fsmId))
				end
			end
		end
	end

	local publicParamMoList = self._paramMoMgr:getParamMoList(MsEnum.ParamMgrType.Public)

	if publicParamMoList then
		for paramId, paramMo in ipairs(publicParamMoList) do
			if paramMo:getDataType() == MsEnum.DataType.Trigger then
				paramMo:setValue(false)
			end
		end
	end

	if self._isPointDown and self._onDownEventData and not self._onDownEventData.dragging and Time.unscaledTime - self._currDonwTime >= self._PRESS_TIME then
		self._isPress = true
		self._currDonwTime = Time.unscaledTime
	end

	if self._clickCount == 1 and not self._isPress and Time.unscaledTime - self._currDonwTime >= Mathf.Max(self._PRESS_TIME, self._DOUBLE_CLICK_TIME) then
		if self._onUpEventData and not self._onUpEventData.dragging and not self._isDragging then
			self:_checkTrigger(MsEnum.TriggerEvent_PointerClick, self._onUpEventData, MsEnum.TriggerType_PointerClickSingle)
		end

		self._onUpEventData = nil
		self._onDownEventData = nil
		self._clickCount = 0
		self._isDragging = false
	end

	self:_tryTriggerDoMotionQueue()
	self._boneBinder:onUpdate()

	for animName, info in pairs(self._showObjTimersInfo) do
		if not info.isEnd then
			if info.curTicks < #info.showObjsTicks then
				info.curTimeSec = info.curTimeSec + self._elapseSeconds

				local tick = info.curTicks + 1
				local tickTime = info.showObjsTicks[tick]
				local isShow = tickTime >= 0

				if info.curTimeSec >= math.abs(checknumber(tickTime)) then
					info.curTicks = tick

					for _, v in ipairs(info.showObjs) do
						local obj = goutil.findChild(self._spineGo, v)

						GameUtil.SetActive(obj, isShow)
					end
				end
			end
		else
			self._showObjTimersInfo[animName] = nil
		end
	end

	if self._isNeedBoundingBoxDrawUi then
		if self._loadDrawUiSlotList then
			for idx = #self._loadDrawUiSlotList, 1, -1 do
				local slot = self._loadDrawUiSlotList[idx]

				if self._drawInfoPool[slot] == nil then
					local isSuccess = self:_createDrawInfo(slot)

					if isSuccess then
						self._loadDrawUiSlotList[idx] = nil
					end
				end
			end
		end

		self:_updateBoundingBoxData()
		self:_drawBoundingBoxUi()
	end
end

function SpineInterfaceComp:onDestory()
	local triggerGo = self._compRoot

	BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
	EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
	DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
	PointerClickHandler.Get(triggerGo):RemoveLuaHandler(self._pointerClickHandler)
	PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
	PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)
	GlobalDispatcher:removeListener(GlobalNotify.SpineInterFaceBoundingBoxDrawUi, self._handleSwitchBoundingBoxDrawUi, self)
	GlobalDispatcher:removeListener(GlobalNotify.SpineInterFaceEventNotifyDoMotions, self._spineInterFaceEventNotifyDoMotions, self)

	self._compRoot = nil

	if self._multiLoader then
		GameUtil.unloadMultiResLoaderResource(self._multiLoader)

		self._multiLoader = nil
	end
end

function SpineInterfaceComp:_isEnoughParam(str, paramMo)
	local isEnoughParam = false
	local arr = string.split(str, "$")
	local motionType = arr[1]
	local paramArr = string.split(arr[2], ",")

	if motionType == MsEnum.MotionType.PublicParam or motionType == MsEnum.MotionType.SpineParam then
		local paramId = checknumber(paramArr[1])
		local paramMo = self._paramMoMgr:getParamMo(motionType, paramId)
		local dataType = paramMo:getDataType()
		local paramValue = paramMo:getValue()

		if dataType == MsEnum.DataType.Int or dataType == MsEnum.DataType.Float then
			local tt = paramArr[2]
			local needParamValue = checknumber(paramArr[3])

			isEnoughParam = self:_compareByParam(tt, paramValue, needParamValue)
		elseif dataType == MsEnum.DataType.Bool then
			isEnoughParam = paramArr[2] == "true" == paramValue
		elseif dataType == MsEnum.DataType.Trigger then
			isEnoughParam = paramValue == true
		end
	else
		printError(string.format("不支持类型( motionType = %s )", motionType))
	end

	return isEnoughParam
end

function SpineInterfaceComp:_compareByParam(tt, valueA, valueB)
	if tt == GameEnum.GREATER_THAN then
		return valueB < valueA
	elseif tt == GameEnum.GREATER_THAN_OR_EQUAL_TO then
		return valueB <= valueA
	elseif tt == GameEnum.LESS_THAN then
		return valueA < valueB
	elseif tt == GameEnum.LESS_THAN_OR_EQUAL_TO then
		return valueA <= valueB
	elseif tt == GameEnum.EQUAL_TO then
		return valueA == valueB
	elseif tt == GameEnum.NOT_EQUAL_TO then
		return valueA ~= valueB
	end

	return false
end

function SpineInterfaceComp:onReloadSpine(spineGo, spineGoRect, _skinId, camera)
	local skinId = checknumber(_skinId)

	self:onUnReloadSpine()

	if goutil.isNil(spineGo) then
		return
	end

	if not SpineInterfaceController.instance:isSupportInterface(skinId) then
		return
	end

	self._3dCamera = camera
	self._skinId = skinId

	self._spineLoadHelp:onLoad(spineGo)

	self._spineGo = spineGo
	self._spineGoRect = spineGoRect

	GameUtil.SetActive(self._spineGoRect, true)
	GameUtil.SetActive(self._spineGo, true)
	GameUtil.SetActive(self._compRoot, true)
	self._spineCtrl:onInit(spineGo)

	local attachment
	local skeletonList = self._spineLoadHelp:getSkeletonList()

	for skeletonIndex, skeleton in ipairs(skeletonList) do
		local exposedList_count = SystemReflexHelp.getCountOfSpineExposedListSlot(skeleton.Slots)
		local exposedList_items = SystemReflexHelp.getItemsOfSpineExposedListSlot(skeleton.Slots)

		if exposedList_count and exposedList_items then
			for i = 0, exposedList_count - 1 do
				local slot = exposedList_items[i]

				attachment = SystemReflexHelp.getAttachmentOfSpineSlot(slot)

				if attachment ~= nil and attachment:GetType() == self._boundingBoxAttachmentType then
					table.insert(self._boxSlotList, slot)

					self._boxAtts[slot] = attachment
					self._boxAttNames[slot] = SystemReflexHelp.getNameOfSpineSlotAttachment(attachment)

					local slotData = SystemReflexHelp.getDataOfSpineSlotSlot(slot)

					self._boxSlotIndexs[slot] = SystemReflexHelp.getIndexOfSpineSlotSlotData(slotData)
				end
			end
		end
	end

	self:_updateRectFullScreenSize()
	self._paramMoMgr:onReload(self._skinId)
	self._memberMoMgr:onReload(skeletonList, self._skinId)

	local stateList = {}
	local behaviorDataLists = SpineInterfaceConfig.instance:getMsBehaviorDataLists(self._skinId)

	for behaviorLayerId, _ in ipairs(behaviorDataLists) do
		table.clear(stateList)

		local behaviorDataList = SpineInterfaceConfig.instance:getMsBehaviorDataList(self._skinId, behaviorLayerId)

		for _, behaviorData in ipairs(behaviorDataList) do
			local behaviorId = behaviorData.behaviorId
			local stateId = SpineInterfaceController.instance:getFsmStateId(skinId, behaviorLayerId, behaviorId)
			local state = BehaviorFsmState.New(stateId, skinId, behaviorLayerId, behaviorId)

			table.insert(stateList, state)
		end

		local fsmId = SpineInterfaceController.instance:getFsmId(skinId, behaviorLayerId)
		local fsm = self._fsmComp:createFsm(fsmId, stateList)

		fsm:changeState(stateList[1]:getStateId())
		table.insert(self._fsmList, fsm)
	end

	table.clear(self._motionMoQueue)
	self._interactionSession:onLoad(self._skinId)
	GameUtil.SetActive(self._compRoot, true)
	GlobalDispatcher:addListener(GlobalNotify.SceneResolutionChange, self._handleSceneResolutionChange, self)
	GlobalDispatcher:addListener(MsEnum.Notify_SpineSetActive, self._notify_SpineSetActive, self)
	self._boneBinder:onLoad(self._spineGo, skeletonList, self._spineLoadHelp)

	self._isLoadSpine = true

	SpineInterfaceMemoryRuntime.restore(self)
end

function SpineInterfaceComp:onUnReloadSpine()
	SpineInterfaceMemoryRuntime.flush(self)
	GlobalDispatcher:removeListener(GlobalNotify.SceneResolutionChange, self._handleSceneResolutionChange, self)
	GlobalDispatcher:removeListener(MsEnum.Notify_SpineSetActive, self._notify_SpineSetActive, self)

	if self._interactionSession then
		self._interactionSession:onClear()
	end

	self._boneBinder:onUnLoad()
	self._spineCtrl:onClear()

	self._isLoadSpine = false

	GameUtil.SetActive(self._compRoot, false)
	self:_clearSpineAnim()
	self._spineLoadHelp:allInitialize(true)
	self._spineLoadHelp:onUnLoad()
	self:_clearBoundingBoxDrawUi()
	self:_clearSpineParamHasUpdateMarkList()
	self._pointerInfo:onClear()
	self._fsmComp:onDestroy()
	self._paramMoMgr:onUnReload()
	self._memberMoMgr:onUnReload()
	self:_switchBoundingBoxDrawUi(false)
	self:_resetForbidOp()
	table.clear(self._fsmList)
	table.clear(self._boxSlotList)
	table.clear(self._boxAtts)
	table.clear(self._boxWorldVertices)
	table.clear(self._boxVectors)
	table.clear(self._boxSlotIndexs)
	table.clear(self._boxAttNames)
	table.clear(self._trackIndexsOfUsing)
	table.clear(self._showObjTimersInfo)
	table.clear(self._motionMoQueue)

	self._skinId = 0
	self._spineGo = nil
	self._spineGoRect = nil
	self._3dCamera = nil
	self._isHostSuspended = false

	SpineInterfaceMemoryRuntime.clearComp(self)
end

function SpineInterfaceComp:isSpineReloaded()
	return self._isLoadSpine
end

function SpineInterfaceComp:isLoaded()
	return self:isSpineReloaded()
end

function SpineInterfaceComp:unload()
	self:onUnReloadSpine()
end

function SpineInterfaceComp:openExtension(extendRoot, viewPresentor, eventParams)
	return SpineInterfaceController.instance:doSpineInterfaceBagExtension(self, extendRoot, viewPresentor, eventParams)
end

function SpineInterfaceComp:setSpineActive(isActive)
	GameUtil.SetActive(self._spineGo, isActive)
end

function SpineInterfaceComp:setHostSuspended(isSuspended)
	self._isHostSuspended = checkbool(isSuspended)

	self:_setHostActive(not self._isHostSuspended)
end

function SpineInterfaceComp:_setHostActive(isActive)
	GameUtil.SetActive(self._spineGoRect, isActive)
	GameUtil.SetActive(self._spineGo, isActive)
	GameUtil.SetActive(self._compRoot, isActive)
	GameUtil.SetActive(self._drawUiRoot, isActive)
end

function SpineInterfaceComp:_updateBoundingBoxData()
	local index = 0
	local boxAtt, value_worldVerticesLength

	for idx, slot in ipairs(self._boxSlotList) do
		if self._boxWorldVertices[slot] == nil then
			self._boxWorldVertices[slot] = System.Array.CreateInstance(self._singleType, (SystemReflexHelp.getWorldVerticesLengthOfSpineBoundingBoxAttachment(self._boxAtts[slot])))
		end

		if self._boxVectors[slot] == nil then
			self._boxVectors[slot] = {}
		end

		SystemReflexHelp.callComputeWorldVerticesOfSpineBoundingBoxAttachment(self._boxAtts[slot], slot, self._boxWorldVertices[slot])

		for ii = 0, self._boxWorldVertices[slot].Length - 1, 2 do
			index = ii / 2 + 1

			if not self._boxVectors[slot][ii / 2 + 1] then
				local vec = UnityEngine.Vector2.New(0, 0)

				vec:Set(self._boxWorldVertices[slot][ii], self._boxWorldVertices[slot][ii + 1])

				if self._spineLoadHelp:getCompType() == SpineEnum.CompType_SkeletonGraphic then
					vec:Set(vec.x * self._uiScale, vec.y * self._uiScale, 0)
				elseif self._spineLoadHelp:getCompType() == SpineEnum.CompType_SkeletonAnimation then
					local worldVecA = self._spineGo.transform:TransformPoint(vec)
					local viewportVecA = self._3dCamera:WorldToViewportPoint(worldVecA)
					local worldPointB = self._uiCamera:ViewportToWorldPoint(viewportVecA)

					worldPointB = self:_scaleAndRotateAndMovePoint(self._spineGoRect, worldPointB)

					local localPoint = self._spineGoRect:InverseTransformPoint(worldPointB)

					vec:Set(localPoint.x * self._posRatioX, localPoint.y * self._posRatioY)
				end

				self._boxVectors[slot][index] = vec
			end
		end
	end
end

function SpineInterfaceComp:_scaleAndRotateAndMovePoint(mainGo, point)
	local scale
	local x, y, z, w = 0, 0, 0, 0
	local parent = mainGo

	while true do
		if parent == nil or parent.gameObject == ViewMgr.instance:getUIRoot() then
			break
		end

		x, y, z = Framework.TransformUtil.GetLocalScale(parent, 0, 0, 0)

		point:Set(point.x * x, point.y * y, point.z * z)
		point:MulQuat(parent.localRotation)

		parent = parent.parent
	end

	local var_33_0, var_33_1, var_33_2 = Framework.TransformUtil.GetPos(mainGo, 0, 0, 0)

	point:Set(point.x + var_33_0, point.y + var_33_1, point.z + var_33_2)

	return point
end

function SpineInterfaceComp:_updateRectFullScreenSize()
	if self._spineGoRect then
		local uiRootTrans = ViewMgr.instance:getUIRoot().transform

		self._posRatioX = self._spineGoRect.rect.width / uiRootTrans.rect.width
		self._posRatioY = self._spineGoRect.rect.height / uiRootTrans.rect.height
	end
end

function SpineInterfaceComp:_notify_SpineSetActive(skinId, isActive)
	if skinId ~= self._skinId then
		return
	end

	isActive = checkbool(isActive)

	self:_setHostActive(isActive)
end

function SpineInterfaceComp:getParamsValue(paramType, paramId)
	return self._paramMoMgr:getParamValue(paramType, paramId)
end

function SpineInterfaceComp:getParamValue(paramType, paramId)
	return self._paramMoMgr:getParamValue(paramType, paramId)
end

function SpineInterfaceComp:setParamValue(paramType, paramId, value)
	return self._paramMoMgr:setParamValue(paramType, paramId, value)
end

function SpineInterfaceComp:getParamDataType(paramType, paramId)
	return self._paramMoMgr:getParamMo(paramType, paramId):getDataType()
end

function SpineInterfaceComp:getParamMoList(paramType)
	return self._paramMoMgr:getParamMoList(paramType)
end

function SpineInterfaceComp:getFsmList()
	return self._fsmList
end

function SpineInterfaceComp:beginBoneFollow(go, slotName, allowMultiple, alwaysVisible)
	self._boneBinder:begin(go, slotName, allowMultiple, alwaysVisible)
end

function SpineInterfaceComp:stopBoneFollow(go)
	self._boneBinder:stop(go)
end

function SpineInterfaceComp:_onDropHandler(go, eventData)
	self:_checkTrigger(MsEnum.TriggerEvent_Drop, eventData)
end

function SpineInterfaceComp:_onBeginDragHandler(go, eventData)
	self._isDragging = true

	self:_checkTrigger(MsEnum.TriggerEvent_BeginDrag, eventData)
end

function SpineInterfaceComp:_onEndDragHandler(go, eventData)
	self:_checkTrigger(MsEnum.TriggerEvent_EndDrag, eventData)
end

function SpineInterfaceComp:_onDragHandler(go, eventData)
	self:_checkTrigger(MsEnum.TriggerEvent_Drag, eventData)
end

function SpineInterfaceComp:_onPointerEnterHandler(go, eventData)
	self:_checkTrigger(MsEnum.TriggerEvent_PointerEnter, eventData)
end

function SpineInterfaceComp:_onPointerExitHandler(go, eventData)
	self:_checkTrigger(MsEnum.TriggerEvent_PointerExit, eventData)
end

function SpineInterfaceComp:_onPointerClickHandler(go, eventData)
	return
end

function SpineInterfaceComp:_onPointerDownHandler(go, eventData)
	self._isPointDown = true
	self._isPress = false
	self._currDonwTime = Time.unscaledTime
	self._onDownEventData = eventData
end

function SpineInterfaceComp:_onPointerUpHandler(go, eventData)
	self._onUpEventData = eventData

	if not self._isPress then
		self._clickCount = self._clickCount + 1
	end

	if self._clickCount >= 2 and self._onUpEventData then
		self:_checkTrigger(MsEnum.TriggerEvent_PointerClick, self._onUpEventData, MsEnum.TriggerType_PointerClickDouble)

		self._onUpEventData = nil
		self._clickCount = 0
	end

	self._isPress = false
	self._isPointDown = false
	self._onDownEventData = nil
end

function SpineInterfaceComp:_checkTrigger(triggerEvent, eventData, ...)
	if self._interactionSession then
		self._interactionSession:checkTrigger(triggerEvent, eventData, ...)
	end
end

function SpineInterfaceComp:_getTriggerBoxSlotIndexByName(name, eventData)
	local result = -1

	if not string.nilorempty(name) then
		if eventData.position == nil then
			printError("eventData.position == nil")
		else
			local position = goutil.screenToLocalPos(eventData.position, self._spineGoRect)

			if position == nil then
				printError("position == nil")
			else
				for idx, slot in ipairs(self._boxSlotList) do
					if name == self._boxAttNames[slot] then
						local vecList = self._boxVectors[slot]

						if vecList and self:_isContainsPointOf2D(vecList, position) then
							result = self._boxSlotIndexs[slot] or -1
						end

						break
					end
				end
			end
		end
	else
		result = 999
	end

	return result
end

function SpineInterfaceComp:_isContainsPointOf2D(points, point)
	local j = #points
	local inside = false
	local pi, pj

	for i = 1, #points do
		pi = points[i]
		pj = points[j]

		if (points[i].y <= point.y and point.y < pj.y or pj.y <= point.y and point.y < pi.y) and point.x < (pj.x - pi.x) * (point.y - pi.y) / (pj.y - pi.y) + pi.x then
			inside = not inside
		end

		j = i
	end

	return inside
end

function SpineInterfaceComp:_addMotionMoToQueue(state)
	if self._interactionSession then
		self._interactionSession:addMotionMoToQueue(state)
	end
end

function SpineInterfaceComp:_tryTriggerDoMotionQueue()
	if self._interactionSession then
		self._interactionSession:tryTriggerDoMotionQueue()
	end
end

function SpineInterfaceComp:_doMotion(motionInfo)
	if self._interactionSession then
		self._interactionSession:doMotion(motionInfo)
	end
end

function SpineInterfaceComp:_markSpineParamHasUpdate(paramId)
	self._spineParamHasUpdateMarkList[paramId] = true
end

function SpineInterfaceComp:_isSpineParamHasUpdate(paramId)
	return checkbool(self._spineParamHasUpdateMarkList[paramId])
end

function SpineInterfaceComp:_clearSpineParamHasUpdateMarkList()
	for k, v in pairs(self._spineParamHasUpdateMarkList) do
		self._spineParamHasUpdateMarkList[k] = false
	end
end

function SpineInterfaceComp:_playSpineAnim(animName, completeCallBack, isLoop, isForbidOp, isFadeIn, isFadeOut, trackIndex, isKeep, spineEventIdList, audioId, audioTrackIndex)
	local params = {}

	params.animName = animName
	params.isLoop = isLoop
	params.trackIndex = trackIndex
	params.isLastFrameHold = isKeep
	params.isFadeIn = isFadeIn
	params.isFadeOut = isFadeOut
	audioId = checknumber(audioId)
	audioTrackIndex = checknumber(audioTrackIndex)

	self:_clearAudioTrackIndex(0)

	local eventCallBackPool = {}
	local animEndCallBackPool = {}
	local spineEventDatasByName = {}

	if spineEventIdList then
		for _, spineEventId in ipairs(spineEventIdList) do
			local spineEventData = SpineInterfaceConfig.instance:getMsSpineEventData(spineEventId)

			if spineEventData then
				spineEventDatasByName[spineEventData.eventName] = spineEventData
			end
		end
	end

	if isForbidOp == true then
		self:_setForbidOp(true)
	end

	if audioId > 0 then
		self:_playAudio(audioId, audioTrackIndex)
	end

	function params.completeCallBack(isFinial, trackEntry)
		if not isLoop and isFinial then
			if isForbidOp == true then
				self:_setForbidOp(false)
			end

			GameUtil.callBack(completeCallBack)
		end
	end

	function params.endCallBack(isFinial, trackEntry)
		if animEndCallBackPool[trackEntry] then
			for _, animEndCallBack in pairs(animEndCallBackPool[trackEntry]) do
				GameUtil.callBack(animEndCallBack)
			end
		end
	end

	function params.eventCallBack(isFinial, trackEntry, event)
		local eventName = SystemReflexHelp.getNameOfEventData(event.Data)
		local spineEventData = spineEventDatasByName[eventName]

		if spineEventData then
			local eventType = spineEventData.eventType

			if eventType == MsEnum.SpineEventType_Audio then
				local id = checknumber(spineEventData.paramValue.audioId)
				local fmodEvtInst

				local function eventCallBack()
					fmodEvtInst = self:_playAudio(id, 0)
				end

				local function animEndCallBack()
					return
				end

				eventCallBackPool[trackEntry] = eventCallBackPool[trackEntry] or {}
				animEndCallBackPool[trackEntry] = animEndCallBackPool[trackEntry] or {}

				table.insert(eventCallBackPool[trackEntry], eventCallBack)
				table.insert(animEndCallBackPool[trackEntry], animEndCallBack)

				local length = #eventCallBackPool[trackEntry]

				GameUtil.callBack(eventCallBackPool[trackEntry][length])
			end
		end

		local eventCallBackList = eventCallBackPool[trackEntry]

		if eventCallBackList then
			GameUtil.callBack(eventCallBackList[#eventCallBackList])
		end
	end

	self._spineCtrl:playAnimation(params)
end

function SpineInterfaceComp:playSpineAnim(animName, completeCallBack, isLoop, isForbidOp, isFadeIn, isFadeOut, trackIndex, isKeep, spineEventIdList, audioId, audioTrackIndex)
	self:_playSpineAnim(animName, completeCallBack, isLoop, isForbidOp, isFadeIn, isFadeOut, trackIndex, isKeep, spineEventIdList, audioId, audioTrackIndex)
end

function SpineInterfaceComp:_clearSpineAnim()
	self:_clearAllFmodAudioInst()
end

function SpineInterfaceComp:_getNextTrackIndex(tracks, animName)
	local trackIndex = -1
	local trackList = SystemReflexHelp.getItemsOfSpineExposedListTrackEntry(tracks)

	for idx = 0, trackList.Length - 1 do
		local track = trackList[idx]

		if track and track.Animation and track.Animation.Name == animName then
			trackIndex = idx

			break
		end
	end

	local track

	if trackIndex < 0 then
		for idx = 0, trackList.Length - 1 do
			if not self:_isTrackIndexUsing(idx) and (trackList[idx] == nil or trackList[idx].Animation == nil) then
				trackIndex = idx

				break
			end
		end
	end

	if trackIndex < 0 then
		trackIndex = trackList.Length
	end

	return trackIndex
end

function SpineInterfaceComp:_markTrackIndexOfUsing(trackIndex, isUsing)
	self._trackIndexsOfUsing[trackIndex] = isUsing
end

function SpineInterfaceComp:_isTrackIndexUsing(trackIndex)
	return self._trackIndexsOfUsing[trackIndex] == true
end

function SpineInterfaceComp:_exitTrackKeep(trackIndex)
	for skeletonIndex, skeleton in ipairs(self._spineLoadHelp:getSkeletonList()) do
		local animationState = self._spineLoadHelp:getAnimationState(skeletonIndex)
		local skeletonDataAsset = self._spineLoadHelp:getSkeletonDataAsset(skeletonIndex)
		local animationStateData = skeletonDataAsset:GetAnimationStateData()

		if skeletonDataAsset and animationStateData and animationState then
			animationState:SetEmptyAnimation(trackIndex, 0)
		end
	end
end

function SpineInterfaceComp:_applySpineAnimFinalFrame(animName, trackIndex)
	if string.nilorempty(animName) then
		return
	end

	trackIndex = checknumber(trackIndex)

	for skeletonIndex, skeleton in ipairs(self._spineLoadHelp:getSkeletonList()) do
		local animationState = self._spineLoadHelp:getAnimationState(skeletonIndex)
		local skeletonDataAsset = self._spineLoadHelp:getSkeletonDataAsset(skeletonIndex)
		local animationStateData = skeletonDataAsset and skeletonDataAsset:GetAnimationStateData()
		local skeletonData = animationStateData and animationStateData.SkeletonData
		local animation = skeletonData and skeletonData:FindAnimation(animName)

		if animationState and animation ~= nil then
			local trackEntry = animationState:SetAnimation(trackIndex, animName, false)

			trackEntry.MixDuration = 0
			trackEntry.TrackTime = trackEntry.AnimationEnd

			animationState:Apply(skeleton)
			skeleton:UpdateWorldTransform()
		end
	end
end

function SpineInterfaceComp:_setForbidOp(isForbidOp)
	self._forbidOpNum = isForbidOp and self._forbidOpNum + 1 or Mathf.Max(self._forbidOpNum - 1, 0)
end

function SpineInterfaceComp:_resetForbidOp()
	self._forbidOpNum = 0
end

function SpineInterfaceComp:_isForbidOp()
	return self._forbidOpNum > 0
end

function SpineInterfaceComp:isForbidOp()
	return self:_isForbidOp()
end

function SpineInterfaceComp:_playAudio(audioId, trackIndex)
	self:_clearAudioTrackIndex(trackIndex)

	if audioId > 0 then
		self._fmodEvtInst[trackIndex] = AudioPlayerEx.instance:playEffect(audioId)
	end

	return self._fmodEvtInst[trackIndex]
end

function SpineInterfaceComp:_clearAudioTrackIndex(trackIndex)
	local fmodEvtInst = self._fmodEvtInst[trackIndex]

	self._fmodEvtInst[trackIndex] = nil

	AudioPlayerEx.instance:stopEvent(fmodEvtInst)
end

function SpineInterfaceComp:_clearAllFmodAudioInst()
	for trackIndex, fmodEvtInst in pairs(self._fmodEvtInst) do
		AudioPlayerEx.instance:stopEvent(fmodEvtInst)
	end

	table.clear(self._fmodEvtInst)
end

function SpineInterfaceComp:_handleSwitchBoundingBoxDrawUi(isStart)
	if isStart then
		self:_switchBoundingBoxDrawUi(isStart)
	else
		self:_switchBoundingBoxDrawUi(not self._isNeedBoundingBoxDrawUi)
	end
end

function SpineInterfaceComp:_switchBoundingBoxDrawUi(isStart)
	self._isNeedBoundingBoxDrawUi = isStart

	if not self._isNeedBoundingBoxDrawUi then
		self:_clearBoundingBoxDrawUi()
	end
end

function SpineInterfaceComp:isNeedBoundingBoxDrawUi()
	return self._isNeedBoundingBoxDrawUi
end

function SpineInterfaceComp:_drawBoundingBoxUi()
	local vectors, lineComp

	for _, slot in ipairs(self._boxSlotList) do
		local info = self:_getLineRendererComp(slot)

		if info then
			vectors = self._boxVectors[slot]
			self._tempVector = self._tempVector or Vector3.New()
			info.lineComp.positionCount = #vectors + 1

			for idx, vec in ipairs(vectors) do
				self._tempVector:Set(vec.x, vec.y, -100)
				info.lineComp:SetPosition(idx - 1, self._tempVector)
			end

			self._tempVector:Set(vectors[1].x, vectors[1].y, -100)
			info.lineComp:SetPosition(#vectors, self._tempVector)

			local cx, cy = MmUtil.getPolygonCentroid(vectors)

			GameUtil.setLocalPos(info.txtName.gameObject, cx, cy, 0)

			info.txtName.text = self._boxAttNames[slot]
		end
	end

	if not goutil.isNil(self._drawUiView) then
		GameUtil.setLocalScale(self._drawUiView, Framework.TransformUtil.GetLocalScale(self._spineGoRect, 0, 0, 0))
		GameUtil.setLocalPos(self._drawUiView, Framework.TransformUtil.GetLocalPos(self._spineGoRect, 0, 0, 0))
		GameUtil.setLocalRotation(self._drawUiView, Framework.TransformUtil.GetLocalRotation(self._spineGoRect, 0, 0, 0))
		GameUtil.SetActive(self._drawUiView, true)
		GameUtil.SetActive(self._drawUiRoot, true)
	end
end

function SpineInterfaceComp:_clearBoundingBoxDrawUi()
	table.clear(self._loadDrawUiSlotList)

	self._isLoading = false
	self._isNeedBoundingBoxDrawUi = false

	if self._drawInfoPool then
		for _, info in pairs(self._drawInfoPool) do
			goutil.destroy(info.mainGo)
		end

		table.clear(self._drawInfoPool)
	end

	goutil.destroy(self._drawUiView)

	self._drawUiView = nil
	self._drawUiRoot = nil
	self._lineRdCell = nil
end

function SpineInterfaceComp:_getLineRendererComp(slot)
	self._drawInfoPool = self._drawInfoPool or {}
	self._drawInfoPool[slot] = self._drawInfoPool[slot] or self:_instanceLineRendererComp(slot)

	return self._drawInfoPool[slot]
end

function SpineInterfaceComp:_instanceLineRendererComp(slot)
	if goutil.isNil(self._drawUiView) and not self._isLoading then
		self._isLoading = true

		local path = "ui/views/gm/gmskininterface/drawuiview.prefab"

		local function finishCallBack(loader)
			local res = self._multiLoader:getResource(path)

			if res then
				local main_asset = res:GetMainAsset()

				if main_asset then
					local parentObj = goutil.clone(res:GetAsset(nil, nil))

					goutil.addChildToParent(parentObj, self._spineGoRect.transform.parent)
					GameUtil.setLocalScale(parentObj, 1, 1, 1)
					GameUtil.setLocalPos(parentObj, 0, 0, -1)

					self._drawUiView = parentObj
					self._drawUiRoot = goutil.findChild(self._drawUiView, "root")
					self._lineRdCell = goutil.findChild(self._drawUiView, "lineRdCell")

					GameUtil.SetActive(self._lineRdCell, false)
				end
			end
		end

		if self._multiLoader:getResource(path) then
			finishCallBack()
		else
			self._multiLoader:addResPath(path, true)
			self._multiLoader:load(finishCallBack, nil, self)
		end
	end

	self._loadDrawUiSlotList = self._loadDrawUiSlotList or {}

	table.insert(self._loadDrawUiSlotList, slot)
end

function SpineInterfaceComp:_createDrawInfo(slot)
	if goutil.isNil(self._drawUiView) then
		return false
	end

	local mainGo = goutil.cloneAndSetParent(self._lineRdCell, self._drawUiRoot.transform)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.SetActive(mainGo, true)

	local lineComp = mainGo:GetComponent(ComponentType.LineRenderer)

	lineComp.startColor = Color.red
	lineComp.endColor = Color.red
	lineComp.startWidth = 0.01
	lineComp.endWidth = 0.01
	lineComp.useWorldSpace = false
	self._drawInfoPool[slot] = {
		mainGo = mainGo,
		lineComp = lineComp,
		txtName = txtName
	}

	return true
end

return SpineInterfaceComp
