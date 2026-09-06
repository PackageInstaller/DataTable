-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/view/MMTeamPassportAppListViewPresentor.lua

module("logic.extensions.mmteampassport.view.MMTeamPassportAppListViewPresentor", package.seeall)

local MMTeamPassportAppListViewPresentor = class("MMTeamPassportAppListViewPresentor", ViewPresentor)

function MMTeamPassportAppListViewPresentor:ctor()
	MMTeamPassportAppListViewPresentor.super.ctor(self)
end

function MMTeamPassportAppListViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MMTeamPassportAppListViewPresentor:dependWhatResources()
	return {
		"ui/views/mmteampassport/mmteampassportapplistview.prefab"
	}
end

function MMTeamPassportAppListViewPresentor:buildViews()
	return {
		MMTeamPassportAppListView.New()
	}
end

return MMTeamPassportAppListViewPresentor
