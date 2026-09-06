-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventMainViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventMainViewPresentor", package.seeall)

local JieShenEventMainViewPresentor = class("JieShenEventMainViewPresentor", ViewPresentor)

function JieShenEventMainViewPresentor:ctor()
	JieShenEventMainViewPresentor.super.ctor(self)
end

function JieShenEventMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventMainViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventmainview.prefab"
	}
end

function JieShenEventMainViewPresentor:buildViews()
	return {
		JieShenEventMainView.New()
	}
end

return JieShenEventMainViewPresentor
