-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueTempModel.lua

module("logic.extensions.roguelike.model.RogueTempModel", package.seeall)

local M = class("RogueTempModel")

function M:setCurScriptInfo(scriptId, diff)
	self._curScriptInfo = {
		scriptId,
		diff
	}
end

function M:getCurScriptInfo()
	return self._curScriptInfo
end

function M:setCurEquipId(equipId)
	self._curEquipId = equipId
end

function M:getCurEquipId()
	return self._curEquipId
end

function M:setCurRoleIds(roleIds)
	self._curRoleIds = roleIds
end

function M:getCurRoleIds()
	return self._curRoleIds
end

M.instance = M.New()

return M
