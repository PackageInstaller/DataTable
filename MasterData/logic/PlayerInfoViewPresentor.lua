-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playeinfo/view/PlayerInfoViewPresentor.lua

module("logic.extensions.playeinfo.view.PlayerInfoViewPressentor", package.seeall)

local PlayerInfoViewPressentor = class("PlayerInfoViewPressentor", ViewPresentor)

function PlayerInfoViewPressentor:ctor()
	PlayerInfoViewPressentor.super.ctor(self)
end

function PlayerInfoViewPressentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlayerInfoViewPressentor:dependWhatResources()
	return {
		"ui/views/playerinfo/playerinfoview.prefab"
	}
end

function PlayerInfoViewPressentor:buildViews()
	return {
		PlayerInfoView.New()
	}
end

function PlayerInfoViewPressentor:setGrayMaskGO(grayMaskGO)
	PlayerInfoViewPressentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return PlayerInfoViewPressentor
