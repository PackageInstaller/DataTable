-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominaSigninteTaskViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominaSigninteTaskViewPresentor", package.seeall)

local DominaSigninteTaskViewPresentor = class("DominaSigninteTaskViewPresentor", ViewPresentor)

function DominaSigninteTaskViewPresentor:ctor()
	DominaSigninteTaskViewPresentor.super.ctor(self)
end

function DominaSigninteTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DominaSigninteTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/dominatenuoyachallenge/dominasignintetaskview.prefab"
	}
end

function DominaSigninteTaskViewPresentor:buildViews()
	return {
		DominaSigninteTaskView.New()
	}
end

return DominaSigninteTaskViewPresentor
