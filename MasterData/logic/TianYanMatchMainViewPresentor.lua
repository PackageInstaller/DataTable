-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchMainViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchMainViewPresentor", package.seeall)

local TianYanMatchMainViewPresentor = class("TianYanMatchMainViewPresentor", ViewPresentor)

function TianYanMatchMainViewPresentor:ctor()
	TianYanMatchMainViewPresentor.super.ctor(self)
end

function TianYanMatchMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianYanMatchMainViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchmainview.prefab"
	}
end

function TianYanMatchMainViewPresentor:buildViews()
	return {
		TianYanMatchMainView.New()
	}
end

return TianYanMatchMainViewPresentor
