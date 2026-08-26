-- chunkname: @modules/logic/story/model/StoryHeroLibraryModel.lua

module("modules.logic.story.model.StoryHeroLibraryModel", package.seeall)

local StoryHeroLibraryModel = class("StoryHeroLibraryModel", BaseModel)

function StoryHeroLibraryModel:onInit()
	self._herolibrary = {}
end

function StoryHeroLibraryModel:setStoryHeroLibraryList(infos)
	self._herolibrary = {}

	for k, info in ipairs(infos) do
		local heroMo = StoryHeroLibraryMo.New()

		heroMo:init(info, k)
		table.insert(self._herolibrary, heroMo)
	end

	self:setList(self._herolibrary)
end

function StoryHeroLibraryModel:getStoryHeroLibraryList()
	return self._herolibrary
end

function StoryHeroLibraryModel:getStoryLibraryHeroByIndex(index)
	for _, v in pairs(self._herolibrary) do
		if v.index == index then
			return v
		end
	end

	return nil
end

StoryHeroLibraryModel.instance = StoryHeroLibraryModel.New()

return StoryHeroLibraryModel
