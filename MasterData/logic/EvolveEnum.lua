-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/evolve/config/EvolveEnum.lua

module("logic.extensions.evolve.config.EvolveEnum", package.seeall)

local EvolveEnum = {}

EvolveEnum.EvolveType = {
	SourceTrace = 2,
	Divine = 1
}
EvolveEnum.EvolutionTier = {
	Initial = 0,
	DivineEvolve = 1,
	SourceTrace = 3,
	Divine = 2
}

return EvolveEnum
