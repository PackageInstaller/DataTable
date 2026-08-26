-- chunkname: @modules/logic/scene/fight/comp/FightSceneDirector.lua

module("modules.logic.scene.fight.comp.FightSceneDirector", package.seeall)

local FightSceneDirector = class("FightSceneDirector", BaseSceneComp)

FightSceneDirector.MinTime = 2

function FightSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function FightSceneDirector:onSceneStart(sceneId, levelId)
	FightGameHelper.initGameMgr()

	self._sceneId = sceneId

	FightStrUtil.instance:init()
	FightSkillBehaviorMgr.instance:init()
	FightRenderOrderMgr.instance:init()
	FightNameMgr.instance:init()
	FightFloatMgr.instance:init()
	FightVideoMgr.instance:init()
	FightSkillMgr.instance:init()
	FightConfig.instance:_checkSkill()

	local grade = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High)

	if grade == ModuleEnum.Performance.High then
		SpineFpsMgr.instance:set(SpineFpsMgr.FightScene)
	end

	self._hasLoadScene = false
	self._hasPreload = false
	self._fightLoadingView = true
	self._startTime = Time.realtimeSinceStartup

	FightController.instance:registerCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)
	self._scene.preloader:registerCallback(FightSceneEvent.OnPreloadFinish, self._onPreloadFinish, self)
	self._scene.preloader:startPreload(false)

	self._sceneStartTime = Time.time

	FightGameMgr.sceneLevelMgr:loadScene(sceneId, levelId)
end

function FightSceneDirector:registRespBeginFight()
	FightController.instance:registerCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
end

function FightSceneDirector:onSceneClose()
	TaskDispatcher.cancelTask(self._delayStart, self)
	TaskDispatcher.cancelTask(self._delayCloseFightLoadingView, self)
	SpineFpsMgr.instance:remove(SpineFpsMgr.FightScene)
	FightController.instance:unregisterCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)
	self._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, self._onPreloadFinish, self)
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, self._respBeginFight, self)
	self._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, self._onPrepareFinish, self)
end

function FightSceneDirector:_onLevelLoaded(levelId)
	FightController.instance:unregisterCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)

	self._hasLoadScene = true

	self:_log("场景")

	if GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		module_views_preloader.FightLoadingView(function()
			ViewMgr.instance:openView(ViewName.FightLoadingView, self._sceneId, true)
			GameSceneMgr.instance:hideLoading(SceneType.Fight)

			self._fightLoadingView = false

			local elapse = Time.time - self._sceneStartTime + 0.6
			local minTime = FightSceneDirector.MinTime - elapse
			local delay = minTime > 0 and minTime or 0.1

			TaskDispatcher.runDelay(self._delayCloseFightLoadingView, self, delay)
		end)
	end

	self:_checkPrepared()
end

function FightSceneDirector:_delayCloseFightLoadingView()
	self._fightLoadingView = true

	self:_checkPrepared()
end

function FightSceneDirector:_onPreloadFinish()
	self._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, self._onPreloadFinish, self)

	self._hasPreload = true

	self:_log("资源")
	self:_checkPrepared()
end

function FightSceneDirector:_respBeginFight()
	FightController.instance:unregisterCallback(FightEvent.RespBeginFight, self._respBeginFight, self)

	if FightModel.instance:getFightParam().isReplay then
		FightReplayController.instance:reqReplay(self._continuePreload, self)
	else
		self:_continuePreload()
	end
end

function FightSceneDirector:_continuePreload()
	self._scene.preloader:registerCallback(FightSceneEvent.OnPreloadFinish, self._onPrepareFinish, self)

	self._startTime = Time.realtimeSinceStartup

	self._scene.preloader:startPreload(true)
end

function FightSceneDirector:_checkPrepared()
	if self._hasPreload and self._hasLoadScene and self._fightLoadingView then
		local fightParam = FightModel.instance:getFightParam()

		if fightParam.preload then
			local episodeCo = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

			if SeasonFightHandler.checkSeasonAndOpenGroupFightView(fightParam, episodeCo) then
				-- block empty
			elseif episodeCo.type == DungeonEnum.EpisodeType.Cachot then
				V1a6_CachotHeroGroupController.instance:openGroupFightView(fightParam.battleId, fightParam.episodeId)
			elseif episodeCo.type == DungeonEnum.EpisodeType.Rouge then
				RougeHeroGroupController.instance:openGroupFightView(fightParam.battleId, fightParam.episodeId)
			else
				HeroGroupController.instance:openGroupFightView(fightParam.battleId, fightParam.episodeId, fightParam.adventure)
			end

			self:registRespBeginFight()
		else
			if fightParam.fightActType == FightEnum.FightActType.Act174 then
				self:registRespBeginFight()
				self:dispatchEvent(FightSceneEvent.OnPrepareFinish)

				local reply = FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu)

				return
			end

			if fightParam.isReplay or FightDataHelper.stateMgr.isReplay then
				FightReplayController.instance:reqReplay(function()
					self._scene:onPrepared()
				end)
			else
				self._scene:onPrepared()
			end
		end

		self:dispatchEvent(FightSceneEvent.OnPrepareFinish)
	end
end

function FightSceneDirector:_onPrepareFinish()
	self._scene.preloader:unregisterCallback(FightSceneEvent.OnPreloadFinish, self._onPrepareFinish, self)
	self:_log("资源2")
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroGroupExit)

	local defaultTime = 0.4
	local time = {
		time = defaultTime
	}

	FightController.instance:dispatchEvent(FightEvent.ModifyDelayTime, time)
	TaskDispatcher.runDelay(self._delayStart, self, time.time or defaultTime)
end

function FightSceneDirector:_delayStart()
	self._scene:onPrepared()
end

function FightSceneDirector:_log(text)
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId
	local episodeCO = episodeId and lua_episode.configDict[episodeId]

	if episodeCO then
		if not episodeCO.name then
			local episodeName = ""

			logNormal(string.format("%s 战斗%s加载完成了，耗时%.3fs", episodeName, text, Time.realtimeSinceStartup - self._startTime))
		end
	end
end

return FightSceneDirector
