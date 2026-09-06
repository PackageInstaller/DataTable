-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/model/HolyChallFormationMO.lua

module("logic.extensions.kingway.model.HolyChallFormationMO", package.seeall)

local HolyChallFormationMO = class("HolyChallFormationMO", FormationMO)

function HolyChallFormationMO:_getPet(id)
	return HolyChallModel.instance:getPet(id)
end

return HolyChallFormationMO
