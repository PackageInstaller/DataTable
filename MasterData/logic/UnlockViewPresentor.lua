-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/view/UnlockViewPresentor.lua

module("logic.extensions.unlock.view.UnlockViewPresentor", package.seeall)

local UnlockViewPresentor = class("UnlockViewPresentor", ViewPresentor)

function UnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/unlock/unlockview.prefab",
		CommonResPath.UIStoryBkg
	}
end

function UnlockViewPresentor:attachToWhichRoot()
	return
end

function UnlockViewPresentor:buildViews()
	local views = {}
	local unlockView = UnlockView.New()

	table.insert(views, unlockView)

	return views
end

return UnlockViewPresentor
