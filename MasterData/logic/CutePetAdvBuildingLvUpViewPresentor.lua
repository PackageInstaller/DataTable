-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/adventure/CutePetAdvBuildingLvUpViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetAdvBuildingLvUpViewPresentor", package.seeall)

local CutePetAdvBuildingLvUpViewPresentor = class("CutePetAdvBuildingLvUpViewPresentor", ViewPresentor)

function CutePetAdvBuildingLvUpViewPresentor:ctor()
	CutePetAdvBuildingLvUpViewPresentor.super.ctor(self)
end

function CutePetAdvBuildingLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetAdvBuildingLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetadvbuildinglvupview.prefab"
	}
end

function CutePetAdvBuildingLvUpViewPresentor:buildViews()
	return {
		CutePetAdvBuildingLvUpView.New()
	}
end

return CutePetAdvBuildingLvUpViewPresentor
