-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorAllFormsViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorAllFormsViewPresentor", package.seeall)

local SeniorAllFormsViewPresentor = class("SeniorAllFormsViewPresentor", ViewPresentor)

function SeniorAllFormsViewPresentor:ctor()
	SeniorAllFormsViewPresentor.super.ctor(self)
end

function SeniorAllFormsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeniorAllFormsViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorallformsview.prefab"
	}
end

function SeniorAllFormsViewPresentor:buildViews()
	return {
		SeniorAllFormsView.New(),
		SeniorPlayersView.New()
	}
end

return SeniorAllFormsViewPresentor
