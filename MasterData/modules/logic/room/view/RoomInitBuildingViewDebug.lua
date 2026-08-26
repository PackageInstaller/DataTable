-- chunkname: @modules/logic/room/view/RoomInitBuildingViewDebug.lua

module("modules.logic.room.view.RoomInitBuildingViewDebug", package.seeall)

local RoomInitBuildingViewDebug = class("RoomInitBuildingViewDebug", BaseView)

function RoomInitBuildingViewDebug:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInitBuildingViewDebug:addEvents()
	return
end

function RoomInitBuildingViewDebug:removeEvents()
	return
end

function RoomInitBuildingViewDebug:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self.viewGO)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnlyTouch(true)
	self._touchEventMgr:SetOnDragBeginCb(self._onDragBegin, self)
	self._touchEventMgr:SetOnDragCb(self._onDrag, self)
	self._touchEventMgr:SetOnDragEndCb(self._onDragEnd, self)
	self._touchEventMgr:SetScrollWheelCb(self._onScrollWheel, self)
	logNormal("鼠标左键点击滑动旋转角度")
	logNormal("鼠标滑轮调整距离")
	logNormal("Shift+鼠标左键点击滑动调整高度")
	logNormal("Shift+G输出参数")
	TaskDispatcher.runRepeat(self._onFrame, self, 0.01)
end

function RoomInitBuildingViewDebug:_onFrame()
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.G) then
		local realCameraParam = self._scene.camera:getRealCameraParam()

		logNormal("部件初始镜头参数:")

		local paramList = {
			string.format("%.3f", realCameraParam.rotate),
			string.format("%.3f", realCameraParam.angle),
			string.format("%.3f", realCameraParam.distance),
			string.format("%.3f", realCameraParam.height)
		}
		local paramStr = table.concat(paramList, "#")

		logNormal(paramStr)
	end
end

function RoomInitBuildingViewDebug:_onDragBegin(screenPos)
	self._curPos = screenPos
end

function RoomInitBuildingViewDebug:_onDrag(screenPos)
	if self._curPos then
		local dragPos = self:_getNormalizedDrag(screenPos - self._curPos)

		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
			self:_raiseCamera(dragPos)
		else
			self:_rotateCamera(dragPos)
		end
	end

	self._curPos = screenPos
end

function RoomInitBuildingViewDebug:_onDragEnd(screenPos)
	self._curPos = nil
end

function RoomInitBuildingViewDebug:_onScrollWheel(delta)
	self:_zoomCamera(delta)
end

function RoomInitBuildingViewDebug:_rotateCamera(dragPos)
	local realCameraParam = LuaUtil.deepCopy(self._scene.camera:getRealCameraParam())

	realCameraParam.rotate = realCameraParam.rotate + dragPos.x * 0.005
	realCameraParam.angle = realCameraParam.angle - dragPos.y * 0.005
	realCameraParam.rotate = RoomRotateHelper.getMod(realCameraParam.rotate, Mathf.PI * 2)
	realCameraParam.angle = RoomRotateHelper.getMod(realCameraParam.angle, Mathf.PI * 2)
	realCameraParam.angle = Mathf.Clamp(realCameraParam.angle, 10 * Mathf.Deg2Rad, 80 * Mathf.Deg2Rad)

	self._scene.camera:tweenRealCamera(realCameraParam, nil, nil, nil, true)
end

function RoomInitBuildingViewDebug:_raiseCamera(dragPos)
	local realCameraParam = LuaUtil.deepCopy(self._scene.camera:getRealCameraParam())

	realCameraParam.height = realCameraParam.height - dragPos.y * 0.005
	realCameraParam.height = Mathf.Clamp(realCameraParam.height, -0.2, 1)

	self._scene.camera:tweenRealCamera(realCameraParam, nil, nil, nil, true)
end

function RoomInitBuildingViewDebug:_zoomCamera(delta)
	local realCameraParam = LuaUtil.deepCopy(self._scene.camera:getRealCameraParam())

	realCameraParam.distance = realCameraParam.distance - delta * 0.2
	realCameraParam.distance = Mathf.Clamp(realCameraParam.distance, 0.5, 3)

	self._scene.camera:tweenRealCamera(realCameraParam, nil, nil, nil, true)
end

function RoomInitBuildingViewDebug:_refeshUI()
	return
end

function RoomInitBuildingViewDebug:onOpen()
	self:_refeshUI()
end

function RoomInitBuildingViewDebug:onClose()
	return
end

function RoomInitBuildingViewDebug:onDestroyView()
	TaskDispatcher.cancelTask(self._onFrame, self)

	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end
end

function RoomInitBuildingViewDebug:_getNormalizedDrag(deltaPos)
	local screenScaleX = 1920 / UnityEngine.Screen.width
	local screenScaleY = 1920 / UnityEngine.Screen.height

	return Vector2(deltaPos.x * screenScaleX, deltaPos.y * screenScaleY)
end

return RoomInitBuildingViewDebug
