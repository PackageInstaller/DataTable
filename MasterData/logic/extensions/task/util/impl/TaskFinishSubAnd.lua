-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/impl/TaskFinishSubAnd.lua

module("logic.extensions.task.util.impl.TaskFinishSubAnd", package.seeall)

local M = class("TaskFinishSubAnd")

function M:parseContent(code, desc, param)
	local tempStr = desc
	local maxCount = 1

	return tempStr, maxCount, true
end

return M
