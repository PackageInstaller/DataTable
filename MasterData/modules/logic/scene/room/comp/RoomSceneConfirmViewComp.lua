-- chunkname: @modules/logic/scene/room/comp/RoomSceneConfirmViewComp.lua

module("modules.logic.scene.room.comp.RoomSceneConfirmViewComp", package.seeall)

local RoomSceneConfirmViewComp = class("RoomSceneConfirmViewComp", BaseSceneComp)

function RoomSceneConfirmViewComp:onInit()
	return
end

function RoomSceneConfirmViewComp:init(sceneId, levelId)
	if not self._confirmView then
		local viewGO = RoomUIPool.getInstance(RoomViewConfirm.prefabPath, "roomViewConfirm")
		local view = RoomViewConfirm.New()

		self._confirmView = view

		function view:_setUIPos(worldPos, offsetY, scale)
			local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)

			offsetY = offsetY or 0

			local scale = scale or 1

			transformhelper.setLocalScale(self._gocontainer.transform, scale, scale, scale)
			transformhelper.setPos(self._gocontainer.transform, bendingPos.x, bendingPos.y + offsetY, bendingPos.z)
		end

		view:__onInit()

		view.viewGO = viewGO
		view.viewName = "RoomViewConfirm"

		view:onInitViewInternal()
		view:addEventsInternal()
		view:onOpenInternal()
		view:onOpenFinishInternal()

		local scale = 0.017499999999999998

		transformhelper.setLocalScale(viewGO.transform, scale, scale, scale)
		transformhelper.setLocalRotation(view._gocontainer.transform, 90, 0, 0)
		RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	end
end

function RoomSceneConfirmViewComp:_cameraTransformUpdate()
	if self._confirmView then
		local mainCameraTrs = CameraMgr.instance:getMainCameraTrs()

		if mainCameraTrs then
			local rx, ry, rz = transformhelper.getLocalRotation(mainCameraTrs)

			transformhelper.setLocalRotation(self._confirmView._gocontainer.transform, 90, ry, 0)
		end
	end
end

function RoomSceneConfirmViewComp:getViewGO()
	return self._confirmView and self._confirmView.viewGO
end

function RoomSceneConfirmViewComp:onSceneClose()
	if self._confirmView then
		local view = self._confirmView

		self._confirmView = nil

		view:onCloseInternal()
		view:onCloseFinishInternal()
		view:removeEventsInternal()
		view:onDestroyViewInternal()
		view:__onDispose()

		if view.viewGO then
			gohelper.destroy(view.viewGO)

			view.viewGO = nil
		end

		RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	end

	self._touchComp = nil
end

return RoomSceneConfirmViewComp
