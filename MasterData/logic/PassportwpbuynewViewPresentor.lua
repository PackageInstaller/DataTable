-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpbuynewViewPresentor.lua

module("logic.extensions.passport.view.PassportwpbuynewViewPresentor", package.seeall)

local PassportwpbuynewViewPresentor = class("PassportwpbuynewViewPresentor", ViewPresentor)

function PassportwpbuynewViewPresentor:ctor()
	PassportwpbuynewViewPresentor.super.ctor(self)
end

function PassportwpbuynewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportwpbuynewViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpbuyview_new.prefab"
	}
end

function PassportwpbuynewViewPresentor:buildViews()
	return {
		PassportwpbuynewView.New()
	}
end

return PassportwpbuynewViewPresentor
