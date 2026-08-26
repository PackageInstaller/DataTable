-- chunkname: @modules/logic/defines/LoadingEnum.lua

module("modules.logic.defines.LoadingEnum", package.seeall)

local LoadingEnum = _M

LoadingEnum.LoadingSceneType = {
	Main = 2,
	Room = 4,
	Other = 1,
	Explore = 5,
	Summon = 3
}

return LoadingEnum
