-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/CopyFormationLeftView.lua

module("logic.extensions.plotcopy.view.CopyFormationLeftView", package.seeall)

local CopyFormationLeftView = class("CopyFormationLeftView", FormationLeftView)

function CopyFormationLeftView:onEnter()
	CopyFormationLeftView.super.onEnter(self)
end

function CopyFormationLeftView:_getCurFormation()
	return PlotCopyModel.instance:_getCurFormation()
end

function CopyFormationLeftView:_getPet(id)
	local mo = CopyFormationLeftView.super._getPet(self, id)

	mo = PetHireModel.instance:tryGetHirePetMo(id, mo)

	return mo
end

function CopyFormationLeftView:_beforeUseFormationMo()
	local formationMo = PlotCopyModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyFormationMoToHireFmo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

function CopyFormationLeftView:onFmoSetDown()
	local formationMo = PlotCopyModel.instance:getOriginalCurFormation()

	PetHireModel.instance:copyHireFmoToFormationMo(PetHireModel.ID_TYPE_NORMAL, formationMo)
end

return CopyFormationLeftView
