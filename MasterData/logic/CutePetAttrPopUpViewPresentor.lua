-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetAttrPopUpViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetAttrPopUpViewPresentor", package.seeall)

local CutePetAttrPopUpViewPresentor = class("CutePetAttrPopUpViewPresentor", ViewPresentor)

function CutePetAttrPopUpViewPresentor:ctor()
	CutePetAttrPopUpViewPresentor.super.ctor(self)
end

function CutePetAttrPopUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutePetAttrPopUpViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetattrpopupview.prefab"
	}
end

function CutePetAttrPopUpViewPresentor:buildViews()
	return {
		CutePetAttrPopUpView.New()
	}
end

return CutePetAttrPopUpViewPresentor
