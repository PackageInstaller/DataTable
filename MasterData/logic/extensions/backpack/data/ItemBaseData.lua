-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/data/ItemBaseData.lua

module("logic.extensions.backpack.data.ItemBaseData", package.seeall)

local PropFilterType = CommEnum.PropFilterType
local M = class("ItemBaseData")

function M:ctor(params)
	self._uuid = params.uuid or 0
	self.id = self._uuid
	self._count = params.count or 1
	self._itemInfo = params.itemId and BackpackConfig.instance:getItemInfoByItemId(params.itemId) or {}
	self._expireTime = params.expireTime or 0
	self._exData = params.exData or ""
	self._itemMarkType = params.itemMarkType or EventType.ITEM_NORMAL_MARK_TYPE
	self._isLocked = params.isLocked or false
	self._rewardTag = params.rewardTag or 0
	self._addTime = params.addTime or 0
	self._redPoint = params.redpoint or 0
	self._activityId = params.activityId or 0
	self._isReceiveLock = false
end

function M:getUuid()
	return self._uuid
end

function M:getItemMarkType()
	return self._itemMarkType
end

function M:setItemMarkType(itemMarkType)
	self._itemMarkType = itemMarkType
end

function M:getType()
	return self._itemInfo.type or 0
end

function M:getSubType()
	return self._itemInfo.subType or 0
end

function M:getItemInfo()
	return self._itemInfo
end

function M:getItemId()
	return self._itemInfo.id or 0
end

function M:getModelId()
	return self._modelId
end

function M:getCount()
	return self._count
end

function M:setCount(count)
	self._count = count
end

function getExData()
	return self._exData
end

function M:getName()
	return self._itemInfo.name or ""
end

function M:getIcon()
	return ItemUtil.getItemCoIcon(self._itemInfo)
end

function M:getItemDesc()
	return self._itemInfo.desc or ""
end

function M:getItemUseDesc()
	return self._itemInfo.useDesc or ""
end

function M:getFilterType()
	return self._itemInfo.filterType or PropFilterType.AllFilterType
end

function M:getPriority()
	return self._itemInfo.priority or 0
end

function M:getQuality()
	return self._itemInfo.quality or 1
end

function M:getExpireTime()
	return self._expireTime
end

function M:getGetWays()
	return self._itemInfo.getWays or ""
end

function M:getIsShowBag()
	return self._itemInfo.isShowBag == 1
end

function M:getJumpId()
	return self._itemInfo.jumpId
end

function M:getExtrInfo()
	return self._itemInfo.exInfo
end

function M:getIsLock()
	return self._isLocked
end

function M:setIsLock(status)
	self._isLocked = status
end

function M:getIsReceiveLock()
	return self._isReceiveLock
end

function M:setIsReceiveLock(isLock)
	self._isReceiveLock = isLock
end

function M:setRewardTag(tagValue)
	self._rewardTag = tagValue
end

function M:getRewardTag()
	return self._rewardTag
end

function M:getPrefabId()
	return false
end

function M:setAddTime(addTime)
	self._addTime = addTime or self._addTime
end

function M:getAddTime()
	return self._addTime or 0
end

function M:getRedPoint()
	return self._redPoint or 0
end

function M:setRedPoint(redPoint)
	self._redPoint = redPoint
end

function M:getRedPointIsNew()
	local redPoint = self:getRedPoint()

	return MultipleEnumUtil.multipleEnumContain(redPoint, 1)
end

function M:getRedPointIsUseableGiftBox()
	local redPoint = self:getRedPoint()
	local enumValue = MultipleEnumUtil.getOneMultipleValue(1, 2)

	return MultipleEnumUtil.multipleEnumContain(redPoint, enumValue)
end

function M:getRedPointIsMayExpired()
	local redPoint = self:getRedPoint()
	local enumValue = MultipleEnumUtil.getOneMultipleValue(1, 3)

	return MultipleEnumUtil.multipleEnumContain(redPoint, enumValue)
end

function M:getActivityId()
	return self._activityId or 0
end

return M
