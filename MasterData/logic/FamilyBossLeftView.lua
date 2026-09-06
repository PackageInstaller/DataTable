-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyBossLeftView.lua

module("logic.extensions.family.view.FamilyBossLeftView", package.seeall)

local FamilyBossLeftView = class("FamilyBossLeftView", FormationLeftView)

function FamilyBossLeftView:_getCurFormation()
	return FamilyModel.instance:_getCurFormation()
end

function FamilyBossLeftView:_getPet(id)
	local mo = FamilyBossLeftView.super._getPet(self, id)

	mo = PetHireModel.instance:tryGetHirePetMo(id, mo)

	return mo
end

function FamilyBossLeftView:_beforeUseFormationMo()
	local formationMo = FamilyModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

function FamilyBossLeftView:onFmoSetDown()
	local formationMo = FamilyModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

return FamilyBossLeftView
