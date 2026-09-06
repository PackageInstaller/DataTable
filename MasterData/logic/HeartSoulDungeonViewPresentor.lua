-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/heartsoul/HeartSoulDungeonViewPresentor.lua

module("logic.extensions.scenariocopy.view.heartsoul.HeartSoulDungeonViewPresentor", package.seeall)

local HeartSoulDungeonViewPresentor = class("HeartSoulDungeonViewPresentor", ViewPresentor)

function HeartSoulDungeonViewPresentor:ctor()
	HeartSoulDungeonViewPresentor.super.ctor(self)
end

function HeartSoulDungeonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartSoulDungeonViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/xinxinniannian/xxnncopyview.prefab"
	}
end

function HeartSoulDungeonViewPresentor:buildViews()
	return {
		HeartSoulDungeonView.New()
	}
end

return HeartSoulDungeonViewPresentor
