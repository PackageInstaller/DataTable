-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoWork_PlayStory.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoWork_PlayStory", package.seeall)

local GaoSiNiaoWork_PlayStory = class("GaoSiNiaoWork_PlayStory", GaoSiNiaoWorkBase)

function GaoSiNiaoWork_PlayStory.s_create(storyId)
	local work = GaoSiNiaoWork_PlayStory.New()

	work._storyId = storyId

	return work
end

function GaoSiNiaoWork_PlayStory:onStart()
	self:clearWork()

	if not self._storyId then
		logWarn("_storyId is null")
		self:onSucc()

		return
	end

	if self._storyId ~= 0 then
		self:startBlock(nil, 1)
		self:_playStory()
	else
		self:onSucc()
	end
end

function GaoSiNiaoWork_PlayStory:_playStory()
	local storyParams = {}

	storyParams.blur = true
	storyParams.hideStartAndEndDark = true
	storyParams.mark = true

	StoryController.instance:playStory(self._storyId, storyParams, self._onStoryEnterFinishCallback, self)
end

function GaoSiNiaoWork_PlayStory:_onStoryEnterFinishCallback()
	self:onSucc()
end

return GaoSiNiaoWork_PlayStory
