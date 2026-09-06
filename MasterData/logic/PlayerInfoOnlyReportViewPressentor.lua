-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playeinfo/view/PlayerInfoOnlyReportViewPressentor.lua

module("logic.extensions.playeinfo.view.PlayerInfoOnlyReportViewPressentor", package.seeall)

local PlayerInfoOnlyReportViewPressentor = class("PlayerInfoOnlyReportViewPressentor", ViewPresentor)

function PlayerInfoOnlyReportViewPressentor:ctor()
	PlayerInfoOnlyReportViewPressentor.super.ctor(self)
end

function PlayerInfoOnlyReportViewPressentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlayerInfoOnlyReportViewPressentor:dependWhatResources()
	return {
		"ui/views/playerinfo/playerinfoview.prefab"
	}
end

function PlayerInfoOnlyReportViewPressentor:buildViews()
	return {
		PlayerInfoOnlyReportView.New()
	}
end

function PlayerInfoOnlyReportViewPressentor:setGrayMaskGO(grayMaskGO)
	PlayerInfoOnlyReportViewPressentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return PlayerInfoOnlyReportViewPressentor
