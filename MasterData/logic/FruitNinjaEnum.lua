-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/data/FruitNinjaEnum.lua

module("logic.extensions.fruitninja.data.FruitNinjaEnum", package.seeall)

local FruitNinjaEnum = {}

FruitNinjaEnum.GameMode_Nor = 1
FruitNinjaEnum.GameMode_Ext = 2
FruitNinjaEnum.State_Preparing = "State_Preparing"
FruitNinjaEnum.State_Runing = "State_Runing"
FruitNinjaEnum.State_Stoping = "State_Stoping"
FruitNinjaEnum.State_Ended = "State_Ended"
FruitNinjaEnum.CellState_Standing = "CellState_Standing"
FruitNinjaEnum.CellState_Running = "CellState_Running"
FruitNinjaEnum.CellState_Ending = "CellState_Ending"
FruitNinjaEnum.CellState_Ended = "CellState_Ended"
FruitNinjaEnum.FruitScores = {
	[1] = 1
}
FruitNinjaEnum.ClipAnimTimes = 4
FruitNinjaEnum.SlicedAngles = {
	-40,
	40,
	140,
	220
}
FruitNinjaEnum.MaxSliceDuration = 0.5
FruitNinjaEnum.ForceMode2D = {}
FruitNinjaEnum.ForceMode2D.Force = SystemReflexHelp.getForceMode2D("Force")
FruitNinjaEnum.ForceMode2D.Impulse = SystemReflexHelp.getForceMode2D("Impulse")

return FruitNinjaEnum
