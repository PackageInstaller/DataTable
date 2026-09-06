-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandMainViewPresentor.lua

module("logic.extensions.powerland.view.PowerLandMainViewPresentor", package.seeall)

local PowerLandMainViewPresentor = class("PowerLandMainViewPresentor", ViewPresentor)

function PowerLandMainViewPresentor:ctor()
	PowerLandMainViewPresentor.super.ctor(self)
end

function PowerLandMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerLandMainViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/powerlandmainview.prefab"
	}
end

function PowerLandMainViewPresentor:buildViews()
	return {
		PowerLandMainView.New()
	}
end

return PowerLandMainViewPresentor
