-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starteam/view/StarteamPresentor.lua

module("logic.extensions.starteam.view.StarteamPresentor", package.seeall)

local StarteamPresentor = class("StarteamPresentor", ViewPresentor)

function StarteamPresentor:ctor()
	StarteamPresentor.super.ctor(self)
end

function StarteamPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarteamPresentor:dependWhatResources()
	return {
		"ui/views/starteam/starteamview.prefab"
	}
end

function StarteamPresentor:buildViews()
	return {
		StarteamView.New()
	}
end

return StarteamPresentor
