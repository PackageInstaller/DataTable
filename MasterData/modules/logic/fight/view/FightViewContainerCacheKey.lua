-- chunkname: @modules/logic/fight/view/FightViewContainerCacheKey.lua

module("modules.logic.fight.view.FightViewContainerCacheKey", package.seeall)

local FightViewContainerCacheKey = _M
local _UID = 0

local function GetUid()
	_UID = _UID + 1

	return _UID
end

FightViewContainerCacheKey.UserDataKey = {
	HandCardGo = GetUid(),
	HandCardInnerGo = GetUid(),
	ClothSkillGo = GetUid(),
	PlayCardGO = GetUid(),
	WaitingAreaGO = GetUid(),
	DeviceAreaGo = GetUid(),
	RectDeviceCard = GetUid(),
	GoCalculatePosObj = GetUid(),
	DeviceAreaCardItem = GetUid()
}

return FightViewContainerCacheKey
