-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/model/PanTaoFeastEnum.lua

module("logic.extensions.pantaofeast.model.PanTaoFeastEnum", package.seeall)

local PanTaoFeastEnum = {}

PanTaoFeastEnum.StashType = {
	Backpack = 1,
	Tool = 2,
	None = 0
}
PanTaoFeastEnum.CookingState = {
	Finished = 2,
	Locked = 0,
	Waiting = 1
}
PanTaoFeastEnum.ElementType = {
	Backpack = 4,
	EnergyItem = 3,
	Workshop = 2,
	RawMat = 1,
	None = 0
}
PanTaoFeastEnum.ElementClientType = {
	Backpack = 4,
	Dish = 5,
	EnergyItem = 3,
	GreatDish = 6,
	Workshop = 2,
	RawMat = 1,
	None = 0
}

return PanTaoFeastEnum
