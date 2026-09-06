-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DdkexchangeViewPresentor.lua

module("logic.extensions.darkdragonknife.view.DdkexchangeViewPresentor", package.seeall)

local DdkexchangeViewPresentor = class("DdkexchangeViewPresentor", ViewPresentor)

function DdkexchangeViewPresentor:ctor()
	DdkexchangeViewPresentor.super.ctor(self)
end

function DdkexchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DdkexchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/darkdragonknife/ddkexchangeview.prefab"
	}
end

function DdkexchangeViewPresentor:buildViews()
	return {
		DdkExchangeView.New()
	}
end

return DdkexchangeViewPresentor
