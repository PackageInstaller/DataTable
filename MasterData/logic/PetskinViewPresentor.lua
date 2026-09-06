-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskinViewPresentor.lua

module("logic.extensions.petskin.view.PetskinViewPresentor", package.seeall)

local PetskinViewPresentor = class("PetskinViewPresentor", ViewPresentor)

function PetskinViewPresentor:ctor()
	PetskinViewPresentor.super.ctor(self)
end

function PetskinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskinview.prefab"
	}
end

function PetskinViewPresentor:buildViews()
	return {
		PetskinView.New()
	}
end

return PetskinViewPresentor
