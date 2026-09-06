-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/view/FamilyPartyMainViewPresentor.lua

module("logic.extensions.familyparty.view.FamilyPartyMainViewPresentor", package.seeall)

local FamilyPartyMainViewPresentor = class("FamilyPartyMainViewPresentor", ViewPresentor)

function FamilyPartyMainViewPresentor:ctor()
	FamilyPartyMainViewPresentor.super.ctor(self)
end

function FamilyPartyMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilyPartyMainViewPresentor:dependWhatResources()
	return {
		"ui/views/familyscene/party/familypartymainview.prefab"
	}
end

function FamilyPartyMainViewPresentor:buildViews()
	return {
		FamilyPartyMainView.New(),
		FamilyPartyTipView.New()
	}
end

function FamilyPartyMainViewPresentor:setGrayMaskGO(grayMaskGO)
	FamilyPartyMainViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return FamilyPartyMainViewPresentor
