-- chunkname: @modules/logic/guide/model/GuideEnum.lua

module("modules.logic.guide.model.GuideEnum", package.seeall)

local GuideEnum = _M

GuideEnum.uiTypeCircle = 1
GuideEnum.uiTypeRectangle = 2
GuideEnum.uiTypeNoHole = 3
GuideEnum.uiTypeDragCard = 4
GuideEnum.uiTypeArrow = 5
GuideEnum.uiTypePressArrow = 6
GuideEnum.uiTypeDragCard2 = 7
GuideEnum.uiTypeDrag = 8
GuideEnum.uiTypeMaxCount = 8
GuideEnum.ArrowRotation = {
	160,
	0,
	-110,
	70
}
GuideEnum.ArrowDragSize = {
	600,
	52
}
GuideEnum.GuideIconWithCn = {
	true,
	true,
	nil,
	nil,
	nil,
	true,
	true,
	true
}
GuideEnum.SpecialEventEnum = {
	SummonDraw = 6,
	SummonFog = 2,
	SummonWheel = 3,
	FightCardOp = 7,
	SummonTouch = 4,
	SummonOpen = 1,
	SummonTurn = 5
}
GuideEnum.RoomStrengthenGuideId = 168
GuideEnum.VerticalDrawingSwitchingGuide = 135
GuideEnum.GuideRoom = {
	TaskGuideID = 401
}
GuideEnum.GuideId = {
	NecrologistStoryLinkText = 31308,
	RoomDailyOrder = 418,
	NecrologistStoryMagic = 31303,
	RoomCritterTrain = 415,
	AssistAbyss = 40012,
	PlayerViewAssist = 40011,
	Act157FactoryUnlock = 18103,
	WeekWalkDeep = 506,
	V3A5NecrologistStoryGame = 35011
}
GuideEnum.EventTrigger = {
	AssistAbyss = 5,
	MusicFreeView = 1,
	FightItemPlayerSkillGroup = 3,
	Act178FoodNotEnough = 2,
	PlayerViewAssist = 4
}

return GuideEnum
