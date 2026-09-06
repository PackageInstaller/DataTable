-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBossHpViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiBossHpViewPresentor", package.seeall)

local ShenJiBossHpViewPresentor = class("ShenJiBossHpViewPresentor", ViewPresentor)

function ShenJiBossHpViewPresentor:ctor()
	ShenJiBossHpViewPresentor.super.ctor(self)
end

function ShenJiBossHpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiBossHpViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjibosshpview.prefab"
	}
end

function ShenJiBossHpViewPresentor:buildViews()
	return {
		ShenJiBossHpView.New()
	}
end

return ShenJiBossHpViewPresentor
