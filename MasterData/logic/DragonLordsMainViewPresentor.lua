-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonLordsMainViewPresentor.lua

module("logic.extensions.dragonlords.view.DragonLordsMainViewPresentor", package.seeall)

local DragonLordsMainViewPresentor = class("DragonLordsMainViewPresentor", ViewPresentor)

function DragonLordsMainViewPresentor:ctor()
	DragonLordsMainViewPresentor.super.ctor(self)
end

function DragonLordsMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonLordsMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonlords/dragonlordsmainview.prefab"
	}
end

function DragonLordsMainViewPresentor:buildViews()
	return {
		DragonLordsMainView.New()
	}
end

return DragonLordsMainViewPresentor
