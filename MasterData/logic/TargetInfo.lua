-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/model/TargetInfo.lua

module("logic.extensions.powerland.model.TargetInfo", package.seeall)

local TargetInfo = class("TargetInfo")

function TargetInfo:ctor()
	self._targetMoList = {}
	self._targetMoPool = {}
end

function TargetInfo:_initTargetMoPool()
	self._targetMoPool = {}

	local targetIds = PowerLandConfig.instance:getAllTargetId()

	for _, targetId in ipairs(targetIds) do
		self:_addTargetMoToPool(targetId)
	end
end

function TargetInfo:_updateTargetMoPool(targetIdList)
	for _, targetId in ipairs(targetIdList) do
		self:_addTargetMoToPool(targetId)
	end
end

function TargetInfo:_addTargetMoToPool(targetId)
	if not self._targetMoPool[targetId] then
		local mo = {}

		mo.targetId = mo.targetId or targetId

		if mo.count then
			mo.count = mo.count + 1 or 0
		end

		mo.level = 0

		if mo.count > 0 then
			local targetDataList = PowerLandConfig.instance:getTargetDataList(targetId)

			for _, data in ipairs(targetDataList) do
				if mo.count >= data.level then
					mo.level = data.level or mo.level
				end
			end
		end

		self._targetMoPool[targetId] = mo
	end
end

function TargetInfo:_updateTargetMoList()
	self._targetMoList = {}

	for _, mo in pairs(self._targetMoPool) do
		table.insert(self._targetMoList, mo)
	end

	table.sort(self._targetMoList, function(a, b)
		if a.count == b.count then
			if a.targetId < b.targetId then
				return true
			end

			return false
		end

		return a.count > b.count
	end)
end

function TargetInfo:updateTargetMoData(targetIdList)
	self:_initTargetMoPool()
	self:_updateTargetMoPool(targetIdList)
	self:_updateTargetMoList()
end

function TargetInfo:getTargetMoList()
	return self._targetMoList
end

function TargetInfo:getTargetMo(targetId)
	return self._targetMoPool[targetId]
end

function TargetInfo:getTargetLevel(targetId)
	if self:isHaveTarget(targetId) then
		return self:getTargetMo(targetId).level
	else
		return 0
	end
end

function TargetInfo:getTargetCount(targetId)
	if self:isHaveTarget(targetId) then
		return self:getTargetMo(targetId).count
	else
		return 0
	end
end

function TargetInfo:getAllHaveTargetCount()
	return #self._targetMoList
end

function TargetInfo:isHaveTarget(targetId)
	return self._targetMoPool[targetId] ~= nil
end

return TargetInfo
