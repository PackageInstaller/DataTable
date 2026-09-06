-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompGreetOnClosed.lua

module("logicscene.scene.unit.component.UnitCompGreetOnClosed", package.seeall)

local UnitCompGreetOnClosed = class("UnitCompGreetOnClosed", UnitComponentBase)
local playDistance = 5
local stateExit = AnimatorListener.STATE_EXIT
local greetCd = 10

function UnitCompGreetOnClosed:onUnitVisible(go)
	self._isVisible = true

	local animator = self._unit.spine:getAnimator()

	if animator then
		local behaviours = animator:GetBehaviours(AnimatorHash.animGreetFullPath, 0)

		if behaviours and behaviours.Length > 0 then
			self._audioListener = behaviours[0]
		end
	end

	if self._audioListener then
		self._audioListener:AddListener(self._onGreetStateChange, self)
	end
end

function UnitCompGreetOnClosed:onUnitInVisible(go)
	self._isVisible = nil
	self._isPlayingGreet = nil
	self._isGreetPlayed = nil

	if self._audioListener then
		self._audioListener:RemoveListener()
	end
end

function UnitCompGreetOnClosed:update(deltaTime)
	if self._lastTime then
		self._lastTime = self._lastTime + deltaTime
	end

	if not self._isVisible or self._isPlayingGreet then
		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	local x, y = self._unit.transform:getPos()
	local dist = mainPlayer.transform:dist2D(x, y)

	if dist < playDistance then
		if not self._isGreetPlayed then
			if not self._isPlayingGreet and self._lastTime and self._lastTime < greetCd then
				return
			end

			self._isGreetPlayed = true

			if not self._isPlayingGreet then
				self._lastTime = nil
				self._isPlayingGreet = true

				self._unit.spine:play(MainPlayerAnimState.Greet)
			end
		end
	else
		self._isGreetPlayed = nil
	end
end

function UnitCompGreetOnClosed:_onGreetStateChange(state, animator, stateInfo, layerIndex)
	if state == stateExit then
		self._isPlayingGreet = nil
		self._lastTime = 0
	end
end

return UnitCompGreetOnClosed
