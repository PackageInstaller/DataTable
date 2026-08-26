-- chunkname: @modules/logic/room/entity/comp/RoomEffectCompCacheData.lua

module("modules.logic.room.entity.comp.RoomEffectCompCacheData", package.seeall)

local RoomEffectCompCacheData = class("RoomEffectCompCacheData")

function RoomEffectCompCacheData:ctor(effectComp)
	self.effectComp = effectComp
	self._cacheDataDic = {}
end

function RoomEffectCompCacheData:getUserDataTb_()
	return self.effectComp:getUserDataTb_()
end

function RoomEffectCompCacheData:addDataByKey(key, typeName, data)
	local target = self._cacheDataDic
	local xTypeDic = target[typeName]

	if not xTypeDic then
		xTypeDic = {}
		target[typeName] = xTypeDic
	end

	xTypeDic[key] = data
end

function RoomEffectCompCacheData:getDataByKey(key, typeName)
	local target = self._cacheDataDic
	local xTypeDic = target[typeName]

	if xTypeDic then
		return xTypeDic[key]
	end
end

function RoomEffectCompCacheData:removeDataByKey(key)
	local target = self._cacheDataDic

	for typeName, xTypeDic in pairs(target) do
		local data = xTypeDic[key]

		if data then
			self:_removeData(data)
			rawset(xTypeDic, key, nil)
		end
	end
end

function RoomEffectCompCacheData:_removeData(data)
	if data and type(data) == "table" then
		for datakey in pairs(data) do
			rawset(data, datakey, nil)
		end
	end
end

function RoomEffectCompCacheData:dispose()
	local target = self._cacheDataDic

	for typeName, xTypeDic in pairs(target) do
		for key, data in pairs(xTypeDic) do
			if data then
				rawset(xTypeDic, key, nil)
				self:_removeData(data)
			end
		end

		target[typeName] = nil
	end
end

return RoomEffectCompCacheData
