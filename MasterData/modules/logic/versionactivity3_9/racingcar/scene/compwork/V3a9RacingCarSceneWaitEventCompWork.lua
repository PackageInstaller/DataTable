-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/compwork/V3a9RacingCarSceneWaitEventCompWork.lua

module("modules.logic.versionactivity3_9.racingcar.scene.compwork.V3a9RacingCarSceneWaitEventCompWork", package.seeall)

local V3a9RacingCarSceneWaitEventCompWork = class("V3a9RacingCarSceneWaitEventCompWork", BaseWork)

function V3a9RacingCarSceneWaitEventCompWork:ctor(comp, event)
	self._comp = comp
	self._event = event
end

function V3a9RacingCarSceneWaitEventCompWork:onStart(context)
	local sceneId = context.sceneId
	local levelId = context.levelId

	if not self._comp then
		logError("V3a9RacingCarSceneWaitEventCompWork: 没有comp")
		self:onDone(true)

		return
	end

	if self._comp.init then
		self._comp:registerCallback(self._event, self._onEvent, self)
		self._comp:init(sceneId, levelId)
	else
		logError(string.format("%s: 没有init", self._comp.__cname))
		self:onDone(true)
	end
end

function V3a9RacingCarSceneWaitEventCompWork:_onEvent()
	if not self._comp then
		logError("V3a9RacingCarSceneWaitEventCompWork: 没有comp")

		return
	end

	self._comp:unregisterCallback(self._event, self._onEvent, self)
	self:onDone(true)
end

function V3a9RacingCarSceneWaitEventCompWork:onDestroy()
	V3a9RacingCarSceneWaitEventCompWork.super.onDestroy(self)

	if not self._comp then
		logError("V3a9RacingCarSceneWaitEventCompWork: 没有comp")

		return
	end

	self._comp:unregisterCallback(self._event, self._onEvent, self)
end

return V3a9RacingCarSceneWaitEventCompWork
