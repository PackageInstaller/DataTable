-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonPVEBossStoryHandler.lua

module("logic.extensions.season.controller.SeasonPVEBossStoryHandler", package.seeall)

local SeasonPVEBossStoryHandler = class("SeasonPVEBossStoryHandler")

function SeasonPVEBossStoryHandler:ctor()
	return
end

function SeasonPVEBossStoryHandler:reset()
	self._ids = nil
	self._curIndex = nil
	self._callback = nil
	self._notPlayNext = nil

	self:_dispose()
end

function SeasonPVEBossStoryHandler:play(ids, callback)
	if self._isPlayStory == true and self._ids and #self._ids > 0 then
		for i, v in ipairs(ids) do
			table.insert(self._ids, v)
		end
	else
		self:reset()

		self._ids = ids
		self._curIndex = 0
		self._callback = callback

		self:_checkNext()
	end

	self._isPlayStory = true
end

function SeasonPVEBossStoryHandler:stop()
	self:reset()
end

function SeasonPVEBossStoryHandler:_checkNext()
	self:_dispose()

	if self._curIndex == nil then
		self._isPlayStory = false

		return
	end

	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._ids then
		self._isPlayStory = false

		GameUtil.callBack(self._callback)

		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local id = self._ids[self._curIndex]
	local config = SeasonConfig.instance:getBossPhaseStoryConfig(seasonId, id)

	if config then
		if config.storyType == 1 then
			self:_playWordStory(checknumber(config.params))
		elseif config.storyType == 2 then
			self:_playTxtStory(config.params)
		elseif config.storyType == 3 then
			self:_playPrefabStory(config.params)
		elseif config.storyType == 4 then
			self:_playMoveCamare(checknumber(config.params))
		elseif config.storyType == 5 then
			self:_playShowOut(checknumber(config.params))
		elseif config.storyType == 6 then
			self:_playLocalBattle(config.params)
		end
	else
		printError("找不到剧情id", id)
		self:_checkNext()
	end
end

function SeasonPVEBossStoryHandler:_playWordStory(storyId)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryEnded, self)
	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function SeasonPVEBossStoryHandler:_playTxtStory(filePath)
	self._animPlayer = AnimationPlayer.play(filePath, self._onStoryEnded, nil, self)
end

function SeasonPVEBossStoryHandler:_playPrefabStory(filePath)
	local eff = UIEffectManager.instance:playScreenEffect(filePath, Vector2.New(0, 0), false, nil, self._onStoryEnded, nil, self)

	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._effect = eff
end

function SeasonPVEBossStoryHandler:_playMoveCamare(jumpTo)
	local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(jumpTo)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.eventsAnimation then
		scene.eventsAnimation:playCamera2Grid(gridX, gridY, self._onStoryEnded, self)
	end
end

function SeasonPVEBossStoryHandler:_playShowOut(showGrid)
	local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(showGrid)
	local scene = SceneMgr.instance:getCurScene()

	scene.eventsAnimation:playS2BossShowAnim(gridX, gridY, self._onStoryEnded, self)
end

function SeasonPVEBossStoryHandler:_playLocalBattle(params)
	local fileNames = string.split(params, "#")

	SeasonPVEBossController.instance:setLocalBattle()

	BattleModel.instance.isPlayingOnlyLocalBattle = true

	local paths = {}

	for i, v in ipairs(fileNames) do
		table.insert(paths, "scene/battle/local/" .. v .. ".txt")
	end

	BattleController.instance:startLocalBattle(paths[1], paths[2], paths[3])
	GlobalDispatcher:addListener(GlobalNotify.SeasonBattleStoryEnd, self._onStoryEnded, self)
end

function SeasonPVEBossStoryHandler:_dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonBattleStoryEnd, self._onStoryEnded, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryEnded, self)

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	if self._animPlayer then
		self._animPlayer:Stop()

		self._animPlayer = nil
	end
end

function SeasonPVEBossStoryHandler:_onStoryEnded()
	self:_dispose()
	self:_checkNext()
end

SeasonPVEBossStoryHandler.instance = SeasonPVEBossStoryHandler.New()

return SeasonPVEBossStoryHandler
