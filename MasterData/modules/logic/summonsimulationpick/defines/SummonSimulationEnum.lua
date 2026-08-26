-- chunkname: @modules/logic/summonsimulationpick/defines/SummonSimulationEnum.lua

module("modules.logic.summonsimulationpick.defines.SummonSimulationEnum", package.seeall)

local SummonSimulationEnum = _M

SummonSimulationEnum.SaveType = {
	Saved = 1,
	Current = 2
}
SummonSimulationEnum.PickType = {
	SaveResult = 1,
	SelectResult = 2
}

return SummonSimulationEnum
