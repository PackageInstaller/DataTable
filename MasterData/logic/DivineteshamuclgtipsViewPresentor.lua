-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgtipsViewPresentor.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgtipsViewPresentor", package.seeall)

local DivineteshamuclgtipsViewPresentor = class("DivineteshamuclgtipsViewPresentor", ViewPresentor)

function DivineteshamuclgtipsViewPresentor:ctor()
	DivineteshamuclgtipsViewPresentor.super.ctor(self)
end

function DivineteshamuclgtipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineteshamuclgtipsViewPresentor:dependWhatResources()
	return {
		"ui/views/divineteshamuclg/divineteshamuclgtipsview.prefab"
	}
end

function DivineteshamuclgtipsViewPresentor:buildViews()
	return {
		DivineteshamuclgtipsView.New()
	}
end

return DivineteshamuclgtipsViewPresentor
