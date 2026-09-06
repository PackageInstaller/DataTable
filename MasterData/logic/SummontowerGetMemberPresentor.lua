-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerGetMemberPresentor.lua

module("logic.extensions.summontower.view.SummontowerGetMemberPresentor", package.seeall)

local SummontowerGetMemberPresentor = class("SummontowerGetMemberPresentor", ViewPresentor)

function SummontowerGetMemberPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerGetMemberPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowgetnumbersview.prefab"
	}
end

function SummontowerGetMemberPresentor:buildViews()
	return {
		SummontowerGetMember.New()
	}
end

return SummontowerGetMemberPresentor
