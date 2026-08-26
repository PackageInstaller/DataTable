-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItemBase.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItemBase", package.seeall)

local V3a7_Wmz_GameItemBase = class("V3a7_Wmz_GameItemBase", RougeSimpleItemBase)

function V3a7_Wmz_GameItemBase:ctor(...)
	V3a7_Wmz_GameItemBase.super.ctor(self, ...)
end

function V3a7_Wmz_GameItemBase:dragContext()
	local c = self:baseViewContainer()

	return c:dragContext()
end

function V3a7_Wmz_GameItemBase:isCompleted()
	return self:dragContext():isCompleted()
end

function V3a7_Wmz_GameItemBase:setSprite(...)
	local c = self:baseViewContainer()

	return c:setSprite(...)
end

function V3a7_Wmz_GameItemBase:coordToAPosInContentSpace(...)
	local c = self:baseViewContainer()

	return c:coordToAPosInContentSpace(...)
end

function V3a7_Wmz_GameItemBase:getTileIdListByGroup()
	local c = self:baseViewContainer()

	return c:getTileIdListByGroup(self:groupId())
end

function V3a7_Wmz_GameItemBase:getZoneIdListByGroup()
	local c = self:baseViewContainer()

	return c:getZoneIdListByGroup(self:zoneId())
end

function V3a7_Wmz_GameItemBase:zoneClearCurAndMax(...)
	local c = self:baseViewContainer()

	return c:zoneClearCurAndMax(...)
end

function V3a7_Wmz_GameItemBase:zoneIndex2ZoneId(...)
	local c = self:baseViewContainer()

	return c:zoneIndex2ZoneId(...)
end

function V3a7_Wmz_GameItemBase:getZoneId2Index(...)
	local c = self:baseViewContainer()

	return c:getZoneId2Index(...)
end

function V3a7_Wmz_GameItemBase:curPlayingZoneIndex(...)
	local c = self:baseViewContainer()

	return c:curPlayingZoneIndex(...)
end

function V3a7_Wmz_GameItemBase:getSelectedZoneIdx(...)
	local c = self:baseViewContainer()

	return c:getSelectedZoneIdx(...)
end

function V3a7_Wmz_GameItemBase:bSelectedZone(...)
	return self:zoneIndex() == self:getSelectedZoneIdx()
end

function V3a7_Wmz_GameItemBase:bZoneUnlocked(...)
	return self:zoneIndex() <= self:curPlayingZoneIndex()
end

function V3a7_Wmz_GameItemBase:setGrayScale(...)
	assert(false, "please override this function")
end

function V3a7_Wmz_GameItemBase:_debug_refresh()
	if not WmzEnum.rDir then
		return
	end
end

return V3a7_Wmz_GameItemBase
