-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/EBRightView.lua

module("logic.extensions.mission.view.EBRightView", package.seeall)

local EBRightView = class("EBRightView", FormationRightView)

function EBRightView:getAllShowPetList()
	return EndlessBattleModel.instance:getAllShowPetList()
end

function EBRightView:_getCurFormation()
	return EndlessBattleModel.instance:_getCurFormation()
end

return EBRightView
