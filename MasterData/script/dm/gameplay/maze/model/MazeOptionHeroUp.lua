-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionHeroUp.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionHeroUp = class("MazeOptionHeroUp", MazeBaseOption)

MazeOptionHeroUp:has("_level", {
	is = "rw"
})
MazeOptionHeroUp:has("_count", {
	is = "rw"
})
MazeOptionHeroUp:has("_priceList", {
	is = "rw"
})

function MazeOptionHeroUp:initialize()
	super.initialize(self)

	self._viewName = "MazeHeroUpView"
end

function MazeOptionHeroUp:syncData(data)
	if data.type then
		self._type = data.type
	end

	if data.optionId then
		self._optionId = data.optionId
	end

	if data.rewardId then
		self._rewardId = data.rewardId
	end

	if data.priceList then
		self._priceList = data.priceList
	end

	if data.count then
		self._count = data.count
	end
end

function MazeOptionHeroUp:syncUpCount(data)
	self._count = data.count
end

function MazeOptionHeroUp:getUpCost()
	local len = table.nums(self._priceList)

	if len >= self._count then
		return self._priceList[tostring(self._count)]
	else
		return self._priceList[tostring(len - 1)]
	end
end

function MazeOptionHeroUp:onClickOptionBtn(index)
	print("第" .. index .. "个页签" .. "MazeOptionHeroUp..英魂强化")
end

return MazeOptionHeroUp
