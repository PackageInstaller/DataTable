-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgMainViewPresentor.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgMainViewPresentor", package.seeall)

local HeartOfAoJiuClgMainViewPresentor = class("HeartOfAoJiuClgMainViewPresentor", ViewPresentor)

function HeartOfAoJiuClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartOfAoJiuClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiuclg/heartofaojiuclgmainview.prefab"
	}
end

function HeartOfAoJiuClgMainViewPresentor:buildViews()
	return {
		HeartOfAoJiuClgMainView.New()
	}
end

return HeartOfAoJiuClgMainViewPresentor
