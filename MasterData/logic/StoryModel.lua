-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/model/StoryModel.lua

module("logic.extensions.story.model.StoryModel", package.seeall)

local StoryModel = class("StoryModel", BaseListModel)

StoryModel.StoryType = {
	Goodfeel = 3,
	PlotCopy = 2,
	HuiGu = 5,
	MainTask = 1,
	SCCopy = 4
}

function StoryModel:onReset()
	StoryModel.super.onReset(self)

	self._stories = nil
	self._currPlayingStory = nil
	self.isPlayingAnimStory = nil
	self._currBattleStory = nil
end

function StoryModel:getBattleStory()
	return self._currBattleStory
end

function StoryModel:setBattleStory(story)
	self._currBattleStory = story
end

function StoryModel:setStoryById(id, storyType)
	local story = StoryStory.New(id)

	storyType = storyType or StoryModel.StoryType.MainTask
	self._stories = self._stories or {}

	if self._currPlayingStory then
		self._currPlayingStory:endCurrStory()

		if self._currPlayingStory:hasStory() then
			table.insert(self._stories, self._currPlayingStory)
		end

		self._currPlayingStory = nil
	end

	story.storyType = storyType

	table.insert(self._stories, story)
end

function StoryModel:pushStoryById(id, storyType)
	local story = StoryStory.New(id)

	storyType = storyType or StoryModel.StoryType.MainTask
	story.storyType = storyType
	self._stories = self._stories or {}

	table.insert(self._stories, 1, story)
end

function StoryModel:getStories()
	return self._stories
end

function StoryModel:getCurStory()
	return self._currPlayingStory
end

function StoryModel:startStory()
	if self._currPlayingStory then
		return
	end

	if self:hasStory() then
		self._currPlayingStory = self._stories[#self._stories]

		table.remove(self._stories)
	end
end

function StoryModel:hasStory()
	local story = self:getCurStory()

	if story and story:hasStory() then
		return true
	end

	if not self._stories or #self._stories == 0 then
		return
	end

	return self._stories[#self._stories]:hasStory()
end

function StoryModel:endCurrStory()
	if self._currPlayingStory then
		self._currPlayingStory:endStory()

		self._currPlayingStory = nil
	end
end

function StoryModel:endStory()
	self:endCurrStory()

	self._stories = nil
end

StoryModel.instance = StoryModel.New()

return StoryModel
