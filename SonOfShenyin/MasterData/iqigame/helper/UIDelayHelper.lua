-- chunkname: @IQIGame\\Helper\\UIDelayHelper.lua

local m = {
	ToOpenUIDataListAfterChangeScene = {},
	ToExecFuncListAfterChangeScene = {}
}

function m.OpenUIAfterChangeScene(uiName, uiLayer, userData)
	for i = 1, #m.ToOpenUIDataListAfterChangeScene do
		local data = m.ToOpenUIDataListAfterChangeScene[i]

		if data.uiName == uiName then
			warning("切换场景时打开的UI列表里已经包含：" .. uiName .. "，它将被新的打开指令替换。")
			table.remove(m.ToOpenUIDataListAfterChangeScene, i)

			break
		end
	end

	table.insert(m.ToOpenUIDataListAfterChangeScene, {
		uiName = uiName,
		uiLayer = uiLayer,
		userData = userData
	})
end

function m.CheckAfterChangeScene(isAddScene)
	if #m.ToOpenUIDataListAfterChangeScene > 0 then
		for i = 1, #m.ToOpenUIDataListAfterChangeScene do
			local data = m.ToOpenUIDataListAfterChangeScene[i]

			UIModule.Open(data.uiName, data.uiLayer, data.userData)
		end

		m.ToOpenUIDataListAfterChangeScene = {}
	end

	if #m.ToExecFuncListAfterChangeScene > 0 then
		for i = 1, #m.ToExecFuncListAfterChangeScene do
			m.ToExecFuncListAfterChangeScene[i]()
		end

		m.ToExecFuncListAfterChangeScene = {}
	end
end

function m.ExecFunctionAfterChangeScene(func)
	if table.indexOf(m.ToExecFuncListAfterChangeScene, func) ~= -1 then
		return
	end

	table.insert(m.ToExecFuncListAfterChangeScene, func)
end

UIDelayHelper = m
