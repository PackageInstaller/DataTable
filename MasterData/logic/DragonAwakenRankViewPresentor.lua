-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenRankViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenRankViewPresentor", package.seeall)

local DragonAwakenRankViewPresentor = class("DragonAwakenRankViewPresentor", ViewPresentor)

function DragonAwakenRankViewPresentor:ctor()
	DragonAwakenRankViewPresentor.super.ctor(self)
end

function DragonAwakenRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenRankViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenrankview.prefab"
	}
end

function DragonAwakenRankViewPresentor:buildViews()
	return {
		DragonAwakenRankView.New()
	}
end

return DragonAwakenRankViewPresentor
