-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginjiufmttabextViewPresentor.lua

module("logic.extensions.originjiu.view.OriginjiufmttabextViewPresentor", package.seeall)

local OriginjiufmttabextViewPresentor = class("OriginjiufmttabextViewPresentor", ViewPresentor)

function OriginjiufmttabextViewPresentor:ctor()
	OriginjiufmttabextViewPresentor.super.ctor(self)
end

function OriginjiufmttabextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginjiufmttabextViewPresentor:dependWhatResources()
	return {
		"ui/views/originjiu/originjiufmttabextview.prefab"
	}
end

function OriginjiufmttabextViewPresentor:buildViews()
	return {
		OriginjiufmttabextView.New()
	}
end

function OriginjiufmttabextViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return OriginjiufmttabextViewPresentor
