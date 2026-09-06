-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextsuccessViewPresentor.lua

module("logic.extensions.farnas.view.FarnasextsuccessViewPresentor", package.seeall)

local FarnasextsuccessViewPresentor = class("FarnasextsuccessViewPresentor", ViewPresentor)

function FarnasextsuccessViewPresentor:ctor()
	FarnasextsuccessViewPresentor.super.ctor(self)
end

function FarnasextsuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FarnasextsuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasextsuccessview.prefab"
	}
end

function FarnasextsuccessViewPresentor:buildViews()
	return {
		FarnasextsuccessView.New()
	}
end

return FarnasextsuccessViewPresentor
