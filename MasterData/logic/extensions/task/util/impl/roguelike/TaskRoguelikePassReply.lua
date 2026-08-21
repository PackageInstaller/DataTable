-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/roguelike/TaskRoguelikePassReply.lua

module("logic.extensions.task.util.impl.roguelike.TaskRoguelikePassReply", package.seeall)

local M = class("TaskRoguelikePassReply")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1
	local replyId = tonumber(param)

	if not replyId then
		if enableErrorLog then
			printError("Invalid parameter with code:", code)
		end

		return tempStr, maxCount
	end

	local name = false
	local replyCO = RoguelikeConfig.instance:getRoguelikeEventById(replyId)

	if replyCO then
		name = replyCO.name
	end

	if not string.nilorempty(tempStr) then
		tempStr = string.gsub(tempStr, "#1#", name)
	end

	return tempStr, maxCount
end

return M
