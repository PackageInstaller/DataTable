-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextallpassViewPresentor.lua

module("logic.extensions.farnas.view.FarnasextallpassViewPresentor", package.seeall)

local FarnasextallpassViewPresentor = class("FarnasextallpassViewPresentor", ViewPresentor)

function FarnasextallpassViewPresentor:ctor()
	FarnasextallpassViewPresentor.super.ctor(self)
end

function FarnasextallpassViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FarnasextallpassViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasextallpassview.prefab"
	}
end

function FarnasextallpassViewPresentor:buildViews()
	return {
		FarnasextallpassView.New()
	}
end

return FarnasextallpassViewPresentor
