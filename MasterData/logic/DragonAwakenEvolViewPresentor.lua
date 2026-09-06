-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonawaken/view/DragonAwakenEvolViewPresentor.lua

module("logic.extensions.dragonawaken.view.DragonAwakenEvolViewPresentor", package.seeall)

local DragonAwakenEvolViewPresentor = class("DragonAwakenEvolViewPresentor", ViewPresentor)

function DragonAwakenEvolViewPresentor:ctor()
	DragonAwakenEvolViewPresentor.super.ctor(self)
end

function DragonAwakenEvolViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonAwakenEvolViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonawaken/dragonawakenevolview.prefab"
	}
end

function DragonAwakenEvolViewPresentor:buildViews()
	return {
		DragonAwakenEvolView.New()
	}
end

return DragonAwakenEvolViewPresentor
