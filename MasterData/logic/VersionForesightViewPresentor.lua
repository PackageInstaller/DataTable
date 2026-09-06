-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/versionforesight/view/VersionForesightViewPresentor.lua

module("logic.extensions.versionforesight.view.VersionForesightViewPresentor", package.seeall)

local VersionForesightViewPresentor = class("VersionForesightViewPresentor", ViewPresentor)

function VersionForesightViewPresentor:ctor()
	VersionForesightViewPresentor.super.ctor(self)
end

function VersionForesightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function VersionForesightViewPresentor:dependWhatResources()
	return {
		"ui/views/versionforesight/versionforesightview.prefab"
	}
end

function VersionForesightViewPresentor:buildViews()
	return {
		VersionForesightView.New()
	}
end

return VersionForesightViewPresentor
