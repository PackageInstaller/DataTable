-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/copy/DivinesqyllevelViewPresentor.lua

module("logic.extensions.xiayin.view.copy.DivinesqyllevelViewPresentor", package.seeall)

local DivinesqyllevelViewPresentor = class("DivinesqyllevelViewPresentor", ViewPresentor)

function DivinesqyllevelViewPresentor:ctor()
	DivinesqyllevelViewPresentor.super.ctor(self)
end

function DivinesqyllevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesqyllevelViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/copy/divinesqyllevelview.prefab"
	}
end

function DivinesqyllevelViewPresentor:buildViews()
	return {
		DivinesqyllevelView.New()
	}
end

return DivinesqyllevelViewPresentor
