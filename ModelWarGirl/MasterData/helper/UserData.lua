-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\UserData.lua

local PlayerPrefs = UnityEngine.PlayerPrefs
local TablePickle = require("Common/Tools/TablePickle")
local json = require("cjson")
local strClassName = "UserData"
local UserData = Class(strClassName)
local jsonData, file

function UserData:ctor(userID)
	self._userKey = userID
	self.data = nil

	self:loadData()
end

function UserData:saveData()
	if self.data then
		local strData = TablePickle.pickle(self.data)

		if strData then
			PlayerPrefs.SetString(self._userKey, strData)

			return true
		end
	end

	return false
end

function UserData:loadData()
	self.data = {}

	local strData = PlayerPrefs.GetString(self._userKey)

	if strData ~= nil and strData ~= "" then
		self.data = TablePickle.unpickle(strData)
	end

	return self.data
end

function UserData.saveCommonData(key, value)
	PlayerPrefs.SetString(key, value)
end

function UserData.loadCommonData(key)
	return PlayerPrefs.GetString(key)
end

function UserData.loadCommonDataWithDefualt(key, default)
	return PlayerPrefs.GetString(key, default)
end

function UserData.saveCommonDataIntList(key, list)
	local str = ""

	if list and #list > 0 then
		for i = 1, #list do
			if i == 1 then
				str = list[i]
			else
				str = str .. "_" .. list[i]
			end
		end
	end

	UserData.saveCommonData(key, str)
end

function UserData.loadCommonDataIntList(key, list)
	local list = {}
	local str = UserData.loadCommonData(key)

	if str then
		local strList = utils.splitString(str, "_")

		for _, s in ipairs(strList) do
			table.insert(list, tonumber(s))
		end
	end

	return list
end

function UserData.loadCommonDataList(key, list)
	local list = {}
	local str = UserData.loadCommonData(key)

	if str then
		local strList = utils.splitString(str, "_")

		for _, s in ipairs(strList) do
			table.insert(list, s)
		end
	end

	return list
end

function UserData.saveJsonData(key, value)
	UserData.loadJson()

	local tableData = jsonData or {}

	tableData[key] = value

	local succ, t = pcall(json.encode, tableData)
	local stringData = "{}"

	if succ then
		stringData = t
	end

	if stringData then
		file = io.open(filename, "w+")

		if file then
			file:write(stringData)
			file:flush()
			file:close()
		end
	end

	PlayerPrefs.SetString(key, value)
end

function UserData.loadJson(forceflag)
	if jsonData == nil or forceflag == true then
		local _file = io.open(filename, "r")

		if _file == nil then
			jsonData = {}

			return
		end

		local readall = _file:read("*a")

		if readall ~= nil and readall ~= "" then
			jsonData = json.decode(readall)
		else
			jsonData = {}
		end

		_file:close()
	end
end

function UserData.loadJsonData(key, forceflag)
	UserData.loadJson(forceflag)

	if jsonData[key] ~= nil then
		return jsonData[key]
	end

	return PlayerPrefs.GetString(key)
end

function UserData.saveCommonDataInt(key, value)
	PlayerPrefs.SetInt(key, value)
end

function UserData.loadCommonDataInt(key)
	return PlayerPrefs.GetInt(key)
end

function UserData.clearAllCommonData()
	PlayerPrefs.DeleteAll()
end

function UserData.clearCommonData(key)
	PlayerPrefs.DeleteKey(key)
end

function UserData.save()
	PlayerPrefs.Save()
end

local AccountData = {}
local AccountUid

function UserData.initClientData(playerUid)
	AccountData = {}
	AccountUid = playerUid

	local strData = PlayerPrefs.GetString(playerUid)

	if strData ~= nil and strData ~= "" then
		AccountData = TablePickle.unpickle(strData)
	end
end

function UserData.getClientData(key)
	return AccountData[key]
end

function UserData.setClientData(key, value)
	AccountData[key] = value

	UserData.saveClientData()
end

function UserData.saveClientData()
	if AccountUid then
		local strData = TablePickle.pickle(AccountData)

		if strData then
			PlayerPrefs.SetString(AccountUid, strData)
		end
	end
end

return UserData
