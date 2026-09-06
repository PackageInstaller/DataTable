-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerMembersViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerMembersViewPresentor", package.seeall)

local SummontowerMembersViewPresentor = class("SummontowerMembersViewPresentor", ViewPresentor)

function SummontowerMembersViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerMembersViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowmembersview.prefab"
	}
end

function SummontowerMembersViewPresentor:buildViews()
	return {
		SummontowerMembersView.New()
	}
end

return SummontowerMembersViewPresentor
