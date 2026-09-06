-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorFormsViewPresentor.lua

module("logic.extensions.seniorarena.view.SeniorFormsViewPresentor", package.seeall)

local SeniorFormsViewPresentor = class("SeniorFormsViewPresentor", ViewPresentor)

function SeniorFormsViewPresentor:ctor()
	SeniorFormsViewPresentor.super.ctor(self)
end

function SeniorFormsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeniorFormsViewPresentor:dependWhatResources()
	return {
		"ui/views/seniorarena/seniorformsview.prefab"
	}
end

function SeniorFormsViewPresentor:buildViews()
	return {
		SeniorFormsView.New()
	}
end

return SeniorFormsViewPresentor
