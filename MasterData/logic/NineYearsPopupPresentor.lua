-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/NineYearsPopupPresentor.lua

module("logic.extensions.accumulategift.view.NineYearsPopupPresentor", package.seeall)

local NineYearsPopupPresentor = class("NineYearsPopupPresentor", ViewPresentor)

function NineYearsPopupPresentor:ctor()
	NineYearsPopupPresentor.super.ctor(self)
end

function NineYearsPopupPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NineYearsPopupPresentor:dependWhatResources()
	return {
		"ui/views/accumulategift/nineyearspopup.prefab"
	}
end

function NineYearsPopupPresentor:buildViews()
	return {
		NineYearsPopup.New()
	}
end

return NineYearsPopupPresentor
