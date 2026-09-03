-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/model/MazeOptionStory.lua

local MazeBaseOption = require("dm.gameplay.maze.model.MazeBaseOption")
local MazeOptionStory = class("MazeOptionStory", MazeBaseOption)

MazeOptionStory:has("_storyId", {
	is = "rw"
})
MazeOptionStory:has("_storyScript", {
	is = "rw"
})
MazeOptionStory:has("_storyRewardId", {
	is = "rw"
})
MazeOptionStory:has("_storyClueList", {
	is = "rw"
})

function MazeOptionStory:initialize()
	super.initialize(self)
end

function MazeOptionStory:syncData(data)
	if data.optionId then
		self._optionId = data.optionId
	end

	if data.storyId then
		self._storyId = data.storyId
	end

	self:readConfig()
end

function MazeOptionStory:readConfig()
	local cfg = ConfigReader:getRecordById("PansLabStoryPoint", self._storyId)

	self._storyScript = cfg.Script
	self._storyRewardId = cfg.StoryReward
	self._storyClueList = cfg.ClueList
end

function MazeOptionStory:onClickOptionBtn(index)
	print("第" .. index .. "个页签", "MazeOptionStory", self._storyId)
end

function MazeOptionStory:getStoryScript()
	return self._storyScript
end

return MazeOptionStory
