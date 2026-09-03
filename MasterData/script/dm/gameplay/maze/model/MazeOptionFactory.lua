-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionFactory.lua

local MazeOptionFactory = {}
local _modelClass = {
	Boss = require("dm.gameplay.maze.model.MazeOptionBoss"),
	Enemy = require("dm.gameplay.maze.model.MazeOptionEnemy"),
	HeroShop = require("dm.gameplay.maze.model.MazeOptionHeroShop"),
	ItemShop = require("dm.gameplay.maze.model.MazeOptionItemShop"),
	HeroUp = require("dm.gameplay.maze.model.MazeOptionHeroUp"),
	MasterCure = require("dm.gameplay.maze.model.MazeOptionMasterCure"),
	HeroBox_1To1 = require("dm.gameplay.maze.model.MazeOptionHeroBox"),
	HeroBox_2To1 = require("dm.gameplay.maze.model.MazeOptionHeroBox"),
	HeroBox_3To1 = require("dm.gameplay.maze.model.MazeOptionHeroBox"),
	HeroBox_2Time = require("dm.gameplay.maze.model.MazeOptionHeroBox"),
	ItemBox_1To1 = require("dm.gameplay.maze.model.MazeOptionTreasureBox"),
	ItemBox_2To1 = require("dm.gameplay.maze.model.MazeOptionTreasureBox"),
	ItemBox_3To1 = require("dm.gameplay.maze.model.MazeOptionTreasureBox"),
	ItemBox_2Time = require("dm.gameplay.maze.model.MazeOptionTreasureBox"),
	RefreshOption = require("dm.gameplay.maze.model.MazeOptionRefresh"),
	ExchangItem = require("dm.gameplay.maze.model.MazeOptionExchangItem"),
	CopyItem = require("dm.gameplay.maze.model.MazeOptionCopyItem"),
	Story = require("dm.gameplay.maze.model.MazeOptionStory")
}

function MazeOptionFactory.createNewOption(_type, _v)
	local obj
	local cls = _modelClass[_type]

	if cls then
		obj = cls:new()

		obj:initType(_type)
		obj:syncData(_v)
	end

	return obj
end

return MazeOptionFactory
