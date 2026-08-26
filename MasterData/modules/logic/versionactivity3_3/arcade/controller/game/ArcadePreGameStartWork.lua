-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadePreGameStartWork.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadePreGameStartWork", package.seeall)

local ArcadePreGameStartWork = class("ArcadePreGameStartWork", BaseWork)

function ArcadePreGameStartWork:ctor(comp, controller, event)
	self._comp = comp
	self._controller = controller
	self._event = event
end

function ArcadePreGameStartWork:onStart(context)
	local needWaitEvent = false

	if self._controller and self._event then
		self._controller.instance:registerCallback(self._event, self._onReceiveEvent, self)

		needWaitEvent = true
	end

	if self._comp and self._comp.onPreGameStart then
		self._comp:onPreGameStart()
	else
		logError("ArcadePreGameStartWork.onStart error, no comp onPreGameStart func")
	end

	if not needWaitEvent then
		self:onDone(true)
	end
end

function ArcadePreGameStartWork:_onReceiveEvent()
	self:onDone(true)
end

function ArcadePreGameStartWork:clearWork()
	if self._controller then
		self._controller.instance:unregisterCallback(self._event, self._onReceiveEvent, self)
	end

	self._controller = nil
	self._event = nil
end

return ArcadePreGameStartWork
