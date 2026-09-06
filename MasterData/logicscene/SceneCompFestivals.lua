-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/SceneCompFestivals.lua

module("logicscene.scene.component.SceneCompFestivals", package.seeall)

local SceneCompFestivals = class("SceneCompFestivals", SceneComponentBase)

function SceneCompFestivals:onEnterScene(sceneId, bornX, bornZ)
	SceneCompFestivals.super.onEnterScene(self, sceneId, bornX, bornZ)

	self._currFrstival = self._scene:getFestival()

	if not string.nilorempty(self._currFrstival) then
		self._currFrstivalMo = SceneFestivalMgr.instance:getFesvital(sceneId, self._currFrstival)
	end

	self._currFrstivalMo = self._currFrstivalMo or SceneFestivalMgr.instance:getNextActiveFesvital(sceneId)

	self:_checkWanShengJieEff()
end

function SceneCompFestivals:_checkWanShengJieEff()
	self._playEffTimeStamp = -1

	if self._currFrstival == "wanshengjie" then
		local dTime = ServerTime.nowDateServerLook()

		self._playEffTimeStamp = GameUtil.date2time(dTime.year, dTime.month, dTime.day, dTime.hour + 1, 0, 0) - ServerTime.now()
	end
end

function SceneCompFestivals:_updateWanShengJieEff(deltaTime)
	if not self._playEffTimeStamp or self._playEffTimeStamp < 0 then
		return
	end

	self._playEffTimeStamp = self._playEffTimeStamp - deltaTime

	if self._playEffTimeStamp <= 0 then
		self._playEffTimeStamp = -1

		if self._effectWanShengJie then
			GameEffectManager.instance:stopEffect(self._effectWanShengJie)

			self._effectWanShengJie = nil
		end

		self._effectWanShengJie = GameEffectManager.instance:playEffect("effect/prefabs/scene/fx_scene_aoqicheng/prefab/fx_scene_bianfu_shu_aqc_wsj.prefab", false, 5)

		self._effectWanShengJie:setPos(30.52, 20.34, -12000)
		self._effectWanShengJie:setSortingOrder(19999)
		self._effectWanShengJie:setActive(true)
		self:_checkWanShengJieEff()
	end
end

function SceneCompFestivals:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompFestivals:onExitScene()
	self._currFrstival = nil
	self._currFrstivalMo = nil
	self._playEffTimeStamp = -1

	if self._effectWanShengJie then
		GameEffectManager.instance:stopEffect(self._effectWanShengJie)

		self._effectWanShengJie = nil
	end
end

function SceneCompFestivals:update(deltaTime)
	if self._currFrstivalMo then
		local now = ServerTime.now()
		local time = 0

		if self._currFrstivalMo:isInPeriod(now) then
			if self._currFrstivalMo.festival == self._currFrstival then
				time = self._currFrstivalMo:timeToClosed(now)
			end
		else
			time = self._currFrstivalMo:timeToOpened(now)
		end

		if time <= 0 then
			local festival

			if self._currFrstivalMo.festival ~= self._currFrstival then
				festival = self._currFrstivalMo.festival
			end

			self._currFrstivalMo = nil

			SceneFestivalMgr.instance:exchangeFestival(festival)
		end

		self:_updateWanShengJieEff(deltaTime)
	end
end

return SceneCompFestivals
