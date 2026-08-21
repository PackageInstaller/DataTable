-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/furniture/HouseFurnitureOpView.lua

module("logic.extensions.house.view.furniture.HouseFurnitureOpView", package.seeall)

local M = class("HouseFurnitureOpView")
local ButtonAdapter = Astral.ButtonAdapter
local vec3Temp1 = Vector3.New()

M.MainUrl = ResName.Room_furniture_move

function M:ctor()
	self._resLoader = nil
	self._goInst = nil
	self._furnitureUnit = nil
	self._singleDragingId = -999
end

function M:destroy()
	FrameUpdate:removeListener(self)
	self:_removeUI()

	if self._goInst then
		goutil.destroy(self._goInst)
	end

	self._goInst = false

	if self._resLoader then
		self._resLoader:clear()
	end

	self._resLoader = false
	self._furnitureUnit = false
	self._singleDragingId = -999
end

function M:luaUpdate(dt)
	self:_followFurnitureMove()
end

function M:show(furnitureUnit)
	self._furnitureUnit = furnitureUnit
	self._singleDragingId = -999

	if self._goInst then
		self:_realShow()
	else
		if not self._resLoader then
			self._resLoader = SingleResLoader.New()
		end

		self._resLoader:load(self.MainUrl, self._onResLoaded, self)
	end

	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OP_VIEW_OPEN, true)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar))
	self:_buildUI()
	self:_realShow()
end

function M:_buildUI()
	self._btnClose = ButtonAdapter.GetFrom(self._goInst, "btnClose")
	self._btnRecycle = ButtonAdapter.GetFrom(self._goInst, "btnRecycle")
	self._btnRotation = ButtonAdapter.GetFrom(self._goInst, "btnRotation")
	self._btnEnsure = ButtonAdapter.GetFrom(self._goInst, "btnEnsure")
	self._goDragArea = goutil.findChild(self._goInst, "clickArea")

	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnRecycle:AddClickListener(self._onClickBtnRecycle, self)
	self._btnRotation:AddClickListener(self._onClickBtnRotation, self)
	self._btnEnsure:AddClickListener(self._onClickBtnEnsure, self)

	self._dragTrigger = Astral.UIDragTrigger.Get(self._goDragArea)

	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddDragListener(self._onDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
end

function M:_removeUI()
	if self._goInst then
		self._btnClose:RemoveClickListener()

		self._btnClose = false

		self._btnRecycle:RemoveClickListener()

		self._btnRecycle = false

		self._btnRotation:RemoveClickListener()

		self._btnRotation = false

		self._btnEnsure:RemoveClickListener()

		self._btnEnsure = false

		self._dragTrigger:RemoveBeginDragListener()
		self._dragTrigger:RemoveDragListener()
		self._dragTrigger:RemoveEndDragListener()

		self._dragTrigger = false
	end
end

function M:_realShow()
	if self._furnitureUnit then
		goutil.setActive(self._goInst, true)
		self:_followFurnitureMove()
		FrameUpdate:addListener(self)
	end
end

function M:hide()
	FrameUpdate:removeListener(self)

	if self._goInst then
		goutil.setActive(self._goInst, false)
	end

	if self._furnitureUnit then
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OP_VIEW_OPEN, false)
	end

	self._furnitureUnit = false
end

function M:_followFurnitureMove()
	local worldCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	if worldCamera and uiCamera and self._goInst and self._furnitureUnit and self._furnitureUnit.model:getFurnitureId() then
		local posX, posY, posZ = self._furnitureUnit:getCenterWorldPos()

		vec3Temp1:Set(posX, posY, posZ)

		local screenPos = worldCamera:WorldToScreenPoint(vec3Temp1)
		local namebarGO = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
		local uiPos = Astral.GeometryUtil.ScreenToLocalPos(screenPos, namebarGO.transform, uiCamera)

		Astral.TransformUtil.SetLocalPos(self._goInst.transform, uiPos.x, uiPos.y, 0)
	end
end

function M:_onClickBtnClose()
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OPERA_CANCEL)
end

function M:_onClickBtnRecycle()
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OPERA_RECYCLE)
end

function M:_onClickBtnRotation()
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OPERA_ROTATION)
end

function M:_onClickBtnEnsure()
	HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OPERA_CONFIRM)
end

function M:_onBeginDrag(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if self._singleDragingId > 0 then
		return
	end

	self._singleDragingId = pointerId
end

function M:_onDrag(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if pointerId == self._singleDragingId then
		HouseDispatcher:dispatchEvent(HouseEventType.FURNITURE_OPERA_DRAG_MOVE, position)
	end
end

function M:_onEndDrag(eventData)
	local pointerId = eventData.pointerId
	local position = eventData.position

	if pointerId == self._singleDragingId then
		self._singleDragingId = -999
	end
end

M.instance = M.New()

return M
