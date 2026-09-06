-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressResultViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressResultViewPresentor", package.seeall)

local DivineEmpressResultViewPresentor = class("DivineEmpressResultViewPresentor", ViewPresentor)

function DivineEmpressResultViewPresentor:ctor()
	DivineEmpressResultViewPresentor.super.ctor(self)
end

function DivineEmpressResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineEmpressResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressresultview.prefab"
	}
end

function DivineEmpressResultViewPresentor:buildViews()
	return {
		DivineEmpressResultView.New()
	}
end

return DivineEmpressResultViewPresentor
