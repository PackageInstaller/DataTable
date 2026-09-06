-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PetskinsourcejumpViewPresentor.lua

module("logic.extensions.bonus.view.PetskinsourcejumpViewPresentor", package.seeall)

local PetskinsourcejumpViewPresentor = class("PetskinsourcejumpViewPresentor", ViewPresentor)

function PetskinsourcejumpViewPresentor:ctor()
	PetskinsourcejumpViewPresentor.super.ctor(self)
end

function PetskinsourcejumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinsourcejumpViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/petskinsourcejumpview.prefab"
	}
end

function PetskinsourcejumpViewPresentor:buildViews()
	return {
		PetskinsourcejumpView.New()
	}
end

return PetskinsourcejumpViewPresentor
