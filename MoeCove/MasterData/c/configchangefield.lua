--配置表修改部分字段数据
local cfg = {}


--修改配置表 GachaPoolTable
---@param data table 配置表内容
function cfg:change_GachaPoolTable(data)
	for k, v in pairs(data) do
		v.startTime = GV.IsServer and DLuaUtil.ParseConfigTime(v.startTime) or DLuaUtil.ParseConfigTimeClient(v.startTime)
		v.endTime = GV.IsServer and DLuaUtil.ParseConfigTime(v.endTime) or DLuaUtil.ParseConfigTimeClient(v.endTime)
	end
end

--修改配置表 ShopListTable
---@param data table 配置表内容
function cfg:change_ShopListTable(data)
	for k, v in pairs(data) do
		v.shopOpen = GV.IsServer and DLuaUtil.ParseConfigTime(v.shopOpen) or DLuaUtil.ParseConfigTimeClient(v.shopOpen)
		v.shopClose = GV.IsServer and DLuaUtil.ParseConfigTime(v.shopClose) or DLuaUtil.ParseConfigTimeClient(v.shopClose)
	end
end


--修改配置表 ShopMerchandiseTable
---@param data table 配置表内容
function cfg:change_ShopMerchandiseTable(data)
	for k, v in pairs(data) do
		v.merchandiseOpen = GV.IsServer and DLuaUtil.ParseConfigTime(v.merchandiseOpen) or DLuaUtil.ParseConfigTimeClient(v.merchandiseOpen)
		v.merchandiseClose = GV.IsServer and DLuaUtil.ParseConfigTime(v.merchandiseClose) or DLuaUtil.ParseConfigTimeClient(v.merchandiseClose)
	end
end

--修改配置表 GiftTable
---@param data table 配置表内容
function cfg:change_GiftTable(data)
	for k, v in pairs(data) do
		v.TimeoutStart = GV.IsServer and DLuaUtil.ParseConfigTime(v.TimeoutStart) or DLuaUtil.ParseConfigTimeClient(v.TimeoutStart)
		v.timeout = GV.IsServer and DLuaUtil.ParseConfigTime(v.timeout) or DLuaUtil.ParseConfigTimeClient(v.timeout)
	end
end

--修改配置表 ActivityTable
---@param data table 配置表内容
function cfg:change_ActivityTable(data)
	for k, v in pairs(data) do
		v.StartTime = GV.IsServer and DLuaUtil.ParseConfigTime(v.StartTime) or DLuaUtil.ParseConfigTimeClient(v.StartTime)
		v.EndTime = GV.IsServer and DLuaUtil.ParseConfigTime(v.EndTime) or DLuaUtil.ParseConfigTimeClient(v.EndTime)
	end
end

--修改配置表 QuestionnaireTable
---@param data table 配置表内容
function cfg:change_QuestionnaireTable(data)
	for k, v in pairs(data) do
		for _, unlock in pairs(v.unlock) do
			if unlock[1] == GE.CommonLockJudgeType.Time then
				unlock[2] = GV.IsServer and DLuaUtil.ParseConfigTime(unlock[2]) or DLuaUtil.ParseConfigTimeClient(unlock[2])
			end
		end
		for _, endCondition in pairs(v.endCondition) do
			if endCondition[1] == GE.CommonLockJudgeType.Time then
				endCondition[2] = GV.IsServer and DLuaUtil.ParseConfigTime(endCondition[2]) or DLuaUtil.ParseConfigTimeClient(endCondition[2])
			end
		end
	end
end

-------------------------------------------------------
-------------------------------------------------------
--改变配置表字段数据的接口
---@param name string 配置表名称
---@param data table 配置表内容
function cfg:changeFieldData(name, data)
	local func = cfg["change_"..name]
	if not func then
		return
	end

	func(self, data)
end

return cfg