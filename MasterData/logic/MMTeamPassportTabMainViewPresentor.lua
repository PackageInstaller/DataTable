-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportTabMainViewPresentor.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportTabMainViewPresentor", package.seeall)

local MMTeamPassportTabMainViewPresentor = class("MMTeamPassportTabMainViewPresentor", ViewPresentor)

function MMTeamPassportTabMainViewPresentor:ctor()
	MMTeamPassportTabMainViewPresentor.super.ctor(self)
end

function MMTeamPassportTabMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MMTeamPassportTabMainViewPresentor:dependWhatResources()
	return {
		"ui/views/mmteampassport/mmteampassporttabmainview.prefab"
	}
end

function MMTeamPassportTabMainViewPresentor:buildViews()
	return {
		MMTeamPassportTabMainView.New()
	}
end

function MMTeamPassportTabMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MMTeamPassportTabMainViewPresentor
