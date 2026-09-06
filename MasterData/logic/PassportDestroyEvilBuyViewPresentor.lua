-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/destroyevil/PassportDestroyEvilBuyViewPresentor.lua

module("logic.extensions.passport.view.destroyevil.PassportDestroyEvilBuyViewPresentor", package.seeall)

local PassportDestroyEvilBuyViewPresentor = class("PassportDestroyEvilBuyViewPresentor", ViewPresentor)

function PassportDestroyEvilBuyViewPresentor:ctor()
	PassportDestroyEvilBuyViewPresentor.super.ctor(self)
end

function PassportDestroyEvilBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PassportDestroyEvilBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/destroyevil/passportdestroyevilbuyview.prefab"
	}
end

function PassportDestroyEvilBuyViewPresentor:buildViews()
	return {
		PassportDestroyEvilBuyView.New()
	}
end

return PassportDestroyEvilBuyViewPresentor
