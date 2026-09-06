-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdPetBuffFormationExViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdPetBuffFormationExViewPresentor", package.seeall)

local YouthArenaThirdPetBuffFormationExViewPresentor = class("YouthArenaThirdPetBuffFormationExViewPresentor", ViewPresentor)

function YouthArenaThirdPetBuffFormationExViewPresentor:ctor()
	YouthArenaThirdPetBuffFormationExViewPresentor.super.ctor(self)
end

function YouthArenaThirdPetBuffFormationExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdPetBuffFormationExViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdpetbuffformationexview.prefab"
	}
end

function YouthArenaThirdPetBuffFormationExViewPresentor:buildViews()
	return {
		YouthArenaThirdPetBuffFormationExView.New()
	}
end

function YouthArenaThirdPetBuffFormationExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YouthArenaThirdPetBuffFormationExViewPresentor
