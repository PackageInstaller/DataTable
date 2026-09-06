-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunnorresultViewPresentor.lua

module("logic.extensions.divinekunlun.view.DivinekunlunnorresultViewPresentor", package.seeall)

local DivinekunlunnorresultViewPresentor = class("DivinekunlunnorresultViewPresentor", ViewPresentor)

function DivinekunlunnorresultViewPresentor:ctor()
	DivinekunlunnorresultViewPresentor.super.ctor(self)
end

function DivinekunlunnorresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekunlunnorresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinekunlun/divinekunlunnorresultview.prefab"
	}
end

function DivinekunlunnorresultViewPresentor:buildViews()
	return {
		DivinekunlunnorresultView.New()
	}
end

return DivinekunlunnorresultViewPresentor
