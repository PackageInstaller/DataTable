-- chunkname: @modules/logic/versionactivity3_5/puzzle/define/V3a5PuzzleEnum.lua

module("modules.logic.versionactivity3_5.puzzle.define.V3a5PuzzleEnum", package.seeall)

local V3a5PuzzleEnum = _M

V3a5PuzzleEnum.ConstId = {
	NextStoryId = 4,
	V3a6_NextStoryId = 203,
	V3a6_PreStoryId = 202,
	V3a8_PreStoryId_2 = 383003,
	V3a8_PlaySlotItemAudioDelayTime = 384002,
	V3a8_NextStoryId_1 = 383002,
	V3a8_PlaySlotAudioTime = 384001,
	V3a8_AudioIds = 384003,
	V3a8_PreStoryId_1 = 383001,
	CorrectIconIndex = 2,
	ClickErrorTimes = 1,
	V3a8_NextStoryId_2 = 383004,
	V3a6_InputChar = 201,
	PreStoryId = 3
}
V3a5PuzzleEnum.IconCount = 20
V3a5PuzzleEnum.StoryView = {
	[V3a5PuzzleEnum.ConstId.PreStoryId] = ViewName.V3a5PuzzleView,
	[V3a5PuzzleEnum.ConstId.V3a6_PreStoryId] = ViewName.V3a6PuzzleView,
	[V3a5PuzzleEnum.ConstId.V3a8_PreStoryId_1] = ViewName.V3a8PuzzleView,
	[V3a5PuzzleEnum.ConstId.V3a8_PreStoryId_2] = ViewName.V3a8PuzzleView
}
V3a5PuzzleEnum.NextStoryView = {
	[ViewName.V3a5PuzzleView] = V3a5PuzzleEnum.ConstId.NextStoryId,
	[ViewName.V3a6PuzzleView] = V3a5PuzzleEnum.ConstId.V3a6_NextStoryId,
	[ViewName.V3a8PuzzleView] = {
		[V3a5PuzzleEnum.ConstId.V3a8_PreStoryId_1] = V3a5PuzzleEnum.ConstId.V3a8_NextStoryId_1,
		[V3a5PuzzleEnum.ConstId.V3a8_PreStoryId_2] = V3a5PuzzleEnum.ConstId.V3a8_NextStoryId_2
	}
}

return V3a5PuzzleEnum
