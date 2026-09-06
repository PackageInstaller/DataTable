-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportpartyViewPresentor.lua

module("logic.extensions.passport.view.PassportpartyViewPresentor", package.seeall)

local PassportpartyViewPresentor = class("PassportpartyViewPresentor", ViewPresentor)

function PassportpartyViewPresentor:ctor()
	PassportpartyViewPresentor.super.ctor(self)
end

function PassportpartyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportpartyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportpartyview.prefab"
	}
end

function PassportpartyViewPresentor:buildViews()
	return {
		PassportPartyView.New()
	}
end

return PassportpartyViewPresentor
