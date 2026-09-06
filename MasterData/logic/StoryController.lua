-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/controller/StoryController.lua

module("logic.extensions.story.controller.StoryController", package.seeall)

local StoryController = class("StoryController", BaseController)

function StoryController:onInit()
	StoryController.super.onInit(self)
	self.registerNotify(self, GlobalNotify.StartStory, self.startStory, self)
	self.registerNotify(self, GlobalNotify.PushStory, self.pushStory, self)
	self:onReset()
end

function StoryController:onReset()
	self.firstStoryId = nil
	self._isDelayClosingMaskView = nil
	self.isFirstltPlayStoryBg = true
	self.isOpeningStoryview = nil
end

function StoryController:onSceneLoadedFinish(sceneType, sceneId)
	if sceneType ~= SceneType.Battle then
		local battleStory = StoryModel.instance:getBattleStory()

		if battleStory then
			StoryModel.instance:setBattleStory()
			self:finishCurrStory()
			self:_startStory()
		end
	end
end

function StoryController:pushStory(storyId, storyType)
	if self:isPlaying(storyId) then
		return
	end

	storyType = storyType or StoryModel.StoryType.MainTask

	StoryModel.instance:pushStoryById(storyId, storyType)
	self:_traceStoryStart(storyId)
	self:sensorsTrackStoryStart(storyId, storyType)
	self:_startStory()
end

function StoryController:startStory(storyId, storyType)
	if self:isPlaying(storyId) then
		return
	end

	storyType = storyType or StoryModel.StoryType.MainTask

	StoryModel.instance:setStoryById(storyId, storyType)
	self:_traceStoryStart(storyId)
	self:sensorsTrackStoryStart(storyId, storyType)
	self:_startStory()
end

function StoryController:isPlaying(storyId)
	local currPlayingStory = StoryModel.instance:getCurStory()

	if currPlayingStory and currPlayingStory.storyId == storyId then
		return true
	end

	local stories = StoryModel.instance:getStories()

	if stories then
		for i = 1, #stories do
			if stories[i].storyId == storyId then
				return true
			end
		end
	end
end

function StoryController:sensorsTrackStoryStart(storyId, storyType)
	storyType = storyType or StoryModel.StoryType.MainTask

	if storyType ~= StoryModel.StoryType.SCCopy then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local sceneName
	local sceneType = scene:getSceneType()

	if sceneType == SceneType.City then
		local sceneId = scene:getSceneId()
		local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

		if sceneCo then
			sceneName = sceneCo.scene_name
		end
	elseif sceneType == SceneType.Battle then
		sceneName = "战斗场景"
	end

	local properties = {}

	if storyType == StoryModel.StoryType.SCCopy then
		properties.action_name = "开始播放运营副本剧情"
	end

	properties.StoryID = tostring(storyId)
	properties.StoryName = sceneName or ""
	properties.UserId = RoleModel.instance:getUserId()

	BootstrapUtil.sensorsTrack("501208", properties, true)
end

function StoryController:sensorsTrackStoryPass(storyId, storyType, ispass)
	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local sceneName
	local sceneType = scene:getSceneType()

	if sceneType == SceneType.City then
		local sceneId = scene:getSceneId()
		local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

		if sceneCo then
			sceneName = sceneCo.scene_name
		end
	elseif sceneType == SceneType.Battle then
		sceneName = "战斗场景"
	end

	storyType = storyType or StoryModel.StoryType.MainTask

	local properties = {}

	if ispass then
		if storyType == StoryModel.StoryType.MainTask then
			properties.action_name = "跳过主线任务剧情"
		elseif storyType == StoryModel.StoryType.PlotCopy then
			properties.action_name = "跳过剧情副本剧情"
		elseif storyType == StoryModel.StoryType.Goodfeel then
			properties.action_name = "跳过好感度剧情"
		elseif storyType == StoryModel.StoryType.SCCopy then
			properties.action_name = "跳过运营副本剧情"
		end
	elseif storyType == StoryModel.StoryType.MainTask then
		properties.action_name = "自动播放主线任务剧情"
	elseif storyType == StoryModel.StoryType.PlotCopy then
		properties.action_name = "自动播放剧情副本剧情"
	elseif storyType == StoryModel.StoryType.Goodfeel then
		properties.action_name = "自动播放好感度剧情"
	elseif storyType == StoryModel.StoryType.SCCopy then
		properties.action_name = "自动播放运营副本剧情"
	end

	properties.StoryID = tostring(storyId)
	properties.StoryName = sceneName or ""
	properties.UserId = RoleModel.instance:getUserId()

	BootstrapUtil.sensorsTrack("501208", properties, true)
end

function StoryController:_startStory()
	if not StoryModel.instance:hasStory() then
		return
	end

	if self._isDelayClosingMaskView then
		removetimer(self._delayCloseMaskView, self)

		self._isDelayClosingMaskView = nil
	end

	ViewMgr.instance:open(ViewName.StoryMask)
	StoryModel.instance:startStory()

	if ViewMgr.instance:isOpen(ViewName.Story) then
		local view = ViewMgr.instance._views[ViewName.Story]

		if view.fadingOut then
			ViewMgr.instance:close(ViewName.Story)
		end
	end

	if not ViewMgr.instance:isOpen(ViewName.Story) then
		ViewMgr.instance:open(ViewName.Story)
	end
end

function StoryController:finishCurrStory()
	local story = StoryModel.instance:getCurStory()

	if story then
		story:endCurrStory()

		if not story:hasStory() then
			local storyId = story.storyId

			StoryModel.instance:endCurrStory()

			local isAllEnd = not StoryModel.instance:hasStory()

			if isAllEnd then
				local delayCloseMaskView = story.delayCloseMaskView

				StoryModel.instance:endStory()

				if delayCloseMaskView then
					self._isDelayClosingMaskView = true

					settimer(1, self._delayCloseMaskView, self, false)
				else
					self._isDelayClosingMaskView = nil

					ViewMgr.instance:close(ViewName.StoryMask)
				end
			else
				StoryModel.instance:startStory()
			end

			ViewMgr.instance:close(ViewName.BulletScreen)
			self:_traceStoryEnd(storyId)
			self:addTimeFinishStory(storyId)
			GlobalDispatcher:dispatch(GlobalNotify.EndStory, storyId, isAllEnd)
		end
	end
end

function StoryController:getTimeFinishStory(storyId)
	if checknumber(storyId) <= 0 then
		return 0
	end

	return checknumber(GameUtil.getUserData(self:timeKey(storyId)))
end

function StoryController:addTimeFinishStory(storyId)
	if checknumber(storyId) <= 0 then
		return
	end

	local key = self:timeKey(storyId)
	local time = self:getTimeFinishStory(storyId)

	GameUtil.saveUserData(key, time + 1)
end

function StoryController:timeKey(storyId)
	return "story_time_key_" .. storyId
end

function StoryController:_traceStoryStart(storyId)
	if storyId == self.firstStoryId then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.EVENT_PV_START)
	end

	StorySurvey.instance:onStoryPlayStart(storyId)
end

function StoryController:_traceStoryEnd(storyId)
	if self.firstStoryId then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.EVENT_PV_END)

		self.firstStoryId = nil
	end

	StorySurvey.instance:onStoryPlayFinished(storyId)
end

function StoryController:_delayCloseMaskView()
	self._isDelayClosingMaskView = nil

	removetimer(self._delayCloseMaskView, self)
	ViewMgr.instance:close(ViewName.StoryMask)
end

StoryController.instance = StoryController.New()

return StoryController
