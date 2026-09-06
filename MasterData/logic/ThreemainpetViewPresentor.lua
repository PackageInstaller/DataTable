-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/ThreemainpetViewPresentor.lua

module("logic.extensions.guidepopup.view.ThreemainpetViewPresentor", package.seeall)

local ThreemainpetViewPresentor = class("ThreemainpetViewPresentor", ViewPresentor)

function ThreemainpetViewPresentor:ctor()
	ThreemainpetViewPresentor.super.ctor(self)
end

function ThreemainpetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThreemainpetViewPresentor:dependWhatResources()
	return {
		"ui/views/guidepopup/threemainpet.prefab"
	}
end

function ThreemainpetViewPresentor:buildViews()
	return {
		ThreemainpetView.New()
	}
end

return ThreemainpetViewPresentor
