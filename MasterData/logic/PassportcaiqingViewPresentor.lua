-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportcaiqingViewPresentor.lua

module("logic.extensions.passport.view.PassportcaiqingViewPresentor", package.seeall)

local PassportcaiqingViewPresentor = class("PassportcaiqingViewPresentor", ViewPresentor)

function PassportcaiqingViewPresentor:ctor()
	PassportcaiqingViewPresentor.super.ctor(self)
end

function PassportcaiqingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportcaiqingViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportcampview.prefab"
	}
end

function PassportcaiqingViewPresentor:buildViews()
	return {
		PassportcaiqingView.New()
	}
end

return PassportcaiqingViewPresentor
