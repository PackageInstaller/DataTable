-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkbuypetViewPresentor.lua

module("logic.extensions.elementspark.view.ElementsparkbuypetViewPresentor", package.seeall)

local ElementsparkbuypetViewPresentor = class("ElementsparkbuypetViewPresentor", ViewPresentor)

function ElementsparkbuypetViewPresentor:ctor()
	ElementsparkbuypetViewPresentor.super.ctor(self)
end

function ElementsparkbuypetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementsparkbuypetViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkbuypetview.prefab"
	}
end

function ElementsparkbuypetViewPresentor:buildViews()
	return {
		ElementsparkbuypetView.New()
	}
end

return ElementsparkbuypetViewPresentor
