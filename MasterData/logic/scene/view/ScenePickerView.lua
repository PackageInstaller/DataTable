-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/view/ScenePickerView.lua

module("logic.scene.view.ScenePickerView", package.seeall)

local M = class("ScenePickerView", ViewComponent)
local vec2Temp = Vector2.New()
local vec3Temp = Vector3.New()
local kMainHitIndex = 0
local kLongPressTriggerTime = 0.5

function M:buildUI()
	self._raycastProxy = RaycastProxy.Get(self.mainGO)

	self._raycastProxy:SetClickListener(self._onRayCastHit, self)
	self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self._raycastProxy:SetDragListener(self._onDrag, self)
	self._raycastProxy:SetEndDragListener(self._onEndDrag, self)

	self._longPressTrigger = OnceLongPressTrigger.Get(self.mainGO)

	self._longPressTrigger:AddLongPressListener(self._onLongPress, self)
	self._longPressTrigger:AddLongPressExitListener(self._onLongPressExit, self)

	self._compositeTouch = UICompositeTouch.Get(self.mainGO)

	local multiTouch = MultiTouchChecker.New()

	multiTouch:AddMultiDragListener(self._onMultiDragListener, self)
	self._compositeTouch:AddChecker(multiTouch)

	local attachRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.Map)

	goutil.addChildToParent(self.mainGO, attachRoot)
end

function M:destroyUI()
	self._raycastProxy:RemoveClickListener()
	self._raycastProxy:RemoveBeginDragListener()
	self._raycastProxy:RemoveDragListener()
	self._raycastProxy:RemoveEndDragListener()

	self._raycastProxy = nil

	self._longPressTrigger:RemoveLongPressListener()
	self._longPressTrigger:RemoveLongPressExitListener()

	self._longPressTrigger = nil

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = nil
end

function M:onEnter()
	self:setEnable(true)
	self:reloadLayerMask()
	self._longPressTrigger:SetTriggerTime(kLongPressTriggerTime)
	ScenePickerViewFacade.instance:registerView(self)
end

function M:onExit()
	ScenePickerViewFacade.instance:unregisterView()
end

function M:setEnable(enable)
	goutil.setActive(self.mainGO, enable)
end

function M:reloadLayerMask()
	local sceneType = SceneMgr.instance:getCurSceneType()

	self._raycastProxy.LayerMask = Astral.LayerUtil.GetLayerMask(unpack(SceneEnum.TypeToPickerLayers[sceneType]))
end

function M:getRaycastProxy()
	return self._raycastProxy
end

function M:getHitCount()
	return self._raycastProxy:GetHitCount()
end

function M:getHitPointXYZ(index)
	return self._raycastProxy:GetHitPoint(index, 0, 0, 0)
end

function M:getHitPosByScreenPointWithMask(screenX, screenY, layerMask)
	vec2Temp:Set(screenX, screenY)

	return self._raycastProxy:GetHitPosByScreenPointWithMask(vec2Temp, layerMask)
end

function M:testHitScreenPoint(screenX, screenY)
	if self._raycastProxy:TestHitScreenPoint(screenX, screenY) then
		return self._raycastProxy:GetHitPoint(kMainHitIndex, 0, 0, 0)
	else
		return false
	end
end

function M:_onRayCastHit(isHit, clickCount)
	local hitPosX, hitPosY, hitPosZ = 0, 0, 0
	local hitGO = self._raycastProxy:GetHitGameObject(kMainHitIndex)

	if hitGO and isHit then
		hitPosX, hitPosY, hitPosZ = self._raycastProxy:GetHitPoint(kMainHitIndex, 0, 0, 0)
	end

	local hitPoint = vec3Temp

	hitPoint:Set(hitPosX, hitPosY, hitPosZ)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_HIT, isHit, hitGO, hitPoint, clickCount)
end

function M:_onBeginDrag(x, y, pointerId)
	local hitPoint = vec3Temp

	hitPoint:Set(x, y, 0)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_BEGIN_DRAG, hitPoint, pointerId)
end

function M:_onDrag(x, y, pointerId)
	local hitPoint = vec3Temp

	hitPoint:Set(x, y, 0)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_DRAG, hitPoint, pointerId)
end

function M:_onEndDrag(x, y, pointerId)
	local hitPoint = vec3Temp

	hitPoint:Set(x, y, 0)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_END_DRAG, hitPoint, pointerId)
end

function M:_onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_MULTI_DRAG, centerX, centerY, scale, distance, isFirstMultiDrag)
end

function M:_onLongPress(isOn, x, y)
	local hitPoint = vec3Temp

	hitPoint:Set(x, y, 0)
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_LONGPRESS, isOn, hitPoint)
end

function M:_onLongPressExit()
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_PICKER_LONGPRESS_EXIT)
end

return M
