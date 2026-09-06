-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchManualViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchManualViewPresentor", package.seeall)

local TianYanMatchManualViewPresentor = class("TianYanMatchManualViewPresentor", ViewPresentor)

function TianYanMatchManualViewPresentor:ctor()
	TianYanMatchManualViewPresentor.super.ctor(self)
end

function TianYanMatchManualViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TianYanMatchManualViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchmanualview.prefab"
	}
end

function TianYanMatchManualViewPresentor:buildViews()
	return {
		TianYanMatchManualView.New()
	}
end

return TianYanMatchManualViewPresentor
