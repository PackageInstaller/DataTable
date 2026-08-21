-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikeUseEquipInOneGame.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikeUseEquipInOneGame", package.seeall)

local M = class("TaskRoguelikeUseEquipInOneGame")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = tonumber(param)

	tempStr = string.gsub(tempStr, "#1#", maxCount)

	return tempStr, maxCount
end

return M
