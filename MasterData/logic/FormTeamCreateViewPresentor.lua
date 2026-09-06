-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamCreateViewPresentor.lua

module("logic.extensions.formteam.view.FormTeamCreateViewPresentor", package.seeall)

local FormTeamCreateViewPresentor = class("FormTeamCreateViewPresentor", ViewPresentor)

function FormTeamCreateViewPresentor:ctor()
	FormTeamCreateViewPresentor.super.ctor(self)
end

function FormTeamCreateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FormTeamCreateViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/formteamcreateview.prefab"
	}
end

function FormTeamCreateViewPresentor:buildViews()
	return {
		FormTeamCreateView.New()
	}
end

return FormTeamCreateViewPresentor
