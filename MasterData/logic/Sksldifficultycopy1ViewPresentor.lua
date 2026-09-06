-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/copy/view/Sksldifficultycopy1ViewPresentor.lua

module("logic.extensions.copy.view.Sksldifficultycopy1ViewPresentor", package.seeall)

local Sksldifficultycopy1ViewPresentor = class("Sksldifficultycopy1ViewPresentor", ViewPresentor)

Sksldifficultycopy1ViewPresentor.chapterChallengeBg = {
	"board_sywdly_03",
	"board_sywdly_04",
	"board_sywdly_05"
}

function Sksldifficultycopy1ViewPresentor:ctor()
	Sksldifficultycopy1ViewPresentor.super.ctor(self)
end

function Sksldifficultycopy1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Sksldifficultycopy1ViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shikongshenglong/copy/sksldifficultycopy1view.prefab"
	}
end

function Sksldifficultycopy1ViewPresentor:buildViews()
	return {
		Sksldifficultycopy1View.New()
	}
end

return Sksldifficultycopy1ViewPresentor
