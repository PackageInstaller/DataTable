-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/SceneCompIdleAnimations.lua

module("logicscene.scene.component.mainplayer.SceneCompIdleAnimations", package.seeall)

local SceneCompIdleAnimations = class("SceneCompIdleAnimations", SceneComponentBase)
local playPlayersLimit = 3

function SceneCompIdleAnimations:ctor(scene)
	SceneCompIdleAnimations.super.ctor(self, scene)

	self._currPlayingAnimationUnits = nil
	self._waitingPlayingAnimationUnits = nil
	self._currPlayingAnimationsNum = 0
end

function SceneCompIdleAnimations:onEnterScene(sceneId, bornX, bornZ)
	self._currPlayingAnimationUnits = nil
	self._waitingPlayingAnimationUnits = nil
	self._currPlayingAnimationsNum = 0
end

function SceneCompIdleAnimations:onEnterSceneFinished()
	return
end

function SceneCompIdleAnimations:onExitScene()
	self._currPlayingAnimationUnits = nil
	self._waitingPlayingAnimationUnits = nil
	self._currPlayingAnimationsNum = 0
end

function SceneCompIdleAnimations:waitingPlayAnimation(unit)
	self._waitingPlayingAnimationUnits = self._waitingPlayingAnimationUnits or {}

	table.insert(self._waitingPlayingAnimationUnits, unit)
	self:playNextAnimation()
end

function SceneCompIdleAnimations:stopWaitingPlayAnimation(unit)
	if self._waitingPlayingAnimationUnits then
		local index = table.indexof(self._waitingPlayingAnimationUnits, unit)

		if index then
			table.remove(self._waitingPlayingAnimationUnits, index)
		end
	end
end

function SceneCompIdleAnimations:playNextAnimation()
	if self._waitingPlayingAnimationUnits and self._currPlayingAnimationsNum < playPlayersLimit then
		local unit = self._waitingPlayingAnimationUnits[1]

		if unit then
			table.remove(self._waitingPlayingAnimationUnits, 1)
			self:playAnimation(unit)
		end
	end
end

function SceneCompIdleAnimations:playAnimation(unit)
	self._currPlayingAnimationUnits = self._currPlayingAnimationUnits or {}

	table.insert(self._currPlayingAnimationUnits, unit)

	self._currPlayingAnimationsNum = self._currPlayingAnimationsNum + 1

	unit.idleAnimation:startPlayAnimation()
end

function SceneCompIdleAnimations:stopPlayAnimation(unit)
	if self._currPlayingAnimationUnits then
		local index = table.indexof(self._currPlayingAnimationUnits, unit)

		if index then
			table.remove(self._currPlayingAnimationUnits, index)

			self._currPlayingAnimationsNum = self._currPlayingAnimationsNum - 1
		end
	end
end

function SceneCompIdleAnimations:onPlayAnimationFinish(unit)
	self:stopPlayAnimation(unit)
	self:playNextAnimation()
end

return SceneCompIdleAnimations
