-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleFormationMO.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleFormationMO", package.seeall)

local ScuffleFormationMO = class("ScuffleFormationMO", FormationMO)

function ScuffleFormationMO:_getPet(id)
	return ScuffleModel.instance:getPet(id)
end

return ScuffleFormationMO
