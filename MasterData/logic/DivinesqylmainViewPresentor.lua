-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/copy/DivinesqylmainViewPresentor.lua

module("logic.extensions.xiayin.view.copy.DivinesqylmainViewPresentor", package.seeall)

local DivinesqylmainViewPresentor = class("DivinesqylmainViewPresentor", ViewPresentor)

function DivinesqylmainViewPresentor:ctor()
	DivinesqylmainViewPresentor.super.ctor(self)
end

function DivinesqylmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinesqylmainViewPresentor:dependWhatResources()
	return {
		"ui/views/xiayin/copy/divinesqylmainview.prefab"
	}
end

function DivinesqylmainViewPresentor:buildViews()
	return {
		DivinesqylmainView.New()
	}
end

return DivinesqylmainViewPresentor
