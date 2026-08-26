-- chunkname: @modules/logic/sp02/dungeonmap/model/AtomicElementMo.lua

module("modules.logic.sp02.dungeonmap.model.AtomicElementMo", package.seeall)

local AtomicElementMo = pureTable("AtomicElementMo")

function AtomicElementMo:init(id)
	self.id = id
	self.config = AtomicDungeonConfig.instance:getElementConfig(id)
	self.optionEleData = {}
	self.emergencyAddSeconds = 0
	self.sendingEmergencySeconds = 0

	self:initKeyDoorData()
end

function AtomicElementMo:initKeyDoorData()
	self.curKeyElementDataMap = {}

	if self.config and self.config.type == AtomicDungeonEnum.ElementType.KeyDoor then
		local doorConfig = AtomicDungeonConfig.instance:getDoorElementConfig(self.id)

		if doorConfig and not string.nilorempty(doorConfig.keyElementIds) then
			local keyElementIds = string.splitToNumber(doorConfig.keyElementIds, "#")

			for index, keyElementId in ipairs(keyElementIds) do
				local keyElementData = {}

				keyElementData.index = index
				keyElementData.id = keyElementId
				keyElementData.isPut = false
				self.curKeyElementDataMap[keyElementId] = keyElementData
			end
		end
	end
end

function AtomicElementMo:updateInfo(info)
	self.id = info.id
	self.status = info.status

	self:updateOptionEleData(info.optionEle)

	self.emergencyCurrentSeconds = info.emergencyCurrentSeconds or 0

	self:updateKeyProgress(info.record)

	self.fightEpisodeId = info.fightEpisodeId
end

function AtomicElementMo:updateOptionEleData(info)
	self.optionEleData.result = info.result
end

function AtomicElementMo:addEmergencyCurrentSeconds(time)
	self.emergencyAddSeconds = self.emergencyAddSeconds + time
	self.emergencyCurrentSeconds = self.emergencyCurrentSeconds + time
end

function AtomicElementMo:markSendingEmergencySeconds()
	self.sendingEmergencySeconds = self.emergencyAddSeconds

	return self.sendingEmergencySeconds
end

function AtomicElementMo:cleanEmergencyAddSeconds()
	self.emergencyAddSeconds = math.max(0, self.emergencyAddSeconds - (self.sendingEmergencySeconds or self.emergencyAddSeconds))
	self.sendingEmergencySeconds = 0
end

function AtomicElementMo:showEmergency()
	local expireTime = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.EmergencyExpireTime, true)

	if expireTime > self.emergencyCurrentSeconds and self.status ~= AtomicDungeonEnum.ElementStatus.Delete then
		local timeStamp = expireTime - self.emergencyCurrentSeconds

		return true, timeStamp
	end

	return false
end

function AtomicElementMo:isExpired()
	return self.config and self.config.isEmergency == 1 and not self:showEmergency() or self.status == AtomicDungeonEnum.ElementStatus.Delete
end

function AtomicElementMo:updateKeyProgress(recordStr)
	if not string.nilorempty(recordStr) then
		local hasPutKeyElementIds = string.splitToNumber(recordStr, "#")

		for keyElementId, keyElementData in pairs(self.curKeyElementDataMap) do
			if tabletool.indexOf(hasPutKeyElementIds, keyElementId) then
				keyElementData.isPut = true
			end
		end
	end
end

function AtomicElementMo:getCurKeyElementDataMap()
	return self.curKeyElementDataMap
end

function AtomicElementMo:setKeyElementDataPutState(keyElementId, isPut)
	if self.curKeyElementDataMap[keyElementId] then
		self.curKeyElementDataMap[keyElementId].isPut = isPut
	end
end

function AtomicElementMo:getKeyElementDataPutState(keyElementId)
	return self.curKeyElementDataMap[keyElementId] and self.curKeyElementDataMap[keyElementId].isPut
end

function AtomicElementMo:getSaveKeyElementDataStr()
	local hasPutKeyElementIds = {}

	for keyElementId, keyElementData in pairs(self.curKeyElementDataMap) do
		if keyElementData.isPut then
			table.insert(hasPutKeyElementIds, keyElementId)
		end
	end

	return table.concat(hasPutKeyElementIds, "#")
end

function AtomicElementMo:checkIsAllKeyElementPut()
	for _, keyElementData in pairs(self.curKeyElementDataMap) do
		if not keyElementData.isPut then
			return false
		end
	end

	return true
end

function AtomicElementMo:checkIsHardFightElement()
	if self.config and self.config.type == AtomicDungeonEnum.ElementType.Fight then
		local fightElementConfig = AtomicDungeonConfig.instance:getFightElementConfig(self.id)

		if fightElementConfig and fightElementConfig.type == AtomicDungeonEnum.HardFightType then
			return true
		end
	end

	return false
end

return AtomicElementMo
