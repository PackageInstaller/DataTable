-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotusonetouchprepareViewPresentor.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotusonetouchprepareViewPresentor", package.seeall)

local RedlotusonetouchprepareViewPresentor = class("RedlotusonetouchprepareViewPresentor", ViewPresentor)

function RedlotusonetouchprepareViewPresentor:ctor()
	RedlotusonetouchprepareViewPresentor.super.ctor(self)
end

function RedlotusonetouchprepareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RedlotusonetouchprepareViewPresentor:dependWhatResources()
	return {
		"ui/views/redlotusdinnerparty/redlotusonetouchprepareview.prefab"
	}
end

function RedlotusonetouchprepareViewPresentor:buildViews()
	return {
		RedlotusonetouchprepareView.New()
	}
end

return RedlotusonetouchprepareViewPresentor
