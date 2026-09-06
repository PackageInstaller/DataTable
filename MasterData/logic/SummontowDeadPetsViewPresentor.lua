-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowDeadPetsViewPresentor.lua

module("logic.extensions.summontower.view.SummontowDeadPetsViewPresentor", package.seeall)

local SummontowDeadPetsViewPresentor = class("SummontowDeadPetsViewPresentor", ViewPresentor)

function SummontowDeadPetsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowDeadPetsViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowdeadpetsview.prefab"
	}
end

function SummontowDeadPetsViewPresentor:buildViews()
	return {
		SummontowDeadPetsView.New()
	}
end

return SummontowDeadPetsViewPresentor
