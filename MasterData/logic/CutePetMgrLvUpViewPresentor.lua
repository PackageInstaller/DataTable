-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetMgrLvUpViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetMgrLvUpViewPresentor", package.seeall)

local CutePetMgrLvUpViewPresentor = class("CutePetMgrLvUpViewPresentor", ViewPresentor)

function CutePetMgrLvUpViewPresentor:ctor()
	CutePetMgrLvUpViewPresentor.super.ctor(self)
end

function CutePetMgrLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CutePetMgrLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetmgrlvupview.prefab"
	}
end

function CutePetMgrLvUpViewPresentor:buildViews()
	return {
		CutePetMgrLvUpView.New()
	}
end

return CutePetMgrLvUpViewPresentor
