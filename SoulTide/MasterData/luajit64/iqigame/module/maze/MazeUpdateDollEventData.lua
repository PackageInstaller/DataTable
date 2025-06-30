-- chunkname: @IQIGame\\Module\\Maze\\MazeUpdateDollEventData.lua

local m = {
	soulQualityCid = 0,
	power = 0,
	position = 0,
	mood = 0,
	exp = 0,
	dress3DCid = 0,
	formationPos = 0,
	hp = 0,
	soulMarryCid = 0,
	skillGroupId = 0,
	soulCid = 0,
	id = 0,
	dress2DCid = 0,
	lv = 0
}

function m.New(id)
	local obj = Clone(m)

	obj:Init(id)

	return obj
end

function m:Init(id)
	self.id = id
end

function m:GetOldValue(fieldName)
	if MazeDataModule.PlayerInfo == nil then
		return 0
	end

	local dollPOD = MazeDataModule.GetDollPODByID(self.id)

	if dollPOD == nil then
		logError("找不到对应的DollPOD")

		return 0
	end

	local currentValue = dollPOD[fieldName]
	local deltaValue = self[fieldName]

	if currentValue == nil then
		logError("在DollPOD中没有找到字段：" .. fieldName)

		return 0
	end

	if deltaValue == nil then
		logError("不支持字段：" .. fieldName)

		return 0
	end

	return currentValue - deltaValue
end

return m
