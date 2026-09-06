-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationgroupViewPresentor.lua

module("logic.extensions.formation.view.FormationgroupViewPresentor", package.seeall)

local FormationgroupViewPresentor = class("FormationgroupViewPresentor", ViewPresentor)

function FormationgroupViewPresentor:ctor()
	FormationgroupViewPresentor.super.ctor(self)
end

function FormationgroupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FormationgroupViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationgroupview.prefab"
	}
end

function FormationgroupViewPresentor:buildViews()
	return {
		FormationgroupView.New()
	}
end

return FormationgroupViewPresentor
