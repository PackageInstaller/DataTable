-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingjiclg/view/DivinekingjiclgextViewPresentor.lua

module("logic.extensions.divinekingjiclg.view.DivinekingjiclgextViewPresentor", package.seeall)

local DivinekingjiclgextViewPresentor = class("DivinekingjiclgextViewPresentor", ViewPresentor)

function DivinekingjiclgextViewPresentor:ctor()
	DivinekingjiclgextViewPresentor.super.ctor(self)
end

function DivinekingjiclgextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekingjiclgextViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingjiclg/divinekingjiclgextview.prefab"
	}
end

function DivinekingjiclgextViewPresentor:buildViews()
	return {
		DivinekingjiclgextView.New()
	}
end

function DivinekingjiclgextViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DivinekingjiclgextViewPresentor
