-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolamainViewPresentor.lua

module("logic.extensions.duolamengmeng.view.DuolamainViewPresentor", package.seeall)

local DuolamainViewPresentor = class("DuolamainViewPresentor", ViewPresentor)

function DuolamainViewPresentor:ctor()
	DuolamainViewPresentor.super.ctor(self)
end

function DuolamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DuolamainViewPresentor:dependWhatResources()
	return {
		"ui/views/duolamengmeng/duolamainview.prefab"
	}
end

function DuolamainViewPresentor:buildViews()
	return {
		DuoLaMainView.New()
	}
end

return DuolamainViewPresentor
