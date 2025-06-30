-- chunkname: @IQIGame\\Module\\SaveData\\SaveDataModule.lua

local json = require("Util.json")

SaveDataModule = {}

function SaveDataModule.SaveInt(partitionId, key, value)
	return SaveDataModule.SaveString(partitionId, key, tostring(value))
end

function SaveDataModule.SaveFloat(partitionId, key, value)
	return SaveDataModule.SaveString(partitionId, key, tostring(value))
end

function SaveDataModule.SaveBool(partitionId, key, value)
	return SaveDataModule.SaveString(partitionId, key, tostring(value))
end

function SaveDataModule.SaveTable(partitionId, key, value)
	return SaveDataModule.SaveString(partitionId, key, json.encode(value))
end

function SaveDataModule.SaveString(partitionId, key, value)
	local serverKey = partitionId .. "_" .. key
	local success = net_player.saveSettingData(serverKey, value)

	if success then
		PlayerModule.PlayerInfo.settingData = PlayerModule.PlayerInfo.settingData or {}
		PlayerModule.PlayerInfo.settingData[serverKey] = value
	end

	return success
end

function SaveDataModule.GetInt(partitionId, key)
	return tonumber(SaveDataModule.GetString(partitionId, key))
end

function SaveDataModule.GetFloat(partitionId, key)
	return tonumber(SaveDataModule.GetString(partitionId, key))
end

function SaveDataModule.GetBool(partitionId, key)
	return SaveDataModule.GetString(partitionId, key) == "true"
end

function SaveDataModule.GetTable(partitionId, key)
	local savedValue = SaveDataModule.GetString(partitionId, key)

	if savedValue == nil then
		return nil
	end

	return json.decode(savedValue)
end

function SaveDataModule.GetString(partitionId, key)
	if PlayerModule.PlayerInfo.settingData == nil then
		return nil
	end

	return PlayerModule.PlayerInfo.settingData[partitionId .. "_" .. key]
end
