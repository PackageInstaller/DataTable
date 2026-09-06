-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/TeammateInfoViewPresentor.lua

module("logic.extensions.formteam.view.TeammateInfoViewPresentor", package.seeall)

local TeammateInfoViewPresentor = class("TeammateInfoViewPresentor", ViewPresentor)

function TeammateInfoViewPresentor:ctor()
	TeammateInfoViewPresentor.super.ctor(self)
end

function TeammateInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TeammateInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/formteam/teammateinfoview.prefab"
	}
end

function TeammateInfoViewPresentor:buildViews()
	return {
		TeammateInfoView.New()
	}
end

return TeammateInfoViewPresentor
