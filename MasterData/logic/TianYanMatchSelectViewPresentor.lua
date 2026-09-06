-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchSelectViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchSelectViewPresentor", package.seeall)

local TianYanMatchSelectViewPresentor = class("TianYanMatchSelectViewPresentor", ViewPresentor)

function TianYanMatchSelectViewPresentor:ctor()
	TianYanMatchSelectViewPresentor.super.ctor(self)
end

function TianYanMatchSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianYanMatchSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchselectview.prefab"
	}
end

function TianYanMatchSelectViewPresentor:buildViews()
	return {
		TianYanMatchSelectView.New()
	}
end

return TianYanMatchSelectViewPresentor
