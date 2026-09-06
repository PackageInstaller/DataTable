-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/familyhouding/FamilyHoudingClgSettlementSuccessViewPresentor.lua

module("logic.extensions.battlesettlement.view.familyhouding.FamilyHoudingClgSettlementSuccessViewPresentor", package.seeall)

local FamilyHoudingClgSettlementSuccessViewPresentor = class("FamilyHoudingClgSettlementSuccessViewPresentor", ViewPresentor)

function FamilyHoudingClgSettlementSuccessViewPresentor:ctor()
	FamilyHoudingClgSettlementSuccessViewPresentor.super.ctor(self)
end

function FamilyHoudingClgSettlementSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyHoudingClgSettlementSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/battlesettlement/familyhoudingclgsettlementsuccessview.prefab"
	}
end

function FamilyHoudingClgSettlementSuccessViewPresentor:buildViews()
	return {
		FamilyHoudingClgSettlementSuccessView.New()
	}
end

return FamilyHoudingClgSettlementSuccessViewPresentor
