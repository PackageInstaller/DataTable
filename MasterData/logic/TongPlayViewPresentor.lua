-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongPlayViewPresentor.lua

module("logic.extensions.tongbattle.view.TongPlayViewPresentor", package.seeall)

local TongPlayViewPresentor = class("TongPlayViewPresentor", ViewWithGuidePresentor)

function TongPlayViewPresentor:ctor()
	TongPlayViewPresentor.super.ctor(self)
end

function TongPlayViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TongPlayViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongplayview.prefab"
	}
end

function TongPlayViewPresentor:buildViews()
	return {
		TongPlayView.New()
	}
end

return TongPlayViewPresentor
