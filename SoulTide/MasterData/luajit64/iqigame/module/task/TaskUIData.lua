-- chunkname: @IQIGame\\Module\\Task\\TaskUIData.lua

local m = {
	TargetNum = 0,
	CurrentNum = 0,
	CreateTime = 0,
	TaskStatus = 0,
	cid = 0
}

function m.New(cid, currentNum, targetNum, taskStatus, createTime)
	local obj = Clone(m)

	obj.cid = cid
	obj.CurrentNum = currentNum
	obj.TargetNum = targetNum
	obj.TaskStatus = taskStatus
	obj.CreateTime = createTime

	return obj
end

return m
