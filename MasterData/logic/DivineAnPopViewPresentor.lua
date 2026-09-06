-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinean/view/DivineAnPopViewPresentor.lua

module("logic.extensions.divinean.view.DivineAnPopViewPresentor", package.seeall)

local DivineAnPopViewPresentor = class("DivineAnPopViewPresentor", ViewPresentor)

function DivineAnPopViewPresentor:ctor()
	DivineAnPopViewPresentor.super.ctor(self)
end

function DivineAnPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineAnPopViewPresentor:dependWhatResources()
	return {
		"ui/views/divinean/divineanpopview.prefab"
	}
end

function DivineAnPopViewPresentor:buildViews()
	return {
		DivineAnPopView.New()
	}
end

return DivineAnPopViewPresentor
