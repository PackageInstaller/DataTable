-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyBossRightView.lua

module("logic.extensions.family.view.FamilyBossRightView", package.seeall)

local FamilyBossRightView = class("FamilyBossRightView", FormationRightView)

function FamilyBossRightView:getAllShowPetList()
	return FamilyModel.instance:getAllShowPetList()
end

function FamilyBossRightView:_getCurFormation()
	return FamilyModel.instance:_getCurFormation()
end

return FamilyBossRightView
