-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisilevelsViewPresentor.lua

module("logic.extensions.lailisi.view.LailisilevelsViewPresentor", package.seeall)

local LailisilevelsViewPresentor = class("LailisilevelsViewPresentor", ViewPresentor)

function LailisilevelsViewPresentor:ctor()
	LailisilevelsViewPresentor.super.ctor(self)
end

function LailisilevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LailisilevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lailisi/lailisilevelsview.prefab"
	}
end

function LailisilevelsViewPresentor:buildViews()
	return {
		LailisilevelsView.New()
	}
end

return LailisilevelsViewPresentor
