-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeditem/model/TimedItemModel.lua

module("logic.extensions.timeditem.model.TimedItemModel", package.seeall)

local TimedItemModel = class("TimedItemModel", BaseModel)

function TimedItemModel:ctor()
	TimedItemModel.super.ctor(self)
end

function TimedItemModel:onInit()
	self:onReset()
end

function TimedItemModel:onReset()
	self._hasInited = false
	self.TimedItemPool = {}
	self.expireableItemPool = {}
end

function TimedItemModel:reInited()
	self._hasInited = false
end

function TimedItemModel:addItems(list)
	local nowTime = ServerTime.now()

	for i, v in ipairs(list) do
		if self.TimedItemPool[v.id] == nil and nowTime < v.expiredTimeMillis / 1000 then
			local mo = TimedItem.New()

			mo:initData(MatType.TimedItem, v.id, 1)

			mo.expiredTimeMillis = v.expiredTimeMillis
			self.TimedItemPool[v.id] = mo
		end
	end
end

function TimedItemModel:deleteItems(list)
	for i, v in ipairs(list) do
		if self.TimedItemPool[v] ~= nil then
			self.TimedItemPool[v] = nil
		end
	end
end

function TimedItemModel:loadAllItems(list)
	self._hasInited = true

	self:addItems(list)
end

function TimedItemModel:getHasInited()
	return self._hasInited
end

function TimedItemModel:getTimedItemList()
	local list = {}

	for i, v in pairs(self.TimedItemPool or {}) do
		table.insert(list, v)
	end

	return list
end

function TimedItemModel:getTimedItemInfo(id)
	return self.TimedItemPool[id]
end

function TimedItemModel:getTimedItemNum(id)
	if self.TimedItemPool[id] then
		return self.TimedItemPool[id].num
	else
		return 0
	end
end

function TimedItemModel:loadAllExpirableItems(list)
	self._hasInited = true

	self:addExpirableItems(list)
end

function TimedItemModel:addExpirableItems(list)
	local nowTime = ServerTime.now()

	for i, v in ipairs(list) do
		if nowTime < v.expiredTimeMillis / 1000 then
			local mo = ExpireableItem.New()

			mo:setData(v)

			self.expireableItemPool[mo:getId()] = mo
		end
	end
end

function TimedItemModel:deleteExpirableItems(list)
	for i, v in ipairs(list) do
		if self.expireableItemPool[v] ~= nil then
			self.expireableItemPool[v] = nil
		end
	end
end

function TimedItemModel:getExpireableItemList()
	local list = {}

	for i, v in pairs(self.expireableItemPool or {}) do
		table.insert(list, v)
	end

	return list
end

function TimedItemModel:getExpireableItemInfo(id)
	return self.expireableItemPool[id]
end

function TimedItemModel:getExpireableItemNumByDefineId(defineId)
	local num = 0

	for i, v in pairs(self.expireableItemPool or {}) do
		if v:getDefineId() == defineId then
			num = num + 1
		end
	end

	return num
end

TimedItemModel.instance = TimedItemModel.New()

return TimedItemModel
