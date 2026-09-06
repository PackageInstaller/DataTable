-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgstageViewPresentor.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgstageViewPresentor", package.seeall)

local DivinekingjiclgstageViewPresentor = class("DivinekingjiclgstageViewPresentor", ViewPresentor)

function DivinekingjiclgstageViewPresentor:ctor()
	DivinekingjiclgstageViewPresentor.super.ctor(self)
end

function DivinekingjiclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekingjiclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingjiclg/divinekingjiclgstageview.prefab"
	}
end

function DivinekingjiclgstageViewPresentor:buildViews()
	return {
		DivinekingjiclgstageView.New()
	}
end

return DivinekingjiclgstageViewPresentor
