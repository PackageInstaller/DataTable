-- chunkname: @modules/logic/fight/model/data/FightDeviceAreaInfoData.lua

module("modules.logic.fight.model.data.FightDeviceAreaInfoData", package.seeall)

local FightDeviceAreaInfoData = FightDataClass("FightDeviceAreaInfoData")

function FightDeviceAreaInfoData:onConstructor(proto)
	self.devices = {}
	self.clientDeviceList = {}

	for _, v in ipairs(proto.devices) do
		local data = FightDeviceInfoData.New(v)

		table.insert(self.devices, data)
		table.insert(self.clientDeviceList, data)
	end

	self.powers = {}

	for _, v in ipairs(proto.powers) do
		local powerData = FightDevicePowerData.New(v)

		powerData:setPowerType(FightDevicePowerData.PowerType.Server)
		table.insert(self.powers, powerData)
	end

	self.clientPowerList = {}
	self.showPowerList = {}

	self:updateShowPowerList()
end

function FightDeviceAreaInfoData:resetStopAttr()
	for _, deviceInfo in ipairs(self.devices) do
		deviceInfo:resetStopAttr()
	end
end

function FightDeviceAreaInfoData:restartDeviceAttr(targetUid)
	for _, deviceInfo in ipairs(self.devices) do
		if deviceInfo.uid == targetUid then
			deviceInfo:resetStopAttr()
		end
	end
end

function FightDeviceAreaInfoData:updateShowPowerList()
	for _, power in ipairs(self.showPowerList) do
		power:setPower(0)
	end

	for _, power in ipairs(self.powers) do
		self:_changeOnePowerValueByShow(power.id, power.power)
	end

	for _, power in ipairs(self.clientPowerList) do
		self:_changeOnePowerValueByShow(power.id, power.power)
	end
end

function FightDeviceAreaInfoData.sortPowerItem(powerItem1, powerItem2)
	return powerItem1.id < powerItem2.id
end

function FightDeviceAreaInfoData:getCount()
	if self.devices then
		return #self.devices
	end

	return 0
end

function FightDeviceAreaInfoData:resetClientChange()
	for _, power in ipairs(self.clientPowerList) do
		power:setPower(0)
	end

	self:updateShowPowerList()
end

function FightDeviceAreaInfoData:applyClientChange()
	for _, deviceInfo in ipairs(self.clientDeviceList) do
		deviceInfo:applyClientChange()
	end

	tabletool.clear(self.devices)
	tabletool.addValues(self.devices, self.clientDeviceList)

	for _, power in ipairs(self.clientPowerList) do
		power:setPower(0)
	end

	self:updateShowPowerList()
end

function FightDeviceAreaInfoData:clearPower()
	for _, power in ipairs(self.clientPowerList) do
		power:setPower(0)
	end

	for _, power in ipairs(self.powers) do
		power:setPower(0)
	end

	self:updateShowPowerList()
end

function FightDeviceAreaInfoData:changePower(changeStr)
	local array = FightStrUtil.instance:getSplitString2Cache(changeStr, true)

	for _, arr in ipairs(array) do
		local id = arr[1]
		local value = arr[2]

		self:changeOnePowerValue(id, value)
	end
end

function FightDeviceAreaInfoData:changeOnePowerValue(powerId, changeValue)
	for _, power in ipairs(self.powers) do
		if power.id == powerId then
			power:setPower(power.power + changeValue)
			self:updateShowPowerList()

			return
		end
	end

	local powerData = FightDevicePowerData.New({
		id = powerId,
		power = changeValue
	})

	powerData:setPowerType(FightDevicePowerData.PowerType.Server)
	table.insert(self.powers, powerData)
	self:updateShowPowerList()
end

function FightDeviceAreaInfoData:changeOnePowerValueByClient(powerId, changeValue)
	for _, power in ipairs(self.clientPowerList) do
		if power.id == powerId then
			power:setPower(power.power + changeValue)
			self:updateShowPowerList()

			return
		end
	end

	local powerData = FightDevicePowerData.New({
		id = powerId,
		power = changeValue
	})

	powerData:setPowerType(FightDevicePowerData.PowerType.Client)
	table.insert(self.clientPowerList, powerData)
	self:updateShowPowerList()
end

function FightDeviceAreaInfoData:_changeOnePowerValueByShow(powerId, changeValue)
	for _, power in ipairs(self.showPowerList) do
		if power.id == powerId then
			power:setPower(power.power + changeValue)

			return
		end
	end

	local powerData = FightDevicePowerData.New({
		id = powerId,
		power = changeValue
	})

	powerData:setPowerType(FightDevicePowerData.PowerType.Show)
	table.insert(self.showPowerList, powerData)
	table.sort(self.showPowerList, self.sortPowerItem)
end

function FightDeviceAreaInfoData:getShowPowerList()
	return self.showPowerList
end

function FightDeviceAreaInfoData:moveDevice(srcIndex, targetIndex)
	if srcIndex == targetIndex then
		return
	end

	local deviceInfo = self.clientDeviceList[srcIndex]

	if srcIndex < targetIndex then
		for i = srcIndex, targetIndex - 1 do
			self.clientDeviceList[i] = self.clientDeviceList[i + 1]
		end

		self.clientDeviceList[targetIndex] = deviceInfo
	else
		for i = srcIndex, targetIndex + 1, -1 do
			self.clientDeviceList[i] = self.clientDeviceList[i - 1]
		end

		self.clientDeviceList[targetIndex] = deviceInfo
	end
end

function FightDeviceAreaInfoData:getClientIndex(uid)
	for index, deviceInfo in ipairs(self.clientDeviceList) do
		if deviceInfo.uid == uid then
			return index
		end
	end

	return 1
end

function FightDeviceAreaInfoData:getClientDeviceList()
	return self.clientDeviceList
end

function FightDeviceAreaInfoData:getServerDeviceList()
	return self.devices
end

function FightDeviceAreaInfoData:getSkillIdByIndex(index)
	local data = self.devices[index]

	if not data then
		return
	end

	local skill = data.skills[data.index]
	local skillInfoData = skill and skill.skills[1]

	return skillInfoData and skillInfoData.skillId
end

function FightDeviceAreaInfoData:changeClientIndex(uid, index)
	local deviceInfoData = self:getClientDeviceInfo(uid)

	if not deviceInfoData then
		return
	end

	deviceInfoData:changeClientIndex(index)
end

function FightDeviceAreaInfoData:getClientDeviceInfo(uid)
	for _, deviceInfoData in ipairs(self.clientDeviceList) do
		if deviceInfoData.uid == uid then
			return deviceInfoData
		end
	end
end

function FightDeviceAreaInfoData:getServerDeviceInfo(uid)
	for _, deviceInfoData in ipairs(self.devices) do
		if deviceInfoData.uid == uid then
			return deviceInfoData
		end
	end
end

function FightDeviceAreaInfoData:refreshShowPowerTypeByHandCard()
	local handCardList = FightDataHelper.handCardMgr.handCard

	for _, cardMo in ipairs(handCardList) do
		local type = self:getSkillIdAddPowerType(cardMo.skillId)

		if type then
			self:_changeOnePowerValueByShow(type, 0)
		end
	end
end

function FightDeviceAreaInfoData:getSkillIdAddPowerType(skillId)
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		return
	end

	local behaviourId = FightEnum.BehaviourId.AddDevicePower

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == behaviourId then
					return behaviourArray[2]
				end
			end
		end
	end
end

function FightDeviceAreaInfoData:getClientPowerValue(powerId)
	for _, power in ipairs(self.clientPowerList) do
		if power.id == powerId then
			return power.power
		end
	end

	return 0
end

function FightDeviceAreaInfoData:stopSkill(targetId, skillId)
	for _, device in ipairs(self.devices) do
		if device.uid == targetId then
			device:stopSkill(skillId)
		end
	end
end

return FightDeviceAreaInfoData
