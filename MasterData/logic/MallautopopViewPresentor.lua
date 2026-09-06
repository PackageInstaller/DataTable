-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/MallautopopViewPresentor.lua

module("logic.extensions.activitypopup.view.MallautopopViewPresentor", package.seeall)

local MallautopopViewPresentor = class("MallautopopViewPresentor", ViewPresentor)

function MallautopopViewPresentor:ctor()
	MallautopopViewPresentor.super.ctor(self)
end

function MallautopopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MallautopopViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/mallautopopview.prefab"
	}
end

function MallautopopViewPresentor:buildViews()
	return {
		MallautopopView.New()
	}
end

function MallautopopViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MallautopopViewPresentor
