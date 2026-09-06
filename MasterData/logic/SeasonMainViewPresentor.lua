-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonMainViewPresentor.lua

module("logic.extensions.sendflower.view.SeasonMainViewPresentor", package.seeall)

local SeasonMainViewPresentor = class("SeasonMainViewPresentor", ViewWithGuidePresentor)

function SeasonMainViewPresentor:ctor()
	SeasonMainViewPresentor.super.ctor(self)
end

function SeasonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonmainview.prefab"
	}
end

function SeasonMainViewPresentor:buildViews()
	return {
		SeasonMainView.New(),
		SeasonTeamsView.New(),
		SeasonS1TopBossView.New(),
		SeasonMainChatView.New()
	}
end

function SeasonMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonMainViewPresentor
