-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleTaskViewPresentor.lua

module("logic.extensions.freescuffle.view.FreeScuffleTaskViewPresentor", package.seeall)

local FreeScuffleTaskViewPresentor = class("FreeScuffleTaskViewPresentor", ViewPresentor)

function FreeScuffleTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FreeScuffleTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/freescuffle/freescuffletaskview.prefab"
	}
end

function FreeScuffleTaskViewPresentor:buildViews()
	return {
		FreeScuffleTaskView.New()
	}
end

return FreeScuffleTaskViewPresentor
