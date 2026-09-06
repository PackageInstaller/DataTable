-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBossViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiBossViewPresentor", package.seeall)

local ShenJiBossViewPresentor = class("ShenJiBossViewPresentor", ViewPresentor)

function ShenJiBossViewPresentor:ctor()
	ShenJiBossViewPresentor.super.ctor(self)
end

function ShenJiBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiBossViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjibossview.prefab"
	}
end

function ShenJiBossViewPresentor:buildViews()
	return {
		ShenJiBossView.New()
	}
end

return ShenJiBossViewPresentor
