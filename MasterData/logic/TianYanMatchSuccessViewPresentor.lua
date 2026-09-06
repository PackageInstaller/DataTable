-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchSuccessViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchSuccessViewPresentor", package.seeall)

local TianYanMatchSuccessViewPresentor = class("TianYanMatchSuccessViewPresentor", ViewPresentor)

function TianYanMatchSuccessViewPresentor:ctor()
	TianYanMatchSuccessViewPresentor.super.ctor(self)
end

function TianYanMatchSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TianYanMatchSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchsuccessview.prefab"
	}
end

function TianYanMatchSuccessViewPresentor:buildViews()
	return {
		TianYanMatchSuccessView.New()
	}
end

return TianYanMatchSuccessViewPresentor
