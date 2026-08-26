-- chunkname: @modules/logic/room/view/RoomViewUIBaseItem.lua

module("modules.logic.room.view.RoomViewUIBaseItem", package.seeall)

local RoomViewUIBaseItem = class("RoomViewUIBaseItem", LuaCompBase)

function RoomViewUIBaseItem:init(go)
	self.go = go
	self.goTrs = go.transform
	self._gocontainer = gohelper.findChild(self.go, "go_container")
	self._gocontainerTrs = self._gocontainer.transform
	self._scene = GameSceneMgr.instance:getCurScene()
	self._canvasGroup = self.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._baseAnimator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._containerCanvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._isShow = true

	if self._customOnInit then
		self:_customOnInit()
	end
end

function RoomViewUIBaseItem:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.RefreshUIShow, self._refreshShow, self)
	RoomBuildingController.instance:registerCallback(RoomEvent.BuildingListShowChanged, self._refreshShow, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, self._refreshShow, self)
	RoomMapController.instance:registerCallback(RoomEvent.BendingAmountUpdate, self._refreshPosition, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._refreshPosition, self)
	RoomMapController.instance:registerCallback(RoomEvent.TouchClickUI3D, self._onTouchClick, self)

	if self._customAddEventListeners then
		self:_customAddEventListeners()
	end
end

function RoomViewUIBaseItem:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.RefreshUIShow, self._refreshShow, self)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.BuildingListShowChanged, self._refreshShow, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, self._refreshShow, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.BendingAmountUpdate, self._refreshPosition, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._refreshPosition, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchClickUI3D, self._onTouchClick, self)

	if self._customRemoveEventListeners then
		self:_customRemoveEventListeners()
	end
end

function RoomViewUIBaseItem:_refreshPosition()
	local worldPos = self:getUI3DPos()
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self.goTrs.parent)
	local scale = 0

	if anchorPos then
		recthelper.setAnchor(self.goTrs, anchorPos.x, anchorPos.y)

		local cameraPosition = self._scene.camera:getCameraPosition()
		local distance = Vector3.Distance(bendingPos, cameraPosition)

		scale = distance <= 3.5 and 1 or distance >= 7 and 0.5 or 1 - (distance - 3.5) / 3.5 / 2
	end

	transformhelper.setLocalScale(self._gocontainerTrs, scale, scale, scale)
	self:_refreshCanvasGroup()
end

function RoomViewUIBaseItem:_refreshCanvasGroup()
	local pos = self:getUI3DPos()
	local cameraPosition = self._scene.camera:getCameraPosition()
	local position = Vector2(pos.x, pos.z)
	local cameraPosition = Vector2(cameraPosition.x, cameraPosition.z)
	local distance = Vector2.Distance(position, cameraPosition)
	local curAlpha = 1

	if distance >= RoomBaseUIComp.fadeMax then
		curAlpha = 0
	elseif distance <= RoomBaseUIComp.fadeMin then
		curAlpha = 1
	else
		curAlpha = 1 - (distance - RoomBaseUIComp.fadeMin) / (RoomBaseUIComp.fadeMax - RoomBaseUIComp.fadeMin)

		if self._lastAlpha and math.abs(self._lastAlpha - curAlpha) < RoomBaseUIComp.alphaChangeMinimum then
			curAlpha = self._lastAlpha
		end
	end

	local blocksRaycasts = curAlpha > 0.25

	if self._lastAlpha ~= curAlpha then
		self._lastAlpha = curAlpha
		self._canvasGroup.alpha = curAlpha
	end

	if self._lastBlocksRaycasts ~= blocksRaycasts then
		self._lastBlocksRaycasts = blocksRaycasts
		self._canvasGroup.blocksRaycasts = blocksRaycasts
	end
end

function RoomViewUIBaseItem:getUI3DPos()
	return
end

function RoomViewUIBaseItem:_setShow(isShow, immediately)
	if isShow then
		if not self._isShow then
			self._baseAnimator:Play("room_task_in", 0, immediately and 1 or 0)
		end

		self._containerCanvasGroup.blocksRaycasts = true
	else
		if self._isShow then
			self._baseAnimator:Play("room_task_out", 0, immediately and 1 or 0)
		end

		self._containerCanvasGroup.blocksRaycasts = false
	end

	self._isShow = isShow
end

function RoomViewUIBaseItem:_onTouchClick(go, param)
	if self._isShow and not self._isReturning and self.goTrs and go and go.transform:IsChildOf(self.goTrs) then
		self:_onClick(go, param)
	end
end

function RoomViewUIBaseItem:_onClick(go, param)
	return
end

function RoomViewUIBaseItem:onDestroy()
	if self._customOnDestory then
		self:_customOnDestory()
	end
end

return RoomViewUIBaseItem
