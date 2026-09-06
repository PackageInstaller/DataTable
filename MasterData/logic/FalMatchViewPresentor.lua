-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalMatchViewPresentor.lua

module("logic.extensions.landlords.view.FalMatchViewPresentor", package.seeall)

local FalMatchViewPresentor = class("FalMatchViewPresentor", ViewPresentor)

function FalMatchViewPresentor:ctor()
	FalMatchViewPresentor.super.ctor(self)
end

function FalMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falmatchview.prefab"
	}
end

function FalMatchViewPresentor:buildViews()
	return {
		FalMatchView.New()
	}
end

return FalMatchViewPresentor
