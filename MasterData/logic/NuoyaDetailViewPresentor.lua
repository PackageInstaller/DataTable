-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/nuoya/NuoyaDetailViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.nuoya.NuoyaDetailViewPresentor", package.seeall)

local NuoyaDetailViewPresentor = class("NuoyaDetailViewPresentor", ViewPresentor)

function NuoyaDetailViewPresentor:ctor()
	NuoyaDetailViewPresentor.super.ctor(self)
end

function NuoyaDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoyaDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/nuoya/nuoyadetailview.prefab"
	}
end

function NuoyaDetailViewPresentor:buildViews()
	return {
		NuoyaDetailView.New()
	}
end

return NuoyaDetailViewPresentor
