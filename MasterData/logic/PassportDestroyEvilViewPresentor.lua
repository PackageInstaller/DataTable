-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/destroyevil/PassportDestroyEvilViewPresentor.lua

module("logic.extensions.passport.view.destroyevil.PassportDestroyEvilViewPresentor", package.seeall)

local PassportDestroyEvilViewPresentor = class("PassportDestroyEvilViewPresentor", ViewPresentor)

function PassportDestroyEvilViewPresentor:ctor()
	PassportDestroyEvilViewPresentor.super.ctor(self)
end

function PassportDestroyEvilViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportDestroyEvilViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/destroyevil/passportdestroyevilview.prefab"
	}
end

function PassportDestroyEvilViewPresentor:buildViews()
	return {
		PassportDestroyEvilView.New()
	}
end

return PassportDestroyEvilViewPresentor
