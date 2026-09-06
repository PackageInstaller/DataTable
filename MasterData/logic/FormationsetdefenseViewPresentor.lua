-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationsetdefenseViewPresentor.lua

module("logic.extensions.formation.view.FormationsetdefenseViewPresentor", package.seeall)

local FormationsetdefenseViewPresentor = class("FormationsetdefenseViewPresentor", ViewPresentor)

function FormationsetdefenseViewPresentor:ctor()
	FormationsetdefenseViewPresentor.super.ctor(self)
end

function FormationsetdefenseViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FormationsetdefenseViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationsetdefenseview.prefab"
	}
end

function FormationsetdefenseViewPresentor:buildViews()
	return {
		FormationsetdefenseView.New(),
		FormationsetdefenseLeftView.New()
	}
end

return FormationsetdefenseViewPresentor
