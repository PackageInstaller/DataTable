-- chunkname: @modules/logic/scene/common/camera/MainCameraMgr.lua

module("modules.logic.scene.common.camera.MainCameraMgr", package.seeall)

local MainCameraMgr = class("MainCameraMgr")

function MainCameraMgr:ctor()
	self._viewList = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function MainCameraMgr:_onOpenView(viewName)
	self:_checkCamera()
end

function MainCameraMgr:_onCloseView(viewName)
	local info = self._viewList[viewName]

	if info and info._resetCallbackOnCloseViewFinish then
		return
	end

	self:_setCamera(viewName, false)

	self._viewList[viewName] = nil

	self:_checkCamera()
end

function MainCameraMgr:_onCloseViewFinish(viewName)
	local info = self._viewList[viewName]

	if info and info._resetCallbackOnCloseViewFinish ~= true then
		return
	end

	self:_setCamera(viewName, false)

	self._viewList[viewName] = nil

	self:_checkCamera()
end

function MainCameraMgr:_onScreenResize()
	self:_checkCamera()
end

function MainCameraMgr:setCloseViewFinishReset(viewName)
	local info = self._viewList[viewName]

	if info then
		info._resetCallbackOnCloseViewFinish = true
	end
end

function MainCameraMgr:addView(viewName, setCallback, resetCallback, target)
	self._viewList[viewName] = {
		setCallback = setCallback,
		resetCallback = resetCallback,
		target = target
	}

	self:_checkCamera()
end

function MainCameraMgr:_checkCamera()
	local viewName = self:_getTopViewCamera()

	if viewName then
		self:_setCamera(viewName, true)
	end
end

function MainCameraMgr:_setCamera(viewName, isSet)
	if self._isLock then
		return
	end

	local info = self._viewList[viewName]

	if not info then
		return
	end

	if isSet then
		if info.setCallback then
			info.setCallback(info.target)
		end
	else
		self:_resetCamera()

		if info.resetCallback then
			info.resetCallback(info.target)
		end
	end
end

function MainCameraMgr:_resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false

	transformhelper.setLocalPos(camera.transform, 0, 0, 0)
end

function MainCameraMgr:_getTopViewCamera()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewNameList, 1, -1 do
		local oneViewName = openViewNameList[i]

		if self._viewList[oneViewName] then
			return oneViewName
		end
	end
end

function MainCameraMgr:setLock(value)
	self._isLock = value

	if not value then
		self:_checkCamera()
	end
end

MainCameraMgr.instance = MainCameraMgr.New()

return MainCameraMgr
