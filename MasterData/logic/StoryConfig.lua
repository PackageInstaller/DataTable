-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/config/StoryConfig.lua

module("logic.extensions.story.config.StoryConfig", package.seeall)

local StoryConfig = class("StoryConfig", BaseConfig)

function StoryConfig:onInit()
	self.storyNpcbtns = nil
end

function StoryConfig:getNames()
	local names = {
		"story",
		"story_haogan",
		"story_huigu",
		"story_config",
		"unlock_story",
		"story_text",
		"story_npcbtn"
	}

	self._story_yunying_map = GameUtil.getTotalConfigs("story_yunying")

	table.insertto(names, table.keys(self._story_yunying_map))

	return names
end

function StoryConfig:handleConfig(name, content)
	if name == "story" then
		self._story = self._story or {}

		self:_setStotyContent(self._story, content)
	elseif name == "story_haogan" then
		self._story = self._story or {}

		self:_setStotyContent(self._story, content)
	elseif self._story_yunying_map[name] then
		self._story_yunying_map[name] = content

		self:_setStotyContent(self._story, content)
	elseif name == "story_huigu" then
		self._story = self._story or {}

		self:_setStotyContent(self._story, content)
	elseif name == "story_config" then
		self._configs = content
	elseif name == "story_text" then
		self._storyText = content
	elseif name == "unlock_story" then
		self._storyUnlock = {}

		self:_setStotyContent(self._storyUnlock, content)
	elseif name == "story_npcbtn" then
		self.storyNpcbtns = content
	end
end

function StoryConfig:_setStotyContent(stories, content)
	local function sort_func(x, y)
		return x.story_id < y.story_id
	end

	for k, v in pairs(content) do
		if type(k) == "number" then
			local story = stories[k]

			if not story then
				story = {}
				stories[k] = story
			end

			for k1, v1 in pairs(v) do
				table.insert(story, v1)
			end

			table.sort(story, sort_func)
		end
	end
end

function StoryConfig:getStortText(id)
	if self._storyText and self._storyText[id] then
		return self._storyText[id].content
	end
end

function StoryConfig:getStories(id)
	if self._story then
		return self._story[id]
	end
end

function StoryConfig:getStoryUnLock(id)
	if self._storyUnlock then
		return self._storyUnlock[id]
	end
end

function StoryConfig:getStoryConfig(id, dir)
	if self._configs and self._configs[id] then
		return self._configs[id][dir]
	end
end

function StoryConfig:GetStoryNpcbtns(btnsId)
	if btnsId == nil or btnsId < 1 then
		return
	end

	if self.storyNpcbtns then
		return self.storyNpcbtns[btnsId]
	end
end

StoryConfig.instance = StoryConfig.New()

return StoryConfig
