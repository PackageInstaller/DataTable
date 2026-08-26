-- chunkname: @modules/logic/fight/controller/FightDeviceHelper.lua

module("modules.logic.fight.controller.FightDeviceHelper", package.seeall)

local FightDeviceHelper = _M
local DeviceItemInterVal = 0
local DeviceStartInterval = 25
local DeviceEndInterval = 25
local PowerItemWidth = 68
local PowerItemInterval = 5
local DeviceScanSuccessDuration = 0.5
local DeviceScanFailDuration = 0.5
local DeviceAreaInitAnchorX = 0
local DeviceAreaInitAnchorY = -25.6
local Career2Image = {
	[0] = "fight_device_career_0",
	"fight_device_career_1",
	"fight_device_career_2"
}
local Career2CoverImage = {
	[1] = "fight_device_card_career_1",
	[2] = "fight_device_card_career_2"
}
local DeviceCardGroupItemWidthDict = {
	[1] = 130,
	[2] = 250
}
local DeviceCardGroupSelectFrameWidthDict = {
	[1] = 126,
	[2] = 235
}
local DeviceCardGroupSelectFrameAnchorXDict = {
	[1] = 6,
	[2] = 0
}

function FightDeviceHelper.getSelectFrameWidth(deviceInfo, index)
	if not deviceInfo then
		return 0
	end

	index = index or deviceInfo.clientIndex

	return FightDeviceHelper.getSelectFrameWidthByGroup(deviceInfo.skills[index])
end

function FightDeviceHelper.getSelectFrameWidthByGroup(groupInfo)
	if not groupInfo then
		return 0
	end

	local skillCount = groupInfo:getCount()

	return DeviceCardGroupSelectFrameWidthDict[skillCount] or 0
end

function FightDeviceHelper.getSelectFrameAnchorX(deviceInfo, index)
	if not deviceInfo then
		return 0
	end

	index = index or deviceInfo.clientIndex

	return FightDeviceHelper.getSelectFrameAnchorXByGroup(deviceInfo.skills[index])
end

function FightDeviceHelper.getSelectFrameAnchorXByGroup(groupInfo)
	if not groupInfo then
		return 0
	end

	local skillCount = groupInfo:getCount()

	return DeviceCardGroupSelectFrameAnchorXDict[skillCount] or 0
end

function FightDeviceHelper.getDeviceScanDuration(success)
	return (success or nil) and (DeviceScanSuccessDuration or DeviceScanFailDuration)
end

function FightDeviceHelper.getDeviceItemInterValWidth()
	return DeviceItemInterVal
end

function FightDeviceHelper.getDeviceAreaInitAnchor()
	return DeviceAreaInitAnchorX, DeviceAreaInitAnchorY
end

function FightDeviceHelper.getDeviceItemAnchorX(targetIndex)
	local anchor = DeviceStartInterval
	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return anchor
	end

	for index, deviceInfo in ipairs(deviceArea.clientDeviceList) do
		if index == targetIndex then
			return anchor
		end

		anchor = anchor + FightDeviceHelper.getDeviceInfoWidth(deviceInfo) + DeviceItemInterVal
	end

	return anchor
end

function FightDeviceHelper.getDeviceInfoWidthByIndex(index)
	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return 0
	end

	local deviceInfo = deviceArea.clientDeviceList[index]

	return FightDeviceHelper.getDeviceInfoWidth(deviceInfo)
end

function FightDeviceHelper.getDeviceAreaTotalWidth()
	local deviceArea = FightDataHelper.getDeviceArea()

	if not deviceArea then
		return 0
	end

	local width = 0
	local count = 0

	for _, deviceInfo in ipairs(deviceArea.clientDeviceList) do
		width = width + FightDeviceHelper.getDeviceInfoWidth(deviceInfo)
		count = count + 1
	end

	width = width + (count - 1) * DeviceItemInterVal

	return DeviceStartInterval + width + DeviceEndInterval
end

function FightDeviceHelper.getDeviceInfoWidth(deviceInfo, index)
	if not deviceInfo then
		logError("input deviceInfo is nil")

		return 0
	end

	index = index or deviceInfo.clientIndex

	return FightDeviceHelper.getDeviceGroupWidth(deviceInfo.skills[index])
end

function FightDeviceHelper.getDeviceGroupWidth(groupSkillInfo)
	if not groupSkillInfo then
		return 0
	end

	local skillCount = groupSkillInfo:getCount()

	return DeviceCardGroupItemWidthDict[skillCount] or 0
end

function FightDeviceHelper.getDeviceAreaCount()
	local deviceArea = FightDataHelper.getDeviceArea()

	return (deviceArea:getCount())
end

function FightDeviceHelper.getDeviceAreaPowerTotalWidth(count)
	if not count then
		local deviceArea = FightDataHelper.getDeviceArea()

		count = #deviceArea.powers
	end

	local width = count * PowerItemWidth + (count - 1) * PowerItemInterval

	return math.max(0, width)
end

function FightDeviceHelper.syncDeviceAreaPos()
	FightController.instance:dispatchEvent(FightEvent.OnDevice_SyncAreaPos_InWaitArea)
end

function FightDeviceHelper.getCareerImage(career)
	return Career2Image[career] or Career2Image[1]
end

function FightDeviceHelper.getCareerCoverImage(career)
	return Career2CoverImage[career] or Career2CoverImage[1]
end

function FightDeviceHelper.getSkillIdAddDevicePower(skillId)
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
					return behaviourArray[2], behaviourArray[3]
				end
			end
		end
	end
end

function FightDeviceHelper.getSkillIdAddDeviceExPoint(skillId)
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		return 0
	end

	local addExPoint = 0
	local behaviourId = FightEnum.BehaviourId.AddDeviceExPoint

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == behaviourId then
					addExPoint = addExPoint + behaviourArray[2]
				end
			end
		end
	end

	return addExPoint
end

function FightDeviceHelper.getDeviceSkillCost(deviceId, skillId)
	local deviceCo = lua_fight_device.configDict[deviceId]

	if not deviceCo then
		return 0, 0
	end

	local skill1 = deviceCo.skill1
	local array = FightStrUtil.instance:getSplitToNumberCache(skill1, "#")

	if array and array[1] == skillId then
		return array[2], array[3]
	end

	local skill2 = deviceCo.skill2

	array = FightStrUtil.instance:getSplitToNumberCache(skill2, "#")

	if array and array[1] == skillId then
		return array[2], array[3]
	end

	return 0, 0
end

return FightDeviceHelper
