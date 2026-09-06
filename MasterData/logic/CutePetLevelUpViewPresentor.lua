-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetLevelUpViewPresentor.lua

module("logic.extensions.cutepet.view.CutePetLevelUpViewPresentor", package.seeall)

local CutePetLevelUpViewPresentor = class("CutePetLevelUpViewPresentor", ViewPresentor)

function CutePetLevelUpViewPresentor:ctor()
	CutePetLevelUpViewPresentor.super.ctor(self)
end

function CutePetLevelUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutePetLevelUpViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepetlevelupview.prefab"
	}
end

function CutePetLevelUpViewPresentor:buildViews()
	return {
		CutePetLevelUpView.New()
	}
end

function CutePetLevelUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CutePetLevelUpViewPresentor
