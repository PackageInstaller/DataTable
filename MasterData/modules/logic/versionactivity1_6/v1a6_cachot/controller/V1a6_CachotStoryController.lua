-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/controller/V1a6_CachotStoryController.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotStoryController", package.seeall)

local V1a6_CachotStoryController = class("V1a6_CachotStoryController", BaseController)

function V1a6_CachotStoryController:onInit()
	return
end

function V1a6_CachotStoryController:reInit()
	return
end

function V1a6_CachotStoryController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.checkPlayStory, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.CheckPlayStory, self.onSwitchLevel, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnFinishGame, self.onFinishGame, self)
end

function V1a6_CachotStoryController:checkPlayStory(viewName, viewParam)
	if viewName == ViewName.V1a6_CachotMainView then
		local storyId = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode1).value
		local param = {}

		param.mark = true
		param.isReplay = false

		if storyId and storyId ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(storyId)) then
			StoryController.instance:playStory(tonumber(storyId), param, nil, self)
		end
	end
end

function V1a6_CachotStoryController:onSwitchLevel(levelId)
	local storyId
	local rogueinfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueinfo then
		return
	end

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Cachot then
		return
	end

	if rogueinfo.layer == 1 and V1a6_CachotRoomConfig.instance:checkNextRoomIsLastRoom(rogueinfo.room) then
		storyId = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode2).value
	elseif rogueinfo.layer == 2 and V1a6_CachotRoomConfig.instance:checkNextRoomIsLastRoom(rogueinfo.room) then
		storyId = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode4).value
	end

	if storyId and storyId ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(storyId)) then
		local param = {}

		param.mark = true
		param.isReplay = false

		StoryController.instance:playStory(tonumber(storyId), param, nil, self)
	end
end

function V1a6_CachotStoryController:onFinishGame(endingId)
	local endingCfg = lua_rogue_ending.configDict[endingId]
	local storyId = endingCfg and endingCfg.storyId

	if storyId and storyId ~= 0 then
		StoryController.instance:playStory(storyId, nil, self._jump2CachotEndingView, self)
	else
		logError(string.format("cannot find endingConfig or storyConfig, endingId = %s, storyId = %s", endingId, storyId))
		self:_jump2CachotEndingView()
	end
end

function V1a6_CachotStoryController:_jump2CachotEndingView()
	V1a6_CachotController.instance:openV1a6_CachotEndingView()
end

V1a6_CachotStoryController.instance = V1a6_CachotStoryController.New()

LuaEventSystem.addEventMechanism(V1a6_CachotStoryController.instance)

return V1a6_CachotStoryController
