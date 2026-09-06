-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DdkresultViewPresentor.lua

module("logic.extensions.darkdragonknife.view.DdkresultViewPresentor", package.seeall)

local DdkresultViewPresentor = class("DdkresultViewPresentor", ViewPresentor)

function DdkresultViewPresentor:ctor()
	DdkresultViewPresentor.super.ctor(self)
end

function DdkresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DdkresultViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/ddkresultview.prefab"
	}
end

function DdkresultViewPresentor:buildViews()
	return {
		DdkResultView.New()
	}
end

return DdkresultViewPresentor
