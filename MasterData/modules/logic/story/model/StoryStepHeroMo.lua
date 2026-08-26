-- chunkname: @modules/logic/story/model/StoryStepHeroMo.lua

module("modules.logic.story.model.StoryStepHeroMo", package.seeall)

local StoryStepHeroMo = pureTable("StoryStepHeroMo")

function StoryStepHeroMo:ctor()
	self.heroIndex = 0
	self.heroDir = 1
	self.heroPos = {
		0,
		0
	}
	self.heroScale = 1
	self.isFollow = false
	self.mouses = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.anims = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.expressions = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	self.effs = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
end

function StoryStepHeroMo:init(info)
	self.heroIndex = info[1]

	local hero = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(info[1])

	self.heroDir = info[2]

	if hero then
		local value = ""

		if info[2] == 0 then
			value = hero.type == 0 and hero.leftParam or hero.live2dLeftParam
		elseif info[2] == 1 then
			value = hero.type == 0 and hero.midParam or hero.live2dMidParam
		elseif info[2] == 2 then
			value = hero.type == 0 and hero.rightParam or hero.live2dRightParam
		end

		local value = string.split(value, "#")

		self.heroPos = {
			tonumber(value[1]),
			tonumber(value[2])
		}
		self.heroScale = tonumber(value[3])
	end

	self.isFollow = info[3]
	self.mouses = info[4]
	self.anims = info[5]
	self.expressions = info[6]
	self.effs = info[7]
end

return StoryStepHeroMo
