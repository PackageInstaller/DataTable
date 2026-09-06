-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenPetLvUpViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenPetLvUpViewPresentor", package.seeall)

local DragonAwakenPetLvUpViewPresentor = class("DragonAwakenPetLvUpViewPresentor", ViewPresentor)

function DragonAwakenPetLvUpViewPresentor:ctor()
	DragonAwakenPetLvUpViewPresentor.super.ctor(self)
end

function DragonAwakenPetLvUpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenPetLvUpViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenpetlvupview.prefab"
	}
end

function DragonAwakenPetLvUpViewPresentor:buildViews()
	return {
		DragonAwakenPetLvUpView.New()
	}
end

function DragonAwakenPetLvUpViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DragonAwakenPetLvUpViewPresentor
