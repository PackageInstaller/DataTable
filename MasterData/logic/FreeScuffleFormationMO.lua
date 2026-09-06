-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/data/FreeScuffleFormationMO.lua

module("logic.extensions.freescuffle.view.data.FreeScuffleFormationMO", package.seeall)

local FreeScuffleFormationMO = class("FreeScuffleFormationMO", FormationMO)

function FreeScuffleFormationMO:_getValidHeroSkills()
	return self._exHeroSkills or {}
end

function FreeScuffleFormationMO:SetExHeroSkills(list)
	self._exHeroSkills = list or {}
end

return FreeScuffleFormationMO
