-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetattributeViewPresentor.lua

module("logic.extensions.handbook.view.HandbookpetattributeViewPresentor", package.seeall)

local HandbookpetattributeViewPresentor = class("HandbookpetattributeViewPresentor", ViewPresentor)

function HandbookpetattributeViewPresentor:ctor()
	HandbookpetattributeViewPresentor.super.ctor(self)
end

function HandbookpetattributeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HandbookpetattributeViewPresentor:dependWhatResources()
	local params = self:getFirstParam()

	return {
		"ui/views/handbook/handbookpetattributeview.prefab"
	}
end

function HandbookpetattributeViewPresentor:buildViews()
	return {
		HandbookpetattributeView.New()
	}
end

function HandbookpetattributeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HandbookpetattributeViewPresentor
