-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FormationactivetipViewPresentor.lua

module("logic.extensions.nineplace.view.FormationactivetipViewPresentor", package.seeall)

local FormationactivetipViewPresentor = class("FormationactivetipViewPresentor", ViewWithGuidePresentor)

function FormationactivetipViewPresentor:ctor()
	FormationactivetipViewPresentor.super.ctor(self)
end

function FormationactivetipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FormationactivetipViewPresentor:dependWhatResources()
	return {
		"ui/views/nineplace/formationactivetipview.prefab"
	}
end

function FormationactivetipViewPresentor:buildViews()
	return {
		FormationactivetipView.New()
	}
end

return FormationactivetipViewPresentor
