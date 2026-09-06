-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgRankViewPresentor.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgRankViewPresentor", package.seeall)

local HeartOfAoJiuClgRankViewPresentor = class("HeartOfAoJiuClgRankViewPresentor", ViewPresentor)

function HeartOfAoJiuClgRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartOfAoJiuClgRankViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiuclg/heartofaojiuclgrankview.prefab"
	}
end

function HeartOfAoJiuClgRankViewPresentor:buildViews()
	return {
		HeartOfAoJiuClgRankView.New()
	}
end

return HeartOfAoJiuClgRankViewPresentor
