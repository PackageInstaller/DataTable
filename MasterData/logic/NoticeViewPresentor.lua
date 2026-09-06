-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/notice/view/NoticeViewPresentor.lua

module("logic.extensions.rank.view.NoticeViewPresentor", package.seeall)

local NoticeViewPresentor = class("NoticeViewPresentor", ViewPresentor)

function NoticeViewPresentor:ctor()
	NoticeViewPresentor.super.ctor(self)
end

function NoticeViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function NoticeViewPresentor:dependWhatResources()
	return {
		"ui/views/notice/noticeview.prefab"
	}
end

function NoticeViewPresentor:buildViews()
	return {
		NoticeView.New()
	}
end

function NoticeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return NoticeViewPresentor
