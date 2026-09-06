-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoohatchcancelViewPresentor.lua

module("logic.extensions.zoo.view.ZoohatchcancelViewPresentor", package.seeall)

local ZoohatchcancelViewPresentor = class("ZoohatchcancelViewPresentor", ViewPresentor)

function ZoohatchcancelViewPresentor:ctor()
	ZoohatchcancelViewPresentor.super.ctor(self)
end

function ZoohatchcancelViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZoohatchcancelViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoohatchcancelview.prefab"
	}
end

function ZoohatchcancelViewPresentor:buildViews()
	return {
		ZoohatchcancelView.New()
	}
end

return ZoohatchcancelViewPresentor
