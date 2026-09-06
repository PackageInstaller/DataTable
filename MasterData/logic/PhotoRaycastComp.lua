-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rotationlist/PhotoRaycastComp.lua

module("logic.extensions.rotationlist.PhotoRaycastComp", package.seeall)

local PhotoRaycastComp = class("PhotoRaycastComp")

function PhotoRaycastComp:ctor()
	self._cullingLayer = PhotoCacheMgr.instance:getCullingLayer()
end

function PhotoRaycastComp:onEnter(rtView, triggerPlane)
	self._rtView = rtView
	self._rtViewTran = self._rtView:GetComponent(typeof(UnityEngine.RectTransform))
	self._rawImg = goutil.addComponentOnce(self._rtView, ComponentType.RawImage)
	self._triggerPlane = triggerPlane

	local triggerGo = self._triggerPlane

	if triggerGo then
		self._dropHandler = DropHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDropHandler(_go, eventData)
		end)
		self._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onBeginDragHandler(_go, eventData)
		end)
		self._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onEndDragHandler(_go, eventData)
		end)
		self._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDragHandler(_go, eventData)
		end)
		self._pointerEnterHandler = PointerEnterHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onPointerEnterHandler(_go, eventData)
		end)
		self._pointerExitHandler = PointerExitHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onPointerExitHandler(_go, eventData)
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

	self._photoBase = Framework.PhotoBase.Add(self._rtView)

	self._photoBase:TurnOn()

	self._rtCamera = self._photoBase.producer.rtCamera

	self._photoBase:SetCameraPosition(0, 0, -1000)
	self._photoBase:SetCameraRotation(0, 0, 0)

	if self._rtView == self._triggerPlane then
		self._photoBase:EnableClick(true)
	else
		self._photoBase:EnableClick(false)
	end

	self._targetContainer = self._photoBase.producer.targetContainer

	local targetContainerCanvas = goutil.addComponentOnce(self._targetContainer, ComponentType.Canvas)

	goutil.addComponentOnce(self._photoBase.producer.targetContainer, ComponentType.GraphicRaycaster)

	targetContainerCanvas.worldCamera = self._photoBase.producer.rtCamera
	self._targetContainer.layer = self._cullingLayer

	Game.ImageUtil.SetRawImageAlpha(self._rawImg, 1)

	self._rawImg.material = nil
	self._rtCamera.orthographic = false
	self._rtCamera.farClipPlane = 3000
	self._uiCamera = GlobalModel.instance.uiCamera
	self._eventSystemGo = GlobalModel.instance.eventSystem

	local eventSystem_type = SystemReflexHelp.getType("UnityEngine.EventSystems.EventSystem,UnityEngine.UI")

	self._eventSystemComp = self._eventSystemGo:GetComponent(eventSystem_type)
	self._eventSystem = SystemReflexHelp.getPropertyValue("UnityEngine.EventSystems.EventSystem,UnityEngine.UI", "current", self._eventSystemComp)
	self._pointerClickHandlerPool = {}
	self._targetGoParentPool = {}
end

function PhotoRaycastComp:onExit()
	self:removeAllTarget()
	self._photoBase:TurnOff()

	self._rtCamera = nil
	self._targetContainer = nil
	self._photoBase = nil
	self._rtView = nil
	self._triggerPlane = nil
	self._rtViewTran = nil
	self._rawImg = nil

	self:_clearPointerClickHandler()

	local triggerGo = self._triggerPlane

	if triggerGo then
		DropHandler.Get(triggerGo):RemoveLuaHandler(self._dropHandler)
		BeginDragHandler.Get(triggerGo):RemoveLuaHandler(self._beginDragHandler)
		EndDragHandler.Get(triggerGo):RemoveLuaHandler(self._endDragHandler)
		DragHandler.Get(triggerGo):RemoveLuaHandler(self._dragHandler)
		PointerEnterHandler.Get(triggerGo):RemoveLuaHandler(self._pointerEnterHandler)
		PointerExitHandler.Get(triggerGo):RemoveLuaHandler(self._pointerExitHandler)
		PointerClickHandler.Get(triggerGo):RemoveLuaHandler(self._pointerClickHandler)
		PointerDownHandler.Get(triggerGo):RemoveLuaHandler(self._pointerDownHandler)
		PointerUpHandler.Get(triggerGo):RemoveLuaHandler(self._pointerUpHandler)
	end
end

function PhotoRaycastComp:showTarget(targetGo, isAllSameLayer)
	if not goutil.isNil(targetGo) and targetGo.transform.parent ~= self._targetContainer then
		self._targetGoParentPool[targetGo] = targetGo.transform.parent

		self._photoBase:ShowTarget(targetGo, isAllSameLayer)
	end
end

function PhotoRaycastComp:removeTarget(targetGo)
	local parentGo = self._targetGoParentPool[targetGo]

	if not goutil.isNil(targetGo) and not goutil.isNil(parentGo) then
		goutil.addChildToParent(targetGo, parentGo)

		self._targetGoParentPool[targetGo] = nil
	end
end

function PhotoRaycastComp:removeAllTarget()
	for targetGo, parentGo in pairs(self._targetGoParentPool) do
		if not goutil.isNil(targetGo) and not goutil.isNil(parentGo) then
			goutil.addChildToParent(targetGo, parentGo)
		end
	end

	table.clear(self._targetGoParentPool)
end

function PhotoRaycastComp:getPhotoBase()
	return self._photoBase
end

function PhotoRaycastComp:getRtCamera()
	return self._rtCamera
end

function PhotoRaycastComp:getRtView()
	return self._rtView
end

function PhotoRaycastComp:addPointerClickHandler(go, handler)
	self._pointerClickHandlerPool[go] = handler
end

function PhotoRaycastComp:rmPointerClickHandler(go)
	self._pointerClickHandlerPool[go] = nil
end

function PhotoRaycastComp:_clearPointerClickHandler()
	table.clear(self._pointerClickHandlerPool)
end

function PhotoRaycastComp:_tryTriggerPointerClickHandler(go)
	if self._pointerClickHandlerPool[go] then
		GameUtil.callBack(self._pointerClickHandlerPool[go])

		return true
	end

	return false
end

function PhotoRaycastComp:screenPointToRayByCamA(go, eventData, triggerType)
	if self._rtCamera == nil then
		return
	end

	eventData.position = self:turnSrcPos(eventData.position)

	local raycastresult_list_type = SystemReflexHelp.getType("System.Collections.Generic.List`1[[UnityEngine.EventSystems.RaycastResult,UnityEngine.UI]]")
	local raycastresultList = tolua.createinstance(raycastresult_list_type)

	SystemReflexHelp.callRaycastAllOfEventSystem(self._eventSystem, eventData, raycastresultList)

	for i = 0, raycastresultList.Count - 1 do
		local raycastResult = raycastresultList[i]
		local resultGo = SystemReflexHelp.getPropertyValue("UnityEngine.EventSystems.RaycastResult,UnityEngine.UI", "gameObject", raycastResult)

		if resultGo ~= go and triggerType == RotTriggerEnum.PointerClickHandler and self:_tryTriggerPointerClickHandler(resultGo) then
			break
		end
	end
end

function PhotoRaycastComp:turnSrcPos(screenPosA)
	local worldPosA = self._uiCamera:ScreenToWorldPoint(screenPosA)
	local localPosA = self._rtView.transform:InverseTransformPoint(worldPosA)
	local screenPosX = Vector2.New(Mathf.Abs(localPosA.x + self._rtViewTran.rect.width * self._rtViewTran.pivot.x), Mathf.Abs(self._rtViewTran.rect.height * self._rtViewTran.pivot.y + localPosA.y))
	local viewportPosA = Vector3.New(screenPosX.x / self._rtViewTran.rect.width, screenPosX.y / self._rtViewTran.rect.height)

	return (self._rtCamera:ViewportToScreenPoint(viewportPosA))
end

function PhotoRaycastComp:_onDropHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onBeginDragHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onEndDragHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onDragHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onPointerEnterHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onPointerExitHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onPointerClickHandler(go, eventData)
	self:screenPointToRayByCamA(go, eventData, RotTriggerEnum.PointerClickHandler)
end

function PhotoRaycastComp:_onPointerDownHandler(go, eventData)
	return
end

function PhotoRaycastComp:_onPointerUpHandler(go, eventData)
	return
end

return PhotoRaycastComp
