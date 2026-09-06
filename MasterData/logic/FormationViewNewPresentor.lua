-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationViewNewPresentor.lua

module("logic.extensions.formation.view.FormationViewNewPresentor", package.seeall)

local FormationViewNewPresentor = class("FormationViewNewPresentor", ViewWithGuidePresentor)

function FormationViewNewPresentor:ctor()
	FormationViewNewPresentor.super.ctor(self)
end

function FormationViewNewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormationViewNewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationview.prefab"
	}
end

function FormationViewNewPresentor:buildViews()
	return {
		BuzhenLeftView.New(),
		FormationRightView.New(),
		FormationView.New()
	}
end

return FormationViewNewPresentor
