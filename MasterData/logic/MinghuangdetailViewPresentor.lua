-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minghuangchallenge/view/MinghuangdetailViewPresentor.lua

module("logic.extensions.minghuangchallenge.view.MinghuangdetailViewPresentor", package.seeall)

local MinghuangdetailViewPresentor = class("MinghuangdetailViewPresentor", ViewPresentor)

function MinghuangdetailViewPresentor:ctor()
	MinghuangdetailViewPresentor.super.ctor(self)
end

function MinghuangdetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MinghuangdetailViewPresentor:dependWhatResources()
	return {
		"ui/views/minghuangchallenge/minghuangdetailview.prefab"
	}
end

function MinghuangdetailViewPresentor:buildViews()
	return {
		MinghuangdetailView.New()
	}
end

return MinghuangdetailViewPresentor
