-- chunkname: @modules/logic/versionactivity3_9/bird/define/V3a9BirdEnum.lua

module("modules.logic.versionactivity3_9.bird.define.V3a9BirdEnum", package.seeall)

local V3a9BirdEnum = _M

V3a9BirdEnum.BirdConst = {
	gravity = 1,
	spawnDistance = 5,
	scrollSpeed = 4,
	flapVelocity = 2,
	difficult = 7,
	pipeGap = 6,
	maxFallSpeed = 3
}
V3a9BirdEnum.Act243Const = {
	ScoreMul = 2,
	StoryGameNeedPassNum = 6,
	GameBeforeStory = 3,
	StoryGameID = 5,
	GameAfterStory = 4
}
V3a9BirdEnum.BirdGameType = {
	Infinite = 2,
	Normal = 1
}
V3a9BirdEnum.BirdGameTypeEpisodeId = {
	[V3a9BirdEnum.BirdGameType.Infinite] = {
		1392101
	},
	[V3a9BirdEnum.BirdGameType.Normal] = {
		1392102
	}
}
V3a9BirdEnum.LoadingType = {
	C = 3,
	A = 1,
	B = 2
}

return V3a9BirdEnum
