-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/formation/MoonKingFmtLeftView.lua

module("logic.extensions.moonking.view.formation.MoonKingFmtLeftView", package.seeall)

local MoonKingFmtLeftView = class("MoonKingFmtLeftView", FormationLeftView)

function MoonKingFmtLeftView:_SetPowerAndSpeed()
	MoonKingFmtLeftView.super._SetPowerAndSpeed(self)

	self._TxtC_Power.text = "？？？"
	self._TxtC_Speed.text = "？？？"
end

return MoonKingFmtLeftView
