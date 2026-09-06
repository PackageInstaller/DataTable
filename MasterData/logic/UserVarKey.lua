-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/model/UserVarKey.lua

module("logic.extensions.city.model.UserVarKey", package.seeall)

local UserVarKey = {}

UserVarKey.TYPE_DELETE = "x"
UserVarKey.TYPE_BOOLEAN = "b"
UserVarKey.TYPE_NUMBER = "n"
UserVarKey.TYPE_STRING = "s"
UserVarKey.FAMILY_NAME = "fn"
UserVarKey.CONVOY_STATE = "cv_s"
UserVarKey.CONVOY_BOX_ID = "cv_bi"
UserVarKey.CLOTHES = "cos"
UserVarKey.CUR_TITLE = "ctt"
UserVarKey.GENDER = "gr"
UserVarKey.ANIMALS = "al"
UserVarKey.ANIMAL_NAME = "aln"
UserVarKey.MOUNT = "mt"
UserVarKey.NAME_FRAME = "namef"
UserVarKey.ZOO_ANIMAL = "zaml"
UserVarKey.MOUNT_DECORATORS = "mtdcr"
UserVarKey.ATHENA_BLESS_LV = "ablv"
UserVarKey.NEW_NAME_FRAME = "nnf"
UserVarKey.CUTE_PET_RACE = "cp_race"
UserVarKey.CUTE_PET_NAME = "cp_name"
UserVarKey.ILLUSION_CUTE_PET_RACE = "cp_ir"
UserVarKey.FOOT_MOVE_TRACE = "ftpr"
UserVarKey.MOUNT_CAPTAIN = "mt_c"
UserVarKey.MOUNT_TEAM = "mt_m"

local N = 0
local Y = 1
local U = 2

UserVarKey.ROLE_RELATION_INDEX = {
	{
		default = "",
		key = UserVarKey.CLOTHES
	},
	{
		default = 0,
		key = UserVarKey.MOUNT
	},
	{
		default = false,
		key = UserVarKey.CONVOY_STATE
	},
	{
		default = 0,
		key = UserVarKey.ILLUSION_CUTE_PET_RACE
	}
}
UserVarKey.ROLE_RELATION_MAP = {
	{
		Y,
		U,
		U,
		U
	},
	{
		U,
		Y,
		U,
		U
	},
	{
		Y,
		N,
		Y,
		N
	},
	{
		N,
		N,
		U,
		Y
	}
}

function UserVarKey.checkKeyIsActive(userVarKey, allMap)
	return (UserVarKey._checkMapActive(userVarKey, allMap, UserVarKey.ROLE_RELATION_INDEX, UserVarKey.ROLE_RELATION_MAP))
end

function UserVarKey.getIndex(list, key)
	for i = 1, #list do
		if list[i].key == key then
			return i
		end
	end

	return false
end

function UserVarKey._checkMapActive(userVarKey, allMap, relationIdxList, relationMap)
	if not checkbool(allMap[userVarKey]) then
		return false
	end

	local idx = UserVarKey.getIndex(relationIdxList, userVarKey)

	if idx ~= false then
		local boo = true
		local map = {}

		for i, arr in ipairs(relationMap) do
			if i ~= idx then
				local obj = relationIdxList[i]
				local curKey = obj.key
				local var = allMap[curKey]

				if var ~= nil and var.value ~= obj.default then
					local type = arr[idx]

					if type ~= U then
						map[i] = type
					end
				end
			end
		end

		local map2 = {}

		for k, _ in pairs(map) do
			local arr = relationMap[k]

			for i, v in ipairs(arr) do
				if v == N then
					map2[i] = U
				end
			end
		end

		for k, v in pairs(map) do
			local v2 = map2[k]

			if v2 == nil then
				local obj = relationIdxList[k]
				local curKey = obj.key
				local var = allMap[curKey]

				if var ~= nil and var.value ~= obj.default and v == N then
					boo = false
				end
			end
		end

		return boo
	end

	return true
end

return UserVarKey
