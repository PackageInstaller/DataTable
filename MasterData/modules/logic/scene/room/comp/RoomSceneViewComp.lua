-- chunkname: @modules/logic/scene/room/comp/RoomSceneViewComp.lua

module("modules.logic.scene.room.comp.RoomSceneViewComp", package.seeall)

local RoomSceneViewComp = class("RoomSceneViewComp", BaseSceneComp)

RoomSceneViewComp.OnOpenView = 1

function RoomSceneViewComp:onInit()
	return
end

function RoomSceneViewComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)

	self._views = {
		[ViewName.RoomView] = false
	}

	for viewName, _ in pairs(self._views) do
		ViewMgr.instance:openView(viewName, true)
	end
end

function RoomSceneViewComp:_onOpenView(viewName)
	if self._views[viewName] ~= nil then
		self._views[viewName] = true

		self:_check()
	end
end

function RoomSceneViewComp:_check()
	for _, result in pairs(self._views) do
		if result == false then
			return
		end
	end

	local openViews = RoomController.instance:getOpenViews()

	for _, viewParams in ipairs(openViews) do
		if viewParams.viewName == ViewName.RoomInitBuildingView then
			RoomMapController.instance:openRoomInitBuildingView(0, viewParams.param)
		else
			ViewMgr.instance:openView(viewParams.viewName, viewParams.param)
		end
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	self:dispatchEvent(RoomSceneViewComp.OnOpenView)
end

function RoomSceneViewComp:onSceneClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._onOpenView, self)

	for viewName, _ in pairs(self._views) do
		ViewMgr.instance:closeView(viewName, true)
	end

	ViewMgr.instance:closeAllPopupViews()
end

return RoomSceneViewComp
