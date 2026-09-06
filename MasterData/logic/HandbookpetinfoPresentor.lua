-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetinfoPresentor.lua

module("logic.extensions.handbook.view.HandbookpetinfoPresentor", package.seeall)

local HandbookpetinfoPresentor = class("HandbookpetinfoPresentor", ViewPresentor)

function HandbookpetinfoPresentor:ctor()
	HandbookpetinfoPresentor.super.ctor(self)
end

function HandbookpetinfoPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HandbookpetinfoPresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookpetinfoview.prefab"
	}
end

function HandbookpetinfoPresentor:buildViews()
	return {
		HandbookpetinfoView.New()
	}
end

function HandbookpetinfoPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HandbookpetinfoPresentor
