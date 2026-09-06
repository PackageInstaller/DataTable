-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiNormalClgViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiNormalClgViewPresentor", package.seeall)

local DivineJiNormalClgViewPresentor = class("DivineJiNormalClgViewPresentor", ViewPresentor)

function DivineJiNormalClgViewPresentor:ctor()
	DivineJiNormalClgViewPresentor.super.ctor(self)
end

function DivineJiNormalClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJiNormalClgViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejinormalclgview.prefab"
	}
end

function DivineJiNormalClgViewPresentor:buildViews()
	return {
		DivineJiNormalClgView.New()
	}
end

return DivineJiNormalClgViewPresentor
