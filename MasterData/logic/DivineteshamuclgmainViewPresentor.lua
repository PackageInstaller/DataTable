-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/view/DivineteshamuclgmainViewPresentor.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgmainViewPresentor", package.seeall)

local DivineteshamuclgmainViewPresentor = class("DivineteshamuclgmainViewPresentor", ViewPresentor)

function DivineteshamuclgmainViewPresentor:ctor()
	DivineteshamuclgmainViewPresentor.super.ctor(self)
end

function DivineteshamuclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineteshamuclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineteshamuclg/divineteshamuclgmainview.prefab"
	}
end

function DivineteshamuclgmainViewPresentor:buildViews()
	return {
		DivineteshamuclgmainView.New()
	}
end

return DivineteshamuclgmainViewPresentor
