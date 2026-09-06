-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FormationhintViewPresentor.lua

module("logic.extensions.nineplace.view.FormationhintViewPresentor", package.seeall)

local FormationhintViewPresentor = class("FormationhintViewPresentor", ViewPresentor)

function FormationhintViewPresentor:ctor()
	FormationhintViewPresentor.super.ctor(self)
end

function FormationhintViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FormationhintViewPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/formationhintview.prefab"
	}
end

function FormationhintViewPresentor:buildViews()
	return {
		FormationhintView.New()
	}
end

return FormationhintViewPresentor
