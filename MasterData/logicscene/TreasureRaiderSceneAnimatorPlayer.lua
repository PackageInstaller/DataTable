-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/treasureraider/TreasureRaiderSceneAnimatorPlayer.lua

module("logicscene.scene.component.treasureraider.TreasureRaiderSceneAnimatorPlayer", package.seeall)

local TreasureRaiderSceneAnimatorPlayer = class("TreasureRaiderSceneAnimatorPlayer")

function TreasureRaiderSceneAnimatorPlayer:ctor(scene)
	self._scene = scene
	self._animPlayer = AnimationPlayer.New()
end

function TreasureRaiderSceneAnimatorPlayer:preloadResources(posx, posy, addtionalRes, callback)
	if not self._scene then
		return
	end

	if self._resLoader then
		self._resLoader:clear()
	end

	self._scene.picker:enabled(false)

	local resList = self._scene.stage:detectSceneResources(posx, posy, addtionalRes)

	self._resLoader = MultiResLoader.New()

	self._resLoader:setResPaths(resList)
	self._resLoader:load(callback)
end

function TreasureRaiderSceneAnimatorPlayer:playWithTargets(animName, targets, finishedHandler, finishedHandlerObj)
	if not self._animPlayer then
		return
	end

	self._animGo = self._animGo or goutil.create("TreasureRaider")

	self._scene.picker:enabled(false)
	self._animPlayer:Stop()

	self._finishedHandler = finishedHandler
	self._finishedHandlerObj = finishedHandlerObj

	self._animPlayer:setFinishCallback(self._onAnimationPlayFinished, self)
	self._animPlayer:setStartCallback(self._onAnimationPlayStarted, self)
	self._animPlayer:setEvtHandler(self._handleAnimEvent, self)
	self._animPlayer:PlayAnimWithObject(self._animGo, animName, 1, true, targets, true)
end

function TreasureRaiderSceneAnimatorPlayer:_handleAnimEvent(evtName, go, param1, param2, param3, param4, param5)
	if go and go.name == "MainCamera" then
		local scene = SceneMgr.instance:getCurScene()

		if evtName == "Move" and go then
			local yOffset = scene.camera:getPosFocusYOffset()

			scene.camera:setPosFocus(param1.x, param1.y - yOffset)
			scene.stage.wholeScene:ForceDetect()

			return true
		end
	end
end

function TreasureRaiderSceneAnimatorPlayer:_onAnimationPlayStarted()
	return
end

function TreasureRaiderSceneAnimatorPlayer:_onAnimationPlayFinished()
	self._scene.picker:enabled(true)

	local finishedHandler = self._finishedHandler
	local finishedHandlerObj = self._finishedHandlerObj

	self._finishedHandler = nil
	self._finishedHandlerObj = nil

	if self._resLoader then
		self._resLoader:clear()

		self._resLoader = nil
	end

	if finishedHandler then
		if finishedHandlerObj then
			self._finishedHandler(finishedHandlerObj)
		else
			finishedHandler()
		end
	end
end

function TreasureRaiderSceneAnimatorPlayer:stop()
	self._scene.picker:enabled(true)

	self._finishedHandler = nil
	self._finishedHandlerObj = nil

	if self._animGo then
		goutil.destroy(self._animGo)

		self._animGo = nil
	end

	if self._animPlayer then
		self._animPlayer:Stop()
	end

	if self._resLoader then
		self._resLoader:clear()

		self._resLoader = nil
	end
end

function TreasureRaiderSceneAnimatorPlayer:clear()
	self:stop()

	self._scene = nil
	self._animPlayer = nil
end

function TreasureRaiderSceneAnimatorPlayer:isPlayingAnim()
	return self._animPlayer and self._animPlayer:isPlayingAnim()
end

return TreasureRaiderSceneAnimatorPlayer
