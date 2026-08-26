-- chunkname: @modules/logic/versionactivity2_2/lopera/define/LoperaEnum.lua

module("modules.logic.versionactivity2_2.lopera.define.LoperaEnum", package.seeall)

local LoperaEnum = _M

LoperaEnum.EpisodeType = {
	Explore = 3,
	Story = 1,
	ExploreEndless = 4,
	Battle = 2
}
LoperaEnum.MapCfgIdx = {
	dir = 4,
	start = 6,
	destination = 7,
	storyId = 8,
	event = 5,
	name = 3,
	coord = 2,
	id = 1,
	storyEvent = 9
}
LoperaEnum.DirEnum = {
	South = 2,
	West = 3,
	East = 4,
	North = 1
}
LoperaEnum.ResultEnum = {
	Completed = 1,
	PowerUseup = 2,
	Quit = 3
}
LoperaEnum.EndlessEpisodeId = 1220409
LoperaEnum.OriStepCostId = 11
LoperaEnum.PlayedCellStory = "PlayedCellStory"
LoperaEnum.EpisodeStatus = {
	PlayEndStory = 2,
	Unlock = 0,
	PlayStartStory = 1
}
LoperaEnum.EffectType = {
	ActionPointChange = 1,
	ActionPointCost = 2
}
LoperaEnum.ItemType = {
	Product = 1,
	Material = 2
}
LoperaEnum.resultStatUse = {
	"成功",
	"失败",
	"主动中断",
	"成功"
}
LoperaEnum.TaskMOAllFinishId = -100

return LoperaEnum
