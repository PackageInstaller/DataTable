-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamFetterViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamFetterViewPresentor", package.seeall)

local FormTeamFetterViewPresentor = class("FormTeamFetterViewPresentor", ViewPresentor)

function FormTeamFetterViewPresentor:ctor()
	FormTeamFetterViewPresentor.super.ctor(self)
end

function FormTeamFetterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormTeamFetterViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteamfetterview.prefab"
	}
end

function FormTeamFetterViewPresentor:buildViews()
	return {
		FormTeamFetterView.New()
	}
end

return FormTeamFetterViewPresentor
