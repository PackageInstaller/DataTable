-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/formation/FunArenaFormationRightView.lua

module("logic.extensions.funarena.view.formation.FunArenaFormationRightView", package.seeall)

local FunArenaFormationRightView = class("FunArenaFormationRightView", FormationRightView)

function FunArenaFormationRightView:getAllShowPetList()
	return FunArenaModel.instance:getAllShowPetList()
end

function FunArenaFormationRightView:_getCurFormation()
	return FunArenaModel.instance:getCurFormMo()
end

return FunArenaFormationRightView
