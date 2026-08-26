-- chunkname: @modules/logic/versionactivity2_4/music/controller/VersionActivity2_4MultiTouchController.lua

module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MultiTouchController", package.seeall)

local VersionActivity2_4MultiTouchController = class("VersionActivity2_4MultiTouchController", BaseController)

function VersionActivity2_4MultiTouchController:onInit()
	return
end

function VersionActivity2_4MultiTouchController:onInitFinish()
	return
end

function VersionActivity2_4MultiTouchController:addConstEvents()
	return
end

function VersionActivity2_4MultiTouchController:reInit()
	return
end

function VersionActivity2_4MultiTouchController.isMobilePlayer()
	return BootNativeUtil.isMobilePlayer()
end

function VersionActivity2_4MultiTouchController:addTouch(touchComp)
	if not VersionActivity2_4MultiTouchController.isMobilePlayer() then
		return
	end

	if self._touchList then
		table.insert(self._touchList, touchComp)
	else
		logError("addTouch touchList is nil")
	end
end

function VersionActivity2_4MultiTouchController:removeTouch(touchComp)
	if not VersionActivity2_4MultiTouchController.isMobilePlayer() then
		return
	end

	if self._touchList then
		for i, v in ipairs(self._touchList) do
			if v == touchComp then
				table.remove(self._touchList, i)

				break
			end
		end
	end
end

function VersionActivity2_4MultiTouchController:startMultiTouch(viewName)
	if not VersionActivity2_4MultiTouchController.isMobilePlayer() then
		return
	end

	self._touchList = {}
	self._touchCount = 5
	self._viewName = viewName

	TaskDispatcher.cancelTask(self._frameHandler, self)
	TaskDispatcher.runRepeat(self._frameHandler, self, 0)
end

function VersionActivity2_4MultiTouchController:_frameHandler()
	if not self._touchList then
		return
	end

	local checkOnTop = true
	local count = UnityEngine.Input.touchCount

	count = math.min(count, self._touchCount)

	for i = 1, count do
		local index = i - 1
		local touch = UnityEngine.Input.GetTouch(index)

		if touch.phase == TouchPhase.Began then
			if checkOnTop and not ViewHelper.instance:checkViewOnTheTop(self._viewName) then
				return
			end

			checkOnTop = false

			local touchPosition = touch.position

			self:_checkTouch(touchPosition)
		end
	end
end

function VersionActivity2_4MultiTouchController:_checkTouch(position)
	for i, v in ipairs(self._touchList) do
		if v:canTouch() and VersionActivity2_4MultiTouchController.isTouchOverGo(v.go, position) then
			v:touchDown()

			break
		end
	end
end

function VersionActivity2_4MultiTouchController.isTouchOverGo(goOrComp, screenPos)
	if not goOrComp or not screenPos then
		return false
	end

	local trans = goOrComp.transform
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)
	local touchPos = recthelper.screenPosToAnchorPos(screenPos, trans)
	local pivot = trans.pivot

	if touchPos.x >= -width * pivot.x and touchPos.x <= width * (1 - pivot.x) and touchPos.y <= height * pivot.x and touchPos.y >= -height * (1 - pivot.x) then
		return true
	end

	return false
end

function VersionActivity2_4MultiTouchController:endMultiTouch()
	if not VersionActivity2_4MultiTouchController.isMobilePlayer() then
		return
	end

	TaskDispatcher.cancelTask(self._frameHandler, self)

	self._touchList = nil
end

VersionActivity2_4MultiTouchController.instance = VersionActivity2_4MultiTouchController.New()

return VersionActivity2_4MultiTouchController
