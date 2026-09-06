-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchRunningViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchRunningViewPresentor", package.seeall)

local TianYanMatchRunningViewPresentor = class("TianYanMatchRunningViewPresentor", ViewPresentor)

function TianYanMatchRunningViewPresentor:ctor()
	TianYanMatchRunningViewPresentor.super.ctor(self)
end

function TianYanMatchRunningViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TianYanMatchRunningViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchrunningview.prefab"
	}
end

function TianYanMatchRunningViewPresentor:buildViews()
	return {
		TianYanMatchRunningView.New()
	}
end

return TianYanMatchRunningViewPresentor
