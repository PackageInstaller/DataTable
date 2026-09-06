-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormMainViewPresentor.lua

module("logic.extensions.swordstorm.view.SwordStormMainViewPresentor", package.seeall)

local SwordStormMainViewPresentor = class("SwordStormMainViewPresentor", ViewPresentor)

function SwordStormMainViewPresentor:ctor()
	SwordStormMainViewPresentor.super.ctor(self)
end

function SwordStormMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SwordStormMainViewPresentor:dependWhatResources()
	return {
		"ui/views/swordstorm/swordstormmainview.prefab"
	}
end

function SwordStormMainViewPresentor:buildViews()
	return {
		SwordStormMainView.New()
	}
end

return SwordStormMainViewPresentor
