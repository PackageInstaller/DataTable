-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareLeftView.lua

module("logic.extensions.sharetask.view.ShareLeftView", package.seeall)

local ShareLeftView = class("ShareLeftView", FormationLeftView)

function ShareLeftView:_getCurFormation()
	return ShareTaskModel.instance:_getCurFormation()
end

function ShareLeftView:_getPet(id)
	local mo = ShareLeftView.super._getPet(self, id)

	mo = PetHireModel.instance:tryGetHirePetMo(id, mo)

	return mo
end

function ShareLeftView:_beforeUseFormationMo()
	local formationMo = ShareTaskModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

function ShareLeftView:onFmoSetDown()
	local formationMo = ShareTaskModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

return ShareLeftView
