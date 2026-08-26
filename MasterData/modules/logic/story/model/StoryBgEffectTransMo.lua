-- chunkname: @modules/logic/story/model/StoryBgEffectTransMo.lua

module("modules.logic.story.model.StoryBgEffectTransMo", package.seeall)

local StoryBgEffectTransMo = pureTable("StoryBgEffectTransMo")

function StoryBgEffectTransMo:ctor()
	self.type = 0
	self.name = ""
	self.mat = ""
	self.prefab = ""
	self.aniName = ""
	self.transTime = 0
	self.extraParam = ""
end

function StoryBgEffectTransMo:init(info)
	self.type = info[1]
	self.name = info[2]
	self.mat = info[3]
	self.prefab = string.split(info[4], ".")[1]
	self.aniName = info[5]
	self.transTime = info[6]
	self.extraParam = info[7]
end

return StoryBgEffectTransMo
