-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandScenceViewPresentor.lua

module("logic.extensions.powerland.view.PowerLandScenceViewPresentor", package.seeall)

local PowerLandScenceViewPresentor = class("PowerLandScenceViewPresentor", ViewPresentor)

function PowerLandScenceViewPresentor:ctor()
	PowerLandScenceViewPresentor.super.ctor(self)
end

function PowerLandScenceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerLandScenceViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/powerlandscenceview.prefab"
	}
end

function PowerLandScenceViewPresentor:buildViews()
	return {
		PowerLandScenceView.New()
	}
end

return PowerLandScenceViewPresentor
