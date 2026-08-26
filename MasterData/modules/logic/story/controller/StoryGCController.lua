-- chunkname: @modules/logic/story/controller/StoryGCController.lua

module("modules.logic.story.controller.StoryGCController", package.seeall)

local StoryGCController = class("StoryGCController", BaseController)
local GCUnuseCount = 3
local AudioGcStepInterval = 10
local Type_bg = 1
local Type_spine = 2
local Type_live2d = 3
local Type_effect = 5

function StoryGCController:onInit()
	return
end

function StoryGCController:reInit()
	return
end

function StoryGCController:addConstEvents()
	StoryController.instance:registerCallback(StoryEvent.Start, self._onStart, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._onFinish, self)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, self._onStep, self)
	StoryController.instance:registerCallback(StoryEvent.OnBgmStop, self._onTriggerBgmStop, self)
	StoryController.instance:registerCallback(StoryEvent.VideoStart, self._onVideoStart, self)
end

function StoryGCController:_onStart(storyId)
	self._storyId = storyId
	self._markUseDict = {}
	self._markUseList = {}
	self._usingList = {}
	self._currBg = nil
	self._videoStepCountDown = nil
	self._stepCount = 0

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		-- block empty
	end
end

function StoryGCController:_onFinish(storyId)
	self._storyId = nil
	self._markUseDict = {}
	self._markUseList = {}
	self._usingList = {}
	self._currBg = nil

	GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, self)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayAudioGC, self)
end

function StoryGCController:_onStep(o)
	local stepId = o.stepId

	self._stepId = stepId
	self._usingList = {}

	if stepId then
		::label_6_0::

		local stepCO = StoryStepModel.instance:getStepListById(stepId)
		local bgCO = stepCO and stepCO.bg

		if bgCO and bgCO.transType ~= StoryEnum.BgTransType.Keep then
			if not self._markUseDict[bgCO.bgImg] then
				self._markUseDict[bgCO.bgImg] = true

				local o = {
					type = Type_bg,
					path = bgCO.bgImg
				}

				table.insert(self._markUseList, o)
				table.insert(self._usingList, o)

				self._currBg = bgCO.bgImg
			elseif self._currBg then
				table.insert(self._usingList, {
					type = Type_bg,
					path = self._currBg
				})
			end
		elseif self._currBg then
			table.insert(self._usingList, {
				type = Type_bg,
				path = self._currBg
			})
		end

		local heroList = stepCO and stepCO.heroList

		for _, hero in ipairs(heroList) do
			local heroCO = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(hero.heroIndex)
			local isSpine = heroCO.type == 0

			if isSpine then
				if not heroCO.prefab then
					local prefab = heroCO.live2dPrefab

					if not self._markUseDict[prefab] then
						self._markUseDict[prefab] = true

						local var_6_1 = {}

						if isSpine then
							var_6_1.type = Type_spine or Type_live2d
						end

						var_6_1.path = prefab

						local o = var_6_1

						table.insert(self._markUseList, o)
						table.insert(self._usingList, o)
					end
				end
			end
		end

		local effList = stepCO and stepCO.effList

		for _, one in ipairs(effList) do
			if not self._markUseDict[one.effect] then
				self._markUseDict[one.effect] = true

				local o = {
					type = Type_effect,
					path = one.effect
				}

				table.insert(self._markUseList, o)
				table.insert(self._usingList, o)
			end
		end

		local GCStepCount = 3
		local hasVideo = StoryModel.instance:isPlayingVideo()
		local forceGC = false

		if hasVideo then
			self._videoStepCountDown = GCStepCount
		elseif self._videoStepCountDown then
			self._videoStepCountDown = self._videoStepCountDown - 1

			if self._videoStepCountDown <= 0 then
				self._videoStepCountDown = nil
				forceGC = true
			end
		end

		self:_checkGC(forceGC)
	end
end

function StoryGCController:_onVideoStart(videoName, loop)
	self:_checkGC(true)
end

function StoryGCController:_checkGC(forceGC)
	local total = #self._markUseList
	local current = #self._usingList

	if total - current >= GCUnuseCount or forceGC then
		self._markUseList = {}

		for _, one in ipairs(self._usingList) do
			if one.path then
				self._markUseDict[one.path] = true

				table.insert(self._markUseList, one)
			end
		end

		GameGCMgr.instance:dispatchEvent(GameGCEvent.StoryGC, self)
	end

	self._stepCount = self._stepCount + 1

	if self._stepCount % AudioGcStepInterval == 0 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, self)
	end
end

function StoryGCController:_onTriggerBgmStop()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayAudioGC, 0.5, self)
end

StoryGCController.instance = StoryGCController.New()

return StoryGCController
