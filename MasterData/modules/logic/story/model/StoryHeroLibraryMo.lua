-- chunkname: @modules/logic/story/model/StoryHeroLibraryMo.lua

module("modules.logic.story.model.StoryHeroLibraryMo", package.seeall)

local StoryHeroLibraryMo = pureTable("StoryHeroLibraryMo")

function StoryHeroLibraryMo:ctor()
	self.index = 0
	self.type = 0
	self.tag = false
	self.name = ""
	self.nameEn = ""
	self.icon = ""
	self.leftParam = ""
	self.midParam = ""
	self.rightParam = ""
	self.live2dLeftParam = ""
	self.live2dMidParam = ""
	self.live2dRightParam = ""
	self.prefab = ""
	self.live2dPrefab = ""
	self.hideNodes = ""
end

function StoryHeroLibraryMo:init(info)
	self.index = info[1]
	self.type = info[2]
	self.tag = info[3]
	self.name = info[4]
	self.nameEn = info[5]
	self.icon = info[6]
	self.leftParam = info[7]
	self.midParam = info[8]
	self.rightParam = info[9]
	self.live2dLeftParam = info[10]
	self.live2dMidParam = info[11]
	self.live2dRightParam = info[12]
	self.prefab = info[13]
	self.live2dPrefab = info[14]
	self.hideNodes = info[15]
end

return StoryHeroLibraryMo
