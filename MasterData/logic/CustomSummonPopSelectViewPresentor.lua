-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/customsummon/CustomSummonPopSelectViewPresentor.lua

module("logic.extensions.customfmt.view.customsummon.CustomSummonPopSelectViewPresentor", package.seeall)

local CustomSummonPopSelectViewPresentor = class("CustomSummonPopSelectViewPresentor", ViewWithGuidePresentor)

function CustomSummonPopSelectViewPresentor:ctor()
	CustomSummonPopSelectViewPresentor.super.ctor(self)
end

function CustomSummonPopSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CustomSummonPopSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractselectpopview.prefab"
	}
end

function CustomSummonPopSelectViewPresentor:buildViews()
	return {
		CustomSummonPopSelectView.New()
	}
end

return CustomSummonPopSelectViewPresentor
