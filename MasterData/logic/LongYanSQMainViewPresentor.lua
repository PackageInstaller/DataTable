-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LongYanSQMainViewPresentor.lua

module("logic.extensions.godlongyan.view.LongYanSQMainViewPresentor", package.seeall)

local LongYanSQMainViewPresentor = class("LongYanSQMainViewPresentor", ViewPresentor)

function LongYanSQMainViewPresentor:ctor()
	LongYanSQMainViewPresentor.super.ctor(self)
end

function LongYanSQMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongYanSQMainViewPresentor:dependWhatResources()
	return {
		"ui/views/godlongyan/longyansqmainview.prefab"
	}
end

function LongYanSQMainViewPresentor:buildViews()
	return {
		LongYanSQMainView.New()
	}
end

return LongYanSQMainViewPresentor
