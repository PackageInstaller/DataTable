-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongResultViewPresentor.lua

module("logic.extensions.tongbattle.view.TongResultViewPresentor", package.seeall)

local TongResultViewPresentor = class("TongResultViewPresentor", ViewWithGuidePresentor)

function TongResultViewPresentor:ctor()
	TongResultViewPresentor.super.ctor(self)
end

function TongResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TongResultViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongresultview.prefab"
	}
end

function TongResultViewPresentor:buildViews()
	return {
		TongResultView.New()
	}
end

return TongResultViewPresentor
