-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/S3SeasonMainViewPresentor.lua

module("logic.extensions.sendflower.view.S3SeasonMainViewPresentor", package.seeall)

local S3SeasonMainViewPresentor = class("S3SeasonMainViewPresentor", ViewWithGuidePresentor)

function S3SeasonMainViewPresentor:ctor()
	S3SeasonMainViewPresentor.super.ctor(self)
end

function S3SeasonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function S3SeasonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonmainview.prefab"
	}
end

function S3SeasonMainViewPresentor:buildViews()
	return {
		SeasonMainView.New(),
		SeasonTeamsView.New(),
		SeasonS3TopBossView.New(),
		SeasonMainChatView.New()
	}
end

function S3SeasonMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return S3SeasonMainViewPresentor
