-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PetskinsellViewPresentor.lua

module("logic.extensions.firstcharge.view.PetskinsellViewPresentor", package.seeall)

local PetskinsellViewPresentor = class("PetskinsellViewPresentor", ViewPresentor)

function PetskinsellViewPresentor:ctor()
	PetskinsellViewPresentor.super.ctor(self)
end

function PetskinsellViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinsellViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskinsellview.prefab"
	}
end

function PetskinsellViewPresentor:buildViews()
	return {
		PetskinsellView.New()
	}
end

return PetskinsellViewPresentor
