-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MengxincardViewPresentor.lua

module("logic.extensions.monthcard.view.MengxincardViewPresentor", package.seeall)

local MengxincardViewPresentor = class("MengxincardViewPresentor", ViewPresentor)

function MengxincardViewPresentor:ctor()
	MengxincardViewPresentor.super.ctor(self)
end

function MengxincardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MengxincardViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/mengxincardview.prefab"
	}
end

function MengxincardViewPresentor:buildViews()
	return {
		MengxincardView.New()
	}
end

function MengxincardViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MengxincardViewPresentor
