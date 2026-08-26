-- chunkname: @modules/logic/versionactivity2_1/activity165/controller/Activity165Enum.lua

module("modules.logic.versionactivity2_1.activity165.controller.Activity165Enum", package.seeall)

local Activity165Enum = _M

Activity165Enum.StoryStage = {
	Filling = 0,
	isEndFill = 1,
	Ending = 2
}
Activity165Enum.StepOffsetObj = {
	{
		goleft = {
			PosX = -118.32,
			PosY = 0
		},
		goright = {
			PosX = 267.02,
			PosY = 50
		},
		goindex = {
			PosX = 90.98,
			PosY = 55.6
		},
		gotxt = {
			PosX = 0,
			PosY = 80
		}
	},
	{
		goleft = {
			PosX = 118.32,
			PosY = 0
		},
		goright = {
			PosX = -267.02,
			PosY = 0
		},
		goindex = {
			PosX = -60.9,
			PosY = 55.6
		},
		gotxt = {
			PosX = 5,
			PosY = 95
		}
	}
}
Activity165Enum.EndingAssessment = {
	A = "a",
	S = "s",
	C = "c",
	B = "b"
}
Activity165Enum.StoryItemAnim = {
	Idle = "idle",
	Unlock = "unlock"
}
Activity165Enum.EditViewAnim = {
	Idle = "idle",
	Play = "play",
	Close = "close",
	EgOpen = "story_eg_open",
	story_btn_open = "story_btn_open",
	Unlock = "unlock",
	Open = "open"
}
Activity165Enum.ReviewViewAnim = {
	Switch = "switch"
}
Activity165Enum.EditStepMoveAnim = {
	{
		Back = "1_back",
		Move = "1_move"
	},
	{
		Back = "2_back",
		Move = "2_move"
	},
	{
		Back = "2_back",
		Move = "2_move"
	},
	{
		Back = "3_back",
		Move = "3_move"
	},
	{
		Back = "3_back",
		Move = "3_move"
	},
	{
		Back = "4_back",
		Move = "4_move"
	}
}

return Activity165Enum
