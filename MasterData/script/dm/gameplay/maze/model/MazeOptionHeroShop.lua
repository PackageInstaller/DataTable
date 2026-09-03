-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionHeroShop.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionHeroShop = class("MazeOptionHeroShop", MazeBaseOption)

MazeOptionHeroShop:has("_type", {
	is = "rw"
})
MazeOptionHeroShop:has("_optionId", {
	is = "rw"
})
MazeOptionHeroShop:has("_heroes", {
	is = "rw"
})
MazeOptionHeroShop:has("_heroAttrId", {
	is = "rw"
})

function MazeOptionHeroShop:initialize()
	super.initialize(self)

	self._viewName = "MazeHeroShopView"
	self._type = ""
	self._heroes = nil
end

function MazeOptionHeroShop:syncData(data)
	dump(data, "英魂商店数据")

	if data.type then
		self._type = data.type
	end

	if data.optionId then
		self._optionId = data.optionId
	end

	if data.heroes then
		self._heroes = data.heroes
	end

	if data.heroAttrId then
		self._heroAttrId = data.heroAttrId
	end
end

function MazeOptionHeroShop:delHero(heroid)
	local temphero = {}

	for k, v in pairs(self._heroes) do
		if heroid ~= k then
			temphero[k] = v
		end
	end

	self._heroes = temphero
end

return MazeOptionHeroShop
