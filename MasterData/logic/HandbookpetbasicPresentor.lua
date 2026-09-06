-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetbasicPresentor.lua

module("logic.extensions.handbook.view.HandbookpetbasicPresentor", package.seeall)

local HandbookpetbasicPresentor = class("HandbookpetbasicPresentor", ViewPresentor)

function HandbookpetbasicPresentor:ctor()
	HandbookpetbasicPresentor.super.ctor(self)
end

function HandbookpetbasicPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HandbookpetbasicPresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookpetbasicview.prefab"
	}
end

function HandbookpetbasicPresentor:buildViews()
	return {
		HandbookpetbasicView.New()
	}
end

function HandbookpetbasicPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HandbookpetbasicPresentor
