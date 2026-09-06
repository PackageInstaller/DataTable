-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/model/LegendFormationMO.lua

module("logic.extensions.legend.model.LegendFormationMO", package.seeall)

local LegendFormationMO = class("LegendFormationMO", FormationMO)

function LegendFormationMO:_getPet(id)
	return LegendModel.instance:getPet(id)
end

return LegendFormationMO
