-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBossPassViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiBossPassViewPresentor", package.seeall)

local ShenJiBossPassViewPresentor = class("ShenJiBossPassViewPresentor", ViewPresentor)

function ShenJiBossPassViewPresentor:ctor()
	ShenJiBossPassViewPresentor.super.ctor(self)
end

function ShenJiBossPassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiBossPassViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjibosspassview.prefab"
	}
end

function ShenJiBossPassViewPresentor:buildViews()
	return {
		ShenJiBossPassView.New()
	}
end

return ShenJiBossPassViewPresentor
