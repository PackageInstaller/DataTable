-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressExtreFmtViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressExtreFmtViewPresentor", package.seeall)

local DivineEmpressExtreFmtViewPresentor = class("DivineEmpressExtreFmtViewPresentor", ViewPresentor)

function DivineEmpressExtreFmtViewPresentor:ctor()
	DivineEmpressExtreFmtViewPresentor.super.ctor(self)
end

function DivineEmpressExtreFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEmpressExtreFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressextrefmtview.prefab"
	}
end

function DivineEmpressExtreFmtViewPresentor:buildViews()
	return {
		DivineEmpressExtreFmtView.New()
	}
end

return DivineEmpressExtreFmtViewPresentor
