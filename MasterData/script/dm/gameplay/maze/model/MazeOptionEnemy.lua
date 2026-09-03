-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionEnemy.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionEnemy = class("MazeOptionEnemy", MazeBaseOption)

MazeOptionEnemy:has("_rewardId", {
	is = "rw"
})
MazeOptionEnemy:has("_pointId", {
	is = "rw"
})

function MazeOptionEnemy:initialize()
	super.initialize(self)

	self._type = ""
	self._optionId = ""
	self._rewardId = ""
end

function MazeOptionEnemy:syncData(data)
	if data.optionId then
		self._optionId = data.optionId
	end

	if data.rewardId then
		self._rewardId = data.rewardId
	end

	if data.pointId then
		self._pointId = data.pointId
	end
end

function MazeOptionEnemy:onClickOptionBtn(index)
	print("第" .. index .. "个页签" .. "MazeOptionEnemy..小怪")
end

function MazeOptionEnemy:haveQuestion()
	return false
end

function MazeOptionEnemy:getQuestionDesc()
	return ""
end

function MazeOptionEnemy:getClueSet()
	local clues = {}
	local cluesS = {}

	return clues, cluesS
end

function MazeOptionEnemy:getClueSetId()
	return self._clueSet
end

return MazeOptionEnemy
