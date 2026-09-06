-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqitigergameViewPresentor.lua

module("logic.extensions.doushouqi.view.DoushouqitigergameViewPresentor", package.seeall)

local DoushouqitigergameViewPresentor = class("DoushouqitigergameViewPresentor", ViewWithGuidePresentor)

function DoushouqitigergameViewPresentor:ctor()
	DoushouqitigergameViewPresentor.super.ctor(self)
end

function DoushouqitigergameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DoushouqitigergameViewPresentor:dependWhatResources()
	return {
		"ui/views/doushouqi/doushouqitigergameview.prefab"
	}
end

function DoushouqitigergameViewPresentor:buildViews()
	return {
		DoushouqitigergameView.New()
	}
end

return DoushouqitigergameViewPresentor
