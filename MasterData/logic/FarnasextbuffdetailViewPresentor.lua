-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextbuffdetailViewPresentor.lua

module("logic.extensions.farnas.view.FarnasextbuffdetailViewPresentor", package.seeall)

local FarnasextbuffdetailViewPresentor = class("FarnasextbuffdetailViewPresentor", ViewPresentor)

function FarnasextbuffdetailViewPresentor:ctor()
	FarnasextbuffdetailViewPresentor.super.ctor(self)
end

function FarnasextbuffdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FarnasextbuffdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasextbuffdetailview.prefab"
	}
end

function FarnasextbuffdetailViewPresentor:buildViews()
	return {
		FarnasextbuffdetailView.New()
	}
end

return FarnasextbuffdetailViewPresentor
