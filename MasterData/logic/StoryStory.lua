-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/model/StoryStory.lua

module("logic.extensions.story.model.StoryStory", package.seeall)

local StoryStory = class("StoryStory")

function StoryStory:ctor(id)
	self.storyId = id
	self._currStory = nil

	self:_addStories()
end

function StoryStory:_addStories()
	self._stories = {}

	local storyConfig = StoryConfig.instance:getStories(self.storyId)

	if not storyConfig then
		error("剧情id：" .. self.storyId .. "不存在，请检查任务配置")
	end

	local cnt = #storyConfig
	local preType, preStories

	StoryConst.handleStoriesBackground(storyConfig)

	for i = 1, cnt do
		local story = storyConfig[i]

		if story.type == StoryConst.Story_Animation or story.type == StoryConst.Story_Battle or story.type == StoryConst.Story_Movie then
			if preType then
				self:_addStory(preType, preStories)
			end

			self:_addStory(story.type, story)

			preType = nil
			preStories = nil
		elseif not preType or preType == story.type then
			preType = story.type
			preStories = preStories or {}

			table.insert(preStories, story)
		else
			self:_addStory(preType, preStories)

			preType = story.type
			preStories = {}

			table.insert(preStories, story)
		end
	end

	if preType then
		self:_addStory(preType, preStories)
	end
end

function StoryStory:_addOption(optionStory)
	local options = {
		options = optionStory,
		type = StoryConst.Story_Option
	}
	local bgImg, bgEff
	local sound = 0
	local bgMusic = 0

	for i = 1, #optionStory do
		local op = optionStory[i]

		if not bgImg or #bgImg == 0 then
			bgImg = op.bgImg
		end

		if not bgEff or #bgEff == 0 then
			bgEff = op.bgEff
		end

		if not sound or sound == 0 then
			sound = op.sound
		end

		if not bgMusic or bgMusic == 0 then
			bgMusic = op.bgMusic
		end
	end

	options.bgImg = bgImg
	options.bgEff = bgEff
	options.sound = sound
	options.bgMusic = bgMusic

	self:_pushStories({
		options
	})
end

function StoryStory:_addSpeakAsides(speakAsidesStory)
	local stories

	for i = 1, #speakAsidesStory do
		stories = stories or {}

		table.insert(stories, speakAsidesStory[i])

		if speakAsidesStory[i].next_appear == 0 then
			self:_doAddSpeakAsides(stories)

			stories = nil
		end
	end

	if stories then
		self:_doAddSpeakAsides(stories)
	end
end

function StoryStory:_doAddSpeakAsides(speakAsidesStory)
	local stories = {
		speakAsides = speakAsidesStory,
		type = StoryConst.Story_SpeakAside
	}
	local bgImg, bgEff, fbcontinue, sa_duration, op, opParams
	local sound = 0
	local bgMusic = 0

	for i = 1, #speakAsidesStory do
		local sa = speakAsidesStory[i]

		if not bgImg or #bgImg == 0 then
			bgImg = sa.bgImg
		end

		if not bgEff or #bgEff == 0 then
			bgEff = sa.bgEff
		end

		fbcontinue = fbcontinue or sa.sa_fbcontinue

		if not op and sa.op ~= 0 then
			op = sa.op
			opParams = sa.opParams
		end

		if not sound or sound == 0 then
			sound = sa.sound
		end

		if not bgMusic or bgMusic == 0 then
			bgMusic = sa.bgMusic
		end

		if not sa_duration or sa_duration == 0 then
			sa_duration = sa.sa_duration
		end
	end

	stories.bgImg = bgImg
	stories.bgEff = bgEff
	stories.op = op
	stories.opParams = opParams
	stories.sa_duration = sa_duration
	stories.bgMusic = bgMusic
	stories.sound = sound
	stories.clickContinue = not fbcontinue

	self:_pushStories({
		stories
	})
end

function StoryStory:_pushStories(stories)
	local cnt = #stories

	for i = 1, cnt do
		table.insert(self._stories, stories[i])

		stories[i].storyIndex = #self._stories
	end

	self.delayCloseMaskView = true
end

function StoryStory:_addBattle(story)
	if story.battle and #story.battle > 0 then
		table.insert(self._stories, story)

		self.delayCloseMaskView = nil
	end
end

function StoryStory:_addMovie(story)
	if story.animName and #story.animName > 0 then
		table.insert(self._stories, story)

		self.delayCloseMaskView = nil
	end
end

function StoryStory:_addAnimation(animStory)
	if animStory.animName and #animStory.animName > 0 then
		table.insert(self._stories, animStory)

		self.delayCloseMaskView = nil
	end
end

function StoryStory:_addDramaModel(storyModels)
	local len = #self._stories
	local id = self._stories[len].story_id

	self._models = self._models or {}
	self._models[id] = storyModels
end

function StoryStory:_addStory(storyType, storyConfig)
	if storyType == StoryConst.Story_Drama or storyType == StoryConst.Story_Brief or storyType == StoryConst.Story_Image or storyType == StoryConst.Story_ChapterStart or storyType == StoryConst.Story_ChapterEnd or storyType == StoryConst.Story_ImageSpeakAside then
		self:_pushStories(storyConfig)
	elseif storyType == StoryConst.Story_SpeakAside then
		self:_addSpeakAsides(storyConfig)
	elseif storyType == StoryConst.Story_Option then
		self:_addOption(storyConfig)
	elseif storyType == StoryConst.Story_Drama_Model then
		self:_addDramaModel(storyConfig)
	elseif storyType == StoryConst.Story_Animation then
		self:_addAnimation(storyConfig)
	elseif storyType == StoryConst.Story_Battle then
		self:_addBattle(storyConfig)
	elseif storyType == StoryConst.Story_Movie then
		self:_addMovie(storyConfig)
	end
end

function StoryStory:getModels(storyId)
	if not self._models then
		return
	end

	return self._models[storyId]
end

function StoryStory:hasStory()
	if not self._stories then
		return
	end

	local cnt = #self._stories

	if cnt == 0 then
		return
	end

	if cnt == 1 and self._stories[1].type == StoryConst.Story_Brief then
		return
	end

	return true
end

function StoryStory:endStory()
	self._stories = nil
	self._currStory = nil
	self.storyId = nil
end

function StoryStory:endCurrStory()
	if self._currStory then
		self._currStory = nil
	end
end

function StoryStory:getNextStory()
	if self:hasStory() then
		local story = self._stories[1]

		table.remove(self._stories, 1)

		while story and story.type == StoryConst.Story_Brief do
			story = self._stories[1]

			table.remove(self._stories, 1)
		end

		self:setCurrStory(story)

		return story
	end
end

function StoryStory:setCurrStory(currStory)
	self._currStory = currStory

	if self._currStory then
		self._currStory.extModels = self:getModels(self._currStory.story_id) or ""
	end
end

function StoryStory:getCurrStory()
	return self._currStory
end

function StoryStory:getNextStoryOnly()
	if self:hasStory() then
		return self._stories[1]
	end
end

function StoryStory:popBrief()
	local popStories

	if self._stories then
		repeat
			story = self._stories[1]
			popStories = popStories or {}

			table.insert(popStories, story)
			table.remove(self._stories, 1)
		until not story or story.type == StoryConst.Story_Brief or story.op ~= 0
	end

	return popStories
end

function StoryStory:popDramas()
	local popStories, hitOp

	if self._stories then
		repeat
			story = self._stories[1]

			if not story or story.type ~= StoryConst.Story_Drama then
				break
			end

			popStories = popStories or {}

			table.insert(popStories, story)
			table.remove(self._stories, 1)
		until story.op ~= 0
	end

	return popStories
end

function StoryStory:popStories()
	local popStories, hitOp

	if self._stories then
		repeat
			story = self._stories[1]

			if not story or story.type == StoryConst.Story_Option or story.type == StoryConst.Story_Battle then
				break
			end

			popStories = popStories or {}

			table.insert(popStories, story)
			table.remove(self._stories, 1)
		until story.op ~= 0
	end

	return popStories
end

function StoryStory:getBrief()
	if self._stories then
		local cnt = #self._stories

		for i = 1, cnt do
			local story = self._stories[i]

			if story.type ~= StoryConst.Story_Drama then
				if story.type == StoryConst.Story_Brief then
					return story
				end

				return
			elseif story.op ~= 0 then
				return story
			end
		end

		return nil
	end
end

return StoryStory
