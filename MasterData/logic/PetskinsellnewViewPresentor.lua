-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PetskinsellnewViewPresentor.lua

module("logic.extensions.firstcharge.view.PetskinsellnewViewPresentor", package.seeall)

local PetskinsellnewViewPresentor = class("PetskinsellnewViewPresentor", ViewPresentor)

function PetskinsellnewViewPresentor:ctor()
	PetskinsellnewViewPresentor.super.ctor(self)
end

function PetskinsellnewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinsellnewViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskinsellnewview.prefab"
	}
end

function PetskinsellnewViewPresentor:buildViews()
	return {
		PetskinsellnewView.New()
	}
end

return PetskinsellnewViewPresentor
