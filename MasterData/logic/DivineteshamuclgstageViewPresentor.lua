-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgstageViewPresentor.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgstageViewPresentor", package.seeall)

local DivineteshamuclgstageViewPresentor = class("DivineteshamuclgstageViewPresentor", ViewPresentor)

function DivineteshamuclgstageViewPresentor:ctor()
	DivineteshamuclgstageViewPresentor.super.ctor(self)
end

function DivineteshamuclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineteshamuclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineteshamuclg/divineteshamuclgstageview.prefab"
	}
end

function DivineteshamuclgstageViewPresentor:buildViews()
	return {
		DivineteshamuclgstageView.New()
	}
end

return DivineteshamuclgstageViewPresentor
