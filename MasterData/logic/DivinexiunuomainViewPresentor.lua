-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/view/DivinexiunuomainViewPresentor.lua

module("logic.extensions.divinexiunuo.view.DivinexiunuomainViewPresentor", package.seeall)

local DivinexiunuomainViewPresentor = class("DivinexiunuomainViewPresentor", ViewPresentor)

function DivinexiunuomainViewPresentor:ctor()
	DivinexiunuomainViewPresentor.super.ctor(self)
end

function DivinexiunuomainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexiunuomainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinexiunuo/divinexiunuomainview.prefab"
	}
end

function DivinexiunuomainViewPresentor:buildViews()
	return {
		DivinexiunuomainView.New()
	}
end

return DivinexiunuomainViewPresentor
