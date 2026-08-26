-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItemMiscBase.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItemMiscBase", package.seeall)

local V3a7_Wmz_GameItemMiscBase = class("V3a7_Wmz_GameItemMiscBase", V3a7_Wmz_GameItemBase)

function V3a7_Wmz_GameItemMiscBase:ctor(...)
	V3a7_Wmz_GameItemMiscBase.super.ctor(self, ...)
end

function V3a7_Wmz_GameItemMiscBase:bZoneCompleted()
	local curPlayingZoneIndex = self:curPlayingZoneIndex()

	return curPlayingZoneIndex > self:zoneIndex()
end

function V3a7_Wmz_GameItemMiscBase:zoneIndex()
	return self:index()
end

return V3a7_Wmz_GameItemMiscBase
