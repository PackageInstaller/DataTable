-- chunkname: @modules/logic/versionactivity3_5/puzzle/controller/V3a5PuzzleController.lua

module("modules.logic.versionactivity3_5.puzzle.controller.V3a5PuzzleController", package.seeall)

local V3a5PuzzleController = class("V3a5PuzzleController", BaseController)

function V3a5PuzzleController:onInit()
	return
end

function V3a5PuzzleController:onInitFinish()
	return
end

function V3a5PuzzleController:addConstEvents()
	return
end

function V3a5PuzzleController:reInit()
	return
end

function V3a5PuzzleController:_initStoryViewInfo()
	self._storyViewInfos = {}

	for const, viewName in pairs(V3a5PuzzleEnum.StoryView) do
		local storyId = V3a5PuzzleConfig.instance:getConstValue(const)

		self._storyViewInfos[storyId] = viewName
	end
end

function V3a5PuzzleController:isOpenPuzzleView(storyId, isOpen, episodeId, afterStory)
	if storyId == V3a9BirdModel.instance:getBeforeStoryId() then
		if isOpen then
			self:openPuzzleView(storyId, episodeId, afterStory)
		end

		return true
	end

	if not self._storyViewInfos then
		self:_initStoryViewInfo()
	end

	for _storyId, _ in pairs(self._storyViewInfos) do
		if _storyId == storyId then
			if isOpen then
				self:openPuzzleView(storyId, episodeId, afterStory)
			end

			return true
		end
	end
end

function V3a5PuzzleController:openPuzzleView(storyId, episodeId, afterStory)
	if storyId == V3a9BirdModel.instance:getBeforeStoryId() then
		local actId = V3a9BirdModel.instance:getActId()

		V3a9BirdRpc.instance:sendGetAct243InfoRequest(actId, function()
			local level = V3a9BirdModel.instance:getStoryEpisodeId()

			V3a9BirdController.instance:enterGame(level)
		end)

		return
	end

	local viewName = self._storyViewInfos[storyId]

	if string.nilorempty(viewName) then
		return
	end

	ViewMgr.instance:openView(viewName, {
		storyId = storyId,
		episodeId = episodeId,
		afterStory = afterStory
	})
end

function V3a5PuzzleController:playNextStory(storyId, viewName, cb, cbObj)
	if not StoryModel.instance:isStoryFinished(storyId) then
		StoryController.instance:setStoryFinished(storyId)
		StoryRpc.instance:sendUpdateStoryRequest(storyId, -1, 0)
	end

	local nextStory = V3a5PuzzleEnum.NextStoryView[viewName]

	if not nextStory then
		return
	end

	local nextStoryId = V3a5PuzzleConfig.instance:getConstValue(nextStory)

	local function _cb()
		DungeonRpc.instance:sendEndDungeonRequest(false)

		if cb then
			cb(cbObj)
		end
	end

	StoryController.instance:playStory(nextStoryId, nil, _cb)
end

function V3a5PuzzleController:playNextStoryByPreStoryId(preStoryId, episodeId, afterStory, viewName, cb, cbObj)
	if not StoryModel.instance:isStoryFinished(preStoryId) then
		StoryController.instance:setStoryFinished(preStoryId)
		StoryRpc.instance:sendUpdateStoryRequest(preStoryId, -1, 0)
	end

	local nextStory = V3a5PuzzleEnum.NextStoryView[viewName]

	if not nextStory then
		return
	end

	for k, v in pairs(nextStory) do
		if V3a5PuzzleConfig.instance:getConstValue(k) == preStoryId then
			local nextStoryId = V3a5PuzzleConfig.instance:getConstValue(v)

			local function _cb()
				if cb then
					cb(cbObj)

					if afterStory and afterStory > 0 and afterStory ~= nextStoryId then
						StoryController.instance:playStory(afterStory)
					end
				end

				if episodeId then
					local episodeMo = DungeonModel.instance:getEpisodeInfo(episodeId)

					if episodeMo and episodeMo.star <= DungeonEnum.StarType.None then
						DungeonFightController.instance:enterFight(episodeMo.chapterId, episodeId, 1)
					end
				end
			end

			StoryController.instance:playStory(nextStoryId, nil, _cb)

			return
		end
	end
end

V3a5PuzzleController.instance = V3a5PuzzleController.New()

return V3a5PuzzleController
