-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiExtremeClgViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiExtremeClgViewPresentor", package.seeall)

local DivineJiExtremeClgViewPresentor = class("DivineJiExtremeClgViewPresentor", ViewPresentor)

function DivineJiExtremeClgViewPresentor:ctor()
	DivineJiExtremeClgViewPresentor.super.ctor(self)
end

function DivineJiExtremeClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJiExtremeClgViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejiextremeclgview.prefab"
	}
end

function DivineJiExtremeClgViewPresentor:buildViews()
	return {
		DivineJiExtremeClgView.New()
	}
end

return DivineJiExtremeClgViewPresentor
