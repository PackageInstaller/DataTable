-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/animations/SeasonSceneAnimatiorPlayer.lua

module("logicscene.scene.component.season.animations.SeasonSceneAnimatiorPlayer", package.seeall)

local SeasonSceneAnimatiorPlayer = class("SeasonSceneAnimatiorPlayer")

function SeasonSceneAnimatiorPlayer:ctor(scene)
	self._scene = scene
	self._animPlayer = AnimationPlayer.New()
end

function SeasonSceneAnimatiorPlayer:preloadResources(posx, posy, addtionalRes, callback)
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

function SeasonSceneAnimatiorPlayer:setTranspoints(transpoints, fogs)
	self._transpoints = transpoints
	self._transpointFogs = fogs
end

function SeasonSceneAnimatiorPlayer:setBossNode(bossNode)
	self._bossNode = bossNode
end

function SeasonSceneAnimatiorPlayer:playWithTargets(animName, targets, finishedHandler, finishedHandlerObj)
	if not self._animPlayer then
		return
	end

	self._animGo = self._animGo or goutil.create("SeasonAMPlayer")

	self._scene.picker:enabled(false)
	self._animPlayer:Stop()

	self._finishedHandler = finishedHandler
	self._finishedHandlerObj = finishedHandlerObj

	self._animPlayer:setFinishCallback(self._onAnimationPlayFinished, self)
	self._animPlayer:setStartCallback(self._onAnimationPlayStarted, self)
	self._animPlayer:setEvtHandler(self._handleAnimEvent, self)
	self._animPlayer:PlayAnimWithObject(self._animGo, animName, 1, true, targets, true)
end

function SeasonSceneAnimatiorPlayer:_handleAnimEvent(evtName, go, param1, param2, param3, param4, param5)
	if evtName == "Move" and go then
		if go.name == "MainCamera" then
			local scene = SceneMgr.instance:getCurScene()
			local yOffset = scene.camera:getPosFocusYOffset()

			scene.camera:setPosFocus(param1.x, param1.y - yOffset)

			local scene = SceneMgr.instance:getCurScene()

			scene.stage.wholeScene:ForceDetect()

			return true
		elseif string.find(go.name, "leader_") then
			local teamUnitId = checknumber(string.sub(go.name, 8))
			local teamUnit = self._scene.unitFactory:getUnit(UnitTag.Player, teamUnitId)

			if teamUnit then
				teamUnit.transform:setPos(param1.x, param1.y, nil, true)

				return true
			end
		end
	elseif evtName == "SendMsg" then
		if param1 == "boss_show" then
			if self._bossNode then
				GoUtil.SetVisible(self._bossNode, true)
			end
		elseif param1 == "boss_hide" then
			if self._bossNode then
				GoUtil.SetVisible(self._bossNode, false)
			end
		elseif param1 == "eff_disappear" then
			self._scene.fogsMgr:destroyUnlockTranspointEff()
		elseif param1 == "unlock_transpoint" then
			if not self._transpoints then
				return true
			end

			local idx = checknumber(param2) + 1
			local unit = self._transpoints[idx]

			if not unit then
				return true
			end

			unit.gridEvent:setPrepareTranspointAnim(false)

			if not self._transpointFogs then
				return true
			end

			local fog = self._transpointFogs[idx]

			if not fog then
				return true
			end

			fog:forceDisappear()
		end

		return true
	elseif evtName == "PlayStory" then
		if self._replaceStoryId then
			local storyId = self._replaceStoryId

			self._replaceStoryId = nil

			self._animPlayer:_onPlayStory(go, storyId)
		else
			self._animPlayer:_onPlayStory(go, param1)
		end

		return true
	end
end

function SeasonSceneAnimatiorPlayer:setReplaceStoryId(storyId)
	self._replaceStoryId = storyId
end

function SeasonSceneAnimatiorPlayer:_onAnimationPlayStarted()
	ViewMgr.instance:close(ViewName.SeasonMiniMapView)
end

function SeasonSceneAnimatiorPlayer:_onAnimationPlayFinished()
	self._scene.picker:enabled(true)

	local finishedHandler = self._finishedHandler
	local finishedHandlerObj = self._finishedHandlerObj

	self._finishedHandler = nil
	self._finishedHandlerObj = nil
	self._transpoints = nil
	self._transpointFogs = nil
	self._bossNode = nil

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

function SeasonSceneAnimatiorPlayer:stop()
	self._scene.picker:enabled(true)

	self._finishedHandler = nil
	self._finishedHandlerObj = nil
	self._bossNode = nil

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

	self._replaceStoryId = nil
end

function SeasonSceneAnimatiorPlayer:clear()
	self:stop()

	self._scene = nil
	self._animPlayer = nil
	self._replaceStoryId = nil
end

function SeasonSceneAnimatiorPlayer:isPlayingAnim()
	return self._animPlayer and self._animPlayer:isPlayingAnim()
end

return SeasonSceneAnimatiorPlayer
