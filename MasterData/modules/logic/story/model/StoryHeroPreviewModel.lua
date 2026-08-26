-- chunkname: @modules/logic/story/model/StoryHeroPreviewModel.lua

module("modules.logic.story.model.StoryHeroPreviewModel", package.seeall)

local StoryHeroPreviewModel = class("StoryHeroPreviewModel", BaseModel)

function StoryHeroPreviewModel:onInit()
	self:reInit()
end

function StoryHeroPreviewModel:reInit()
	self:initData()
end

function StoryHeroPreviewModel:initData()
	self._dir = StoryHeroPreviewEnum.Direction.Left
	self._heroType = StoryHeroPreviewEnum.HeroType.Spine
	self._filterTxt = ""
end

function StoryHeroPreviewModel:setCurDir(dir)
	self._dir = dir
end

function StoryHeroPreviewModel:getCurDir()
	return self._dir
end

function StoryHeroPreviewModel:setCurHeroType(heroType)
	self._heroType = heroType
end

function StoryHeroPreviewModel:getCurHeroType()
	return self._heroType
end

function StoryHeroPreviewModel:setFilterTxt(txt)
	self._filterTxt = txt
end

function StoryHeroPreviewModel:clearFilterTxt()
	self._filterTxt = ""
end

function StoryHeroPreviewModel:getAllHeroListByType(heroType)
	heroType = heroType or self:getCurHeroType()

	local list = {}
	local heroPool = StoryHeroLibraryModel.instance:getStoryHeroLibraryList()

	for _, hero in ipairs(heroPool) do
		if hero.type == heroType then
			if LuaUtil.isEmptyStr(self._filterTxt) then
				table.insert(list, hero)
			elseif heroType == StoryHeroPreviewEnum.HeroType.Spine then
				if string.find(hero.prefab, self._filterTxt) then
					table.insert(list, hero)
				end
			elseif heroType == StoryHeroPreviewEnum.HeroType.Live2D and string.find(hero.live2dPrefab, self._filterTxt) then
				table.insert(list, hero)
			end
		end
	end

	return list
end

function StoryHeroPreviewModel:getAllPathListByType(heroType)
	heroType = heroType or self:getCurHeroType()

	local pathList = {}
	local heroList = self:getAllHeroListByType(heroType)

	if heroType == StoryHeroPreviewEnum.HeroType.Spine then
		for _, hero in ipairs(heroList) do
			local path = string.gsub(hero.prefab, "Assets/ZResourcesLib/", "")

			if not string.find(path, "rolesstory/") then
				path = string.format("rolesstory/%s", path)
			end

			table.insert(pathList, path)
		end
	elseif heroType == StoryHeroPreviewEnum.HeroType.Live2D then
		for _, hero in pairs(heroList) do
			local path = string.gsub(hero.live2dPrefab, "Assets/ZResourcesLib/", "")

			if not string.find(path, "live2d/") then
				path = string.format("live2d/roles/%s", path)
			end

			table.insert(pathList, path)
		end
	end

	return pathList
end

StoryHeroPreviewModel.instance = StoryHeroPreviewModel.New()

return StoryHeroPreviewModel
