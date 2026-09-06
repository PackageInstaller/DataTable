-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetintroducePresentor.lua

module("logic.extensions.handbook.view.HandbookpetintroducePresentor", package.seeall)

local HandbookpetintroducePresentor = class("HandbookpetintroducePresentor", ViewPresentor)

function HandbookpetintroducePresentor:ctor()
	HandbookpetintroducePresentor.super.ctor(self)
end

function HandbookpetintroducePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HandbookpetintroducePresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookpetintroduceview.prefab"
	}
end

function HandbookpetintroducePresentor:buildViews()
	return {
		HandbookpetintroduceView.New()
	}
end

function HandbookpetintroducePresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HandbookpetintroducePresentor
