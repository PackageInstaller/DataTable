-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressNormalFmtViewPresentor.lua

module("logic.extensions.divineempress.view.DivineEmpressNormalFmtViewPresentor", package.seeall)

local DivineEmpressNormalFmtViewPresentor = class("DivineEmpressNormalFmtViewPresentor", ViewPresentor)

function DivineEmpressNormalFmtViewPresentor:ctor()
	DivineEmpressNormalFmtViewPresentor.super.ctor(self)
end

function DivineEmpressNormalFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineEmpressNormalFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divineempress/divineempressnormalfmtview.prefab"
	}
end

function DivineEmpressNormalFmtViewPresentor:buildViews()
	return {
		DivineEmpressNormalFmtView.New()
	}
end

return DivineEmpressNormalFmtViewPresentor
