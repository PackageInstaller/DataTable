-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/selectpop/OracleselectpopViewPresentor.lua

module("logic.extensions.formation.view.selectpop.OracleselectpopViewPresentor", package.seeall)

local OracleselectpopViewPresentor = class("OracleselectpopViewPresentor", ViewPresentor)

function OracleselectpopViewPresentor:ctor()
	OracleselectpopViewPresentor.super.ctor(self)
end

function OracleselectpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OracleselectpopViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/oracleselectpopview.prefab"
	}
end

function OracleselectpopViewPresentor:buildViews()
	return {
		OracleselectpopView.New()
	}
end

return OracleselectpopViewPresentor
