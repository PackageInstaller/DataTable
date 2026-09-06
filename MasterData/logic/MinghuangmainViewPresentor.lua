-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minghuangchallenge/view/MinghuangmainViewPresentor.lua

module("logic.extensions.minghuangchallenge.view.MinghuangmainViewPresentor", package.seeall)

local MinghuangmainViewPresentor = class("MinghuangmainViewPresentor", ViewPresentor)

function MinghuangmainViewPresentor:ctor()
	MinghuangmainViewPresentor.super.ctor(self)
end

function MinghuangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MinghuangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/minghuangchallenge/minghuangmainview.prefab"
	}
end

function MinghuangmainViewPresentor:buildViews()
	return {
		MinghuangmainView.New()
	}
end

return MinghuangmainViewPresentor
