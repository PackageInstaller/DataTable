-- chunkname: @modules/logic/room/entity/comp/RoomBaseUIComp.lua

module("modules.logic.room.entity.comp.RoomBaseUIComp", package.seeall)

local RoomBaseUIComp = class("RoomBaseUIComp", LuaCompBase)

RoomBaseUIComp.fadeMin = 5
RoomBaseUIComp.fadeMax = 7
RoomBaseUIComp.alphaChangeMinimum = 0.02

function RoomBaseUIComp:ctor(entity)
	self.entity = entity
end

function RoomBaseUIComp:init(go)
	self.go = go
	self._uiGO = nil
	self._uiGOTrs = nil
	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomBaseUIComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.BendingAmountUpdate, self.refreshPosition, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self.refreshPosition, self)
	RoomMapController.instance:registerCallback(RoomEvent.TouchClickUI3D, self._onTouchClick, self)
end

function RoomBaseUIComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.BendingAmountUpdate, self.refreshPosition, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self.refreshPosition, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchClickUI3D, self._onTouchClick, self)
end

function RoomBaseUIComp:beforeDestroy()
	TaskDispatcher.cancelTask(self._delayReturnUI, self)
	self:_delayReturnUI()
	self:removeEventListeners()
end

function RoomBaseUIComp:refreshPosition()
	if not self._uiGOTrs then
		return
	end

	local worldPos = self:getUIWorldPos()
	local bendingPos, bendingRotation, bendingContainerRotation = RoomBendingHelper.worldToBending(worldPos)

	transformhelper.setPos(self._uiGOTrs, bendingPos.x, bendingPos.y, bendingPos.z)

	self._uiGOTrs.rotation = bendingRotation

	if self._gocontainerTrs then
		transformhelper.setLocalRotation(self._gocontainerTrs, bendingContainerRotation.x, bendingContainerRotation.y, bendingContainerRotation.z)
	end

	self:refreshCanvasGroup()
end

function RoomBaseUIComp:refreshCanvasGroup()
	if not self._uiGO or not self._canvasGroup then
		return
	end

	local posX, posY, posZ = transformhelper.getPos(self._uiGOTrs)
	local cameraPosition = self._scene.camera:getCameraPosition()
	local position = Vector2(posX, posZ)
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

		if self._arrowRenderer then
			self._arrowRenderer:SetAlpha(curAlpha)
		end
	end

	if self._lastBlocksRaycasts ~= blocksRaycasts then
		self._lastBlocksRaycasts = blocksRaycasts
		self._canvasGroup.blocksRaycasts = blocksRaycasts
	end
end

function RoomBaseUIComp:_onTouchClick(go, param)
	if self._uiGO and go and go.transform:IsChildOf(self._uiGOTrs) and not self._isReturning then
		self:onClick(go, param)
	end
end

function RoomBaseUIComp:getUI()
	if self._isReturning then
		self._isReturning = false

		TaskDispatcher.cancelTask(self._delayReturnUI, self)
		self._baseAnimator:Play("room_task_in", 0, 1)

		return
	end

	if string.nilorempty(self._res) then
		return
	end

	if not self._uiGO then
		self._uiGO = RoomUIPool.getInstance(self._res, self._name)
		self._uiGOTrs = self._uiGO.transform
		self._gocontainer = gohelper.findChild(self._uiGO, "go_container")
		self._gocontainerTrs = self._gocontainer.transform
		self._canvasGroup = self._uiGO:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._baseAnimator = self._uiGO:GetComponent(typeof(UnityEngine.Animator))

		self._baseAnimator:Play("room_task_in", 0, 0)

		local arrowGO = gohelper.findChild(self._uiGO, "tubiao")

		if arrowGO then
			self._arrowRenderer = arrowGO:GetComponent(typeof(UnityEngine.CanvasRenderer))

			if self._lastAlpha then
				self._arrowRenderer:SetAlpha(self._lastAlpha)
			end
		end

		self:initUI()
	end

	return self._uiGO
end

function RoomBaseUIComp:returnUI()
	if self._isReturning then
		return
	end

	self._isReturning = false

	TaskDispatcher.cancelTask(self._delayReturnUI, self)

	if string.nilorempty(self._res) then
		return
	end

	if self._uiGO then
		self._isReturning = true

		self._baseAnimator:Play("room_task_out", 0, 0)
		TaskDispatcher.runDelay(self._delayReturnUI, self, 0.3)
	end
end

function RoomBaseUIComp:_delayReturnUI()
	self._isReturning = false

	if self._uiGO then
		self:destoryUI()
		RoomUIPool.returnInstance(self._res, self._uiGO)

		self._uiGO = nil
		self._uiGOTrs = nil
		self._gocontainer = nil
		self._gocontainerTrs = nil
		self._canvasGroup = nil
		self._arrowRenderer = nil
		self._baseAnimator = nil
	end
end

function RoomBaseUIComp:initUI()
	return
end

function RoomBaseUIComp:getUIWorldPos()
	return
end

function RoomBaseUIComp:onClick()
	return
end

return RoomBaseUIComp
