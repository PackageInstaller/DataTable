-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MCRightView.lua

module("logic.extensions.materialchallenge.view.MCRightView", package.seeall)

local MCRightView = class("MCRightView", FormationRightView)

function MCRightView:getAllShowPetList()
	return MaterialChallengeModel.instance:getAllShowPetList()
end

function MCRightView:_getCurFormation()
	return MaterialChallengeModel.instance:_getCurFormation()
end

return MCRightView
