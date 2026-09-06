-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportViewPresentor.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportViewPresentor", package.seeall)

local MMTeamPassportViewPresentor = class("MMTeamPassportViewPresentor", ViewPresentor)

function MMTeamPassportViewPresentor:ctor()
	MMTeamPassportViewPresentor.super.ctor(self)
end

function MMTeamPassportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMTeamPassportViewPresentor:dependWhatResources()
	return {
		"ui/views/mmteampassport/mmteampassportview.prefab"
	}
end

function MMTeamPassportViewPresentor:buildViews()
	return {
		MMTeamPassportView.New()
	}
end

function MMTeamPassportViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MMTeamPassportViewPresentor
