-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetskinrenameViewPresentor.lua

module("logic.extensions.bag.view.PetskinrenameViewPresentor", package.seeall)

local PetskinrenameViewPresentor = class("PetskinrenameViewPresentor", ViewPresentor)

function PetskinrenameViewPresentor:ctor()
	PetskinrenameViewPresentor.super.ctor(self)
end

function PetskinrenameViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetskinrenameViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskinrenameview.prefab"
	}
end

function PetskinrenameViewPresentor:buildViews()
	return {
		PetskinrenameView.New()
	}
end

return PetskinrenameViewPresentor
