-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabbg/view/TabbgPresentor.lua

module("logic.extensions.tabbg.view.TabbgPresentor", package.seeall)

local TabbgPresentor = class("TabbgPresentor", ViewPresentor)

function TabbgPresentor:ctor()
	TabbgPresentor.super.ctor(self)
end

function TabbgPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabbgPresentor:dependWhatResources()
	return {
		"ui/views/tabbg/tabbgview.prefab"
	}
end

function TabbgPresentor:buildViews()
	return {
		TabbgView.New()
	}
end

return TabbgPresentor
