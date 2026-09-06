-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgStageSurePopViewPresentor.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgStageSurePopViewPresentor", package.seeall)

local HeartOfAoJiuClgStageSurePopViewPresentor = class("HeartOfAoJiuClgStageSurePopViewPresentor", ViewPresentor)

function HeartOfAoJiuClgStageSurePopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HeartOfAoJiuClgStageSurePopViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiuclg/heartofaojiuclgstagesurepopview.prefab"
	}
end

function HeartOfAoJiuClgStageSurePopViewPresentor:buildViews()
	return {
		HeartOfAoJiuClgStageSurePopView.New()
	}
end

return HeartOfAoJiuClgStageSurePopViewPresentor
