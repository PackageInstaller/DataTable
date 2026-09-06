-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/model/UserVar.lua

module("logic.extensions.city.model.UserVar", package.seeall)

local UserVar = class("UserVar")

function UserVar:ctor()
	self:clear()
end

function UserVar:clear()
	self._originMap = {}
	self._displayMap = {}
end

function UserVar:getDisplayVar(userVarKey)
	local obj = self._displayMap[userVarKey]

	if obj then
		return obj.value
	end

	return nil
end

function UserVar:getDisplayVarToNum(userVarKey)
	return checknumber(self:getDisplayVar(userVarKey))
end

function UserVar:getOriginVar(userVarKey)
	local obj = self._originMap[userVarKey]

	if obj then
		return obj.value
	end

	return nil
end

function UserVar:updateData(userVariabls)
	if userVariabls then
		for k, v in ipairs(userVariabls) do
			if not self._originMap[v.varName] then
				local varObj = {}

				varObj.varName = v.varName
				varObj.type = v.type

				if v.type == UserVarKey.TYPE_DELETE then
					varObj = nil
				elseif v.type == UserVarKey.TYPE_BOOLEAN then
					varObj.value = not string.nilorempty(v.value) and (string.upper(v.value) == "1" or string.upper(v.value) == "TRUE")
				elseif v.type == UserVarKey.TYPE_NUMBER then
					varObj.value = checknumber(v.value)
				elseif v.type == UserVarKey.TYPE_STRING then
					varObj.value = UserVar._parseValue(v.varName, v.value)
				end

				self._originMap[v.varName] = varObj
			end
		end

		self:updateDisplayUserVariabls()
	end
end

function UserVar:updateDisplayUserVariabls()
	table.clear(self._displayMap)

	for key, v in pairs(self._originMap) do
		if UserVarKey.checkKeyIsActive(key, self._originMap) then
			self._displayMap[key] = v
		end
	end
end

function UserVar:setBoolean(key, value, notUpdate)
	local val = value

	if type(val) == "string" and (val == "1" or val == "0") then
		-- block empty
	elseif type(val) == "boolean" then
		val = checkbool(value) and "1" or "0"
	else
		val = checkbool(value) and "1" or "0"

		printError(">>>>>>>>>>> 转换！请传正确参数类型")
	end

	return (self:_setValue(key, val, UserVarKey.TYPE_BOOLEAN, notUpdate))
end

function UserVar:setNumber(key, value, notUpdate)
	return (self:_setValue(key, value, UserVarKey.TYPE_NUMBER, notUpdate))
end

function UserVar:setString(key, value, notUpdate)
	return (self:_setValue(key, value, UserVarKey.TYPE_STRING, notUpdate))
end

function UserVar:deleteVar(key, notUpdate)
	local varObj = self._originMap[key]

	if varObj then
		varObj.varName = key
		varObj.value = ""
		varObj.type = UserVarKey.TYPE_DELETE
	end

	self._originMap[key] = nil

	if not checkbool(notUpdate) then
		self:updateDisplayUserVariabls()
	end

	return varObj
end

function UserVar:_setValue(key, value, type, notUpdate)
	if not self._originMap[key] then
		self._originMap[key].varName = key
		self._originMap[key].value = tostring(value)
		self._originMap[key].type = type
		self._originMap[key] = self._originMap[key]

		if not checkbool(notUpdate) then
			self:updateDisplayUserVariabls()
		end

		return self._originMap[key]
	end
end

function UserVar._parseValue(userVarKey, value)
	if userVarKey == UserVarKey.ANIMALS then
		local partArr = string.split(value, "#")
		local obj = {}

		obj.petId = checknumber(partArr[1])

		local partIds = {}

		for i = 2, #partArr do
			table.insert(partIds, checknumber(partArr[i]))
		end

		obj.petdata = partIds

		return obj
	elseif userVarKey == UserVarKey.ZOO_ANIMAL then
		local partArr = string.split(value, "#")
		local obj = {}

		obj.id = checknumber(partArr[1])
		obj.petId = checknumber(partArr[2])

		local partIds = {}

		for i = 3, #partArr do
			table.insert(partIds, checknumber(partArr[i]))
		end

		obj.partIds = partIds

		return obj
	elseif userVarKey == UserVarKey.MOUNT_DECORATORS then
		return GameUtil.jsonToTable(value)
	elseif userVarKey == UserVarKey.ATHENA_BLESS_LV then
		local list = {}
		local arr = string.split(value, ",")

		for k, v in pairs(arr) do
			local kvpair = string.split(v, ":")
			local temp = {}

			temp.activityId = checknumber(kvpair[1])
			temp.level = checknumber(kvpair[2])

			table.insert(list, temp)
		end

		return list
	elseif userVarKey == UserVarKey.CLOTHES then
		return (string.split(value, ","))
	end

	return value
end

return UserVar
