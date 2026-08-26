-- chunkname: @modules/logic/story/model/StoryStepMo.lua

module("modules.logic.story.model.StoryStepMo", package.seeall)

local StoryStepMo = pureTable("StoryStepMo")

function StoryStepMo:ctor()
	self.id = 0
	self.name = ""
	self.conversation = {}
	self.heroList = {}
	self.bg = {}
	self.audioList = {}
	self.effList = {}
	self.picList = {}
	self.videoList = {}
	self.navigateList = {}
	self.optList = {}
	self.mainRole = {}
	self.mourningBorder = {}
end

function StoryStepMo:init(info)
	self.id = info[1]
	self.name = info[2]
	self.conversation = self:_buildConversation(info[3])
	self.heroList = self:_buildHero(info[4])
	self.bg = self:_buildBackground(info[5])
	self.audioList = self:_buildAudio(info[6])
	self.effList = self:_buildEffect(info[7])
	self.picList = self:_buildPictures(info[8])
	self.videoList = self:_buildVideo(info[9])
	self.navigateList = self:_buildNavigate(info[10])
	self.optList = self:_buildOption(info[11])
	self.mainRole = self:_buildMainRole(info[12])
	self.mourningBorder = self:_buildMourningBorder(info[13])
end

function StoryStepMo:_buildConversation(param)
	local conMo = StoryStepConversationMo.New()

	conMo:init(param)

	return conMo
end

function StoryStepMo:_buildHero(param)
	local list = {}

	for _, hero in ipairs(param) do
		local heroMo = StoryStepHeroMo.New()

		heroMo:init(hero)
		table.insert(list, heroMo)
	end

	return list
end

function StoryStepMo:_buildBackground(param)
	local bgMo = StoryStepBGMo.New()

	bgMo:init(param)

	return bgMo
end

function StoryStepMo:_buildAudio(param)
	local list = {}

	for _, v in ipairs(param) do
		local audioMo = StoryStepAudioMo.New()

		audioMo:init(v)
		table.insert(list, audioMo)
	end

	return list
end

function StoryStepMo:_buildEffect(param)
	local list = {}

	for _, v in ipairs(param) do
		local effMo = StoryStepEffectMo.New()

		effMo:init(v)
		table.insert(list, effMo)
	end

	return list
end

function StoryStepMo:_buildPictures(param)
	local list = {}

	for _, v in ipairs(param) do
		local picMo = StoryStepPictureMo.New()

		picMo:init(v)
		table.insert(list, picMo)
	end

	return list
end

function StoryStepMo:_buildVideo(param)
	local list = {}

	for _, v in ipairs(param) do
		local videoMo = StoryStepVideoMo.New()

		videoMo:init(v)
		table.insert(list, videoMo)
	end

	return list
end

function StoryStepMo:_buildNavigate(param)
	local list = {}

	for _, v in ipairs(param) do
		local mapMo = StoryStepNavigateMo.New()

		mapMo:init(v)
		table.insert(list, mapMo)
	end

	return list
end

function StoryStepMo:_buildOption(param)
	local list = {}

	for _, v in ipairs(param) do
		local optMo = StoryStepOptionMo.New()

		optMo:init(v)
		table.insert(list, optMo)
	end

	return list
end

function StoryStepMo:_buildMainRole(param)
	local mrMo = StoryStepMainHeroMo.New()

	mrMo:init(param)

	return mrMo
end

function StoryStepMo:_buildMourningBorder(param)
	local mb = StoryStepMourningBorderMo.New()

	mb:init(param)

	return mb
end

return StoryStepMo
