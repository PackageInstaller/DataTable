-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/model/UniqueWorldEnum.lua

module("logic.extensions.uniqueworld.model.UniqueWorldEnum", package.seeall)

local UniqueWorldEnum = {}

UniqueWorldEnum.MapGoType = {
	Cell = 2,
	Bg = 1,
	Boss = 4,
	Npc = 3
}
UniqueWorldEnum.GridType = {
	TreasureBox = 1,
	Shop = 4,
	Challenge = 5,
	BossChallenge = 6,
	DigMine = 2,
	NPCDialogue = 3,
	Barrier = 7,
	Empty = 0
}
UniqueWorldEnum.EffectType = {
	DecItem = "decItem",
	AddItem = "addItem",
	Buff = "buff",
	AddPet = "addPet",
	Coin = "coin",
	AddHp = "addHp",
	AddEvent = "addEvent",
	Recover = "recover"
}
UniqueWorldEnum.ExtParam = {
	GameEnd = "GAME_END",
	FightWin = "FIGHT_WIN",
	NextLevel = "NEXT_LEVEL",
	FightLose = "FIGHT_LOSE"
}

return UniqueWorldEnum
