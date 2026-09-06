-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/customsummon/CustomSummonPopViewPresentor.lua

module("logic.extensions.customfmt.view.customsummon.CustomSummonPopViewPresentor", package.seeall)

local CustomSummonPopViewPresentor = class("CustomSummonPopViewPresentor", ViewPresentor)

function CustomSummonPopViewPresentor:ctor()
	CustomSummonPopViewPresentor.super.ctor(self)
end

function CustomSummonPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CustomSummonPopViewPresentor:dependWhatResources()
	return {
		"ui/views/contract/contractselectpopview.prefab"
	}
end

function CustomSummonPopViewPresentor:buildViews()
	return {
		CustomSummonPopView.New()
	}
end

return CustomSummonPopViewPresentor
