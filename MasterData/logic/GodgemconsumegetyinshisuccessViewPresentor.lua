-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumegetyinshisuccessViewPresentor.lua

module("logic.extensions.godgemconsume.view.GodgemconsumegetyinshisuccessViewPresentor", package.seeall)

local GodgemconsumegetyinshisuccessViewPresentor = class("GodgemconsumegetyinshisuccessViewPresentor", ViewPresentor)

function GodgemconsumegetyinshisuccessViewPresentor:ctor()
	GodgemconsumegetyinshisuccessViewPresentor.super.ctor(self)
end

function GodgemconsumegetyinshisuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodgemconsumegetyinshisuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/godgemconsume/godgemconsumegetyinshisuccessview.prefab"
	}
end

function GodgemconsumegetyinshisuccessViewPresentor:buildViews()
	return {
		GodgemconsumegetyinshisuccessView.New()
	}
end

return GodgemconsumegetyinshisuccessViewPresentor
