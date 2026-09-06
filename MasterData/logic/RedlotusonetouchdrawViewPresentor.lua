-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotusonetouchdrawViewPresentor.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotusonetouchdrawViewPresentor", package.seeall)

local RedlotusonetouchdrawViewPresentor = class("RedlotusonetouchdrawViewPresentor", ViewPresentor)

function RedlotusonetouchdrawViewPresentor:ctor()
	RedlotusonetouchdrawViewPresentor.super.ctor(self)
end

function RedlotusonetouchdrawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RedlotusonetouchdrawViewPresentor:dependWhatResources()
	return {
		"ui/views/redlotusdinnerparty/redlotusonetouchdrawview.prefab"
	}
end

function RedlotusonetouchdrawViewPresentor:buildViews()
	return {
		RedlotusonetouchdrawView.New()
	}
end

return RedlotusonetouchdrawViewPresentor
