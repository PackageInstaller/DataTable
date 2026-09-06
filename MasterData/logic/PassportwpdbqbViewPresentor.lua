-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpdbqbViewPresentor.lua

module("logic.extensions.passport.view.PassportwpdbqbViewPresentor", package.seeall)

local PassportwpdbqbViewPresentor = class("PassportwpdbqbViewPresentor", ViewPresentor)

function PassportwpdbqbViewPresentor:ctor()
	PassportwpdbqbViewPresentor.super.ctor(self)
end

function PassportwpdbqbViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PassportwpdbqbViewPresentor:dependWhatResources()
	return {
		"ui/views/passport/passportwpdbqbview.prefab"
	}
end

function PassportwpdbqbViewPresentor:buildViews()
	return {
		PassportwpdbqbView.New()
	}
end

return PassportwpdbqbViewPresentor
