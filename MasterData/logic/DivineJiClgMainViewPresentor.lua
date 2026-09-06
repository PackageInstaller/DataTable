-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiClgMainViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiClgMainViewPresentor", package.seeall)

local DivineJiClgMainViewPresentor = class("DivineJiClgMainViewPresentor", ViewPresentor)

function DivineJiClgMainViewPresentor:ctor()
	DivineJiClgMainViewPresentor.super.ctor(self)
end

function DivineJiClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJiClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejiclgmainview.prefab"
	}
end

function DivineJiClgMainViewPresentor:buildViews()
	return {
		DivineJiClgMainView.New()
	}
end

return DivineJiClgMainViewPresentor
