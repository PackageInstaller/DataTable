-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressMainViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressMainViewPresentor", package.seeall)

local DivineEmpressMainViewPresentor = class("DivineEmpressMainViewPresentor", ViewPresentor)

function DivineEmpressMainViewPresentor:ctor()
	DivineEmpressMainViewPresentor.super.ctor(self)
end

function DivineEmpressMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEmpressMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressmainview.prefab"
	}
end

function DivineEmpressMainViewPresentor:buildViews()
	return {
		DivineEmpressMainView.New()
	}
end

return DivineEmpressMainViewPresentor
