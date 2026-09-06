-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolagameViewPresentor.lua

module("logic.extensions.duolamengmeng.view.DuolagameViewPresentor", package.seeall)

local DuolagameViewPresentor = class("DuolagameViewPresentor", ViewPresentor)

function DuolagameViewPresentor:ctor()
	DuolagameViewPresentor.super.ctor(self)
end

function DuolagameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DuolagameViewPresentor:dependWhatResources()
	return {
		"ui/views/duolamengmeng/duolagameview.prefab"
	}
end

function DuolagameViewPresentor:buildViews()
	return {
		DuolaGameView.New()
	}
end

return DuolagameViewPresentor
