-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/HeroStory.lua

require("dm.gameplay.stage.model.HeroStoryMap")

HeroStory = class("HeroStory")

HeroStory:has("_owner", {
	is = "rw"
})
HeroStory:has("_type", {
	is = "rw"
})

function HeroStory:initialize()
	self._heroStoryMaps = {}
	self._owner = nil
	self._type = nil
end

function HeroStory:syncHeroStory(data)
	for k, v in pairs(data) do
		if self._heroStoryMaps[k] then
			self._heroStoryMaps[k]:sync(v)
		else
			local map = HeroStoryMap:new(k)

			map:sync(v)

			self._heroStoryMaps[k] = map
		end
	end
end

function HeroStory:getMapById(mapId)
	return self._heroStoryMaps[mapId]
end
