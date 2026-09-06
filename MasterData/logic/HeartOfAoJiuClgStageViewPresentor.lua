-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgStageViewPresentor.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgStageViewPresentor", package.seeall)

local HeartOfAoJiuClgStageViewPresentor = class("HeartOfAoJiuClgStageViewPresentor", ViewPresentor)

function HeartOfAoJiuClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartOfAoJiuClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiuclg/heartofaojiuclgstageview.prefab"
	}
end

function HeartOfAoJiuClgStageViewPresentor:buildViews()
	return {
		HeartOfAoJiuClgStageView.New()
	}
end

return HeartOfAoJiuClgStageViewPresentor
