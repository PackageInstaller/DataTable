-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMSettingPresentor.lua

module("logic.extensions.gm.view.GMSettingPresentor", package.seeall)

local GMSettingPresentor = class("GMSettingPresentor", ViewPresentor)

function GMSettingPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function GMSettingPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmsettingview.prefab"
	}
end

function GMSettingPresentor:buildViews()
	return {
		GMSettingView.New()
	}
end

return GMSettingPresentor
