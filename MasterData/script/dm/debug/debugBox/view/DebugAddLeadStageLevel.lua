-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DebugAddLeadStageLevel.lua

DebugAddLeadStageLevel = class("DebugAddLeadStageLevel", DebugViewTemplate, _M)

function DebugAddLeadStageLevel:initialize()
	self._opType = 303
	self._viewConfig = {
		{
			default = "Master_XueZhan",
			name = "masterId",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "角色id ",
			selectHandler = function(selectStr)
				local ret = {}
				local maxRows = 50

				if string.len(selectStr) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("MasterBase")
					local datas = dataTable.table:getRowsByConditionStr("inner join Translate on MasterBase.Name_key = Translate.Id where MasterBase.Id like \"%" .. selectStr .. "%\" or Translate.Zh_CN_key like \"%" .. selectStr .. "%\";")
					local translateDataTable = DataReader:getDBTable("Translate")
					local keys = {}

					for k, v in pairs(dataTable.columnNames) do
						table.insert(keys, v)
					end

					for k, v in pairs(translateDataTable.columnNames) do
						table.insert(keys, v)
					end

					local idIdx, nameIdx

					for k, v in pairs(keys) do
						if v == "Id" and idIdx == nil then
							idIdx = k
						elseif v == "Zh_CN" and nameIdx == nil then
							nameIdx = k
						end
					end

					local idx = 1

					for k, v in pairs(datas) do
						table.insert(ret, {
							v[idIdx],
							v[nameIdx]
						})

						if maxRows <= idx then
							break
						end

						idx = idx + 1
					end
				end

				return ret
			end
		},
		{
			default = 1,
			name = "level",
			title = "增加等级",
			type = "Input"
		}
	}
end

DebugAddStageArenaOldCoin = class("DebugAddStageArenaOldCoin", DebugViewTemplate, _M)

function DebugAddStageArenaOldCoin:initialize()
	self._opType = 409
	self._viewConfig = {
		{
			default = 100,
			name = "addCoin",
			title = "增加古币",
			type = "Input"
		}
	}
end

DebugAddStageArenaPower = class("DebugAddStageArenaPower", DebugViewTemplate, _M)

function DebugAddStageArenaPower:initialize()
	self._opType = 410
	self._viewConfig = {
		{
			default = 1,
			name = "addBacchus",
			title = "增加体力",
			type = "Input"
		}
	}
end

DebugAddStageArenaRank = class("DebugAddStageArenaRank", DebugViewTemplate, _M)

function DebugAddStageArenaRank:initialize()
	self._opType = 411
	self._viewConfig = {
		{
			default = 300,
			name = "max",
			title = "古币上限 ",
			type = "Input"
		},
		{
			default = 100,
			name = "min",
			title = "古币下限 ",
			type = "Input"
		},
		{
			default = 20,
			name = "count",
			title = "人数 ",
			type = "Input"
		}
	}
end

DebugClearStageArenaData = class("DebugClearStageArenaData", DebugViewTemplate, _M)

function DebugClearStageArenaData:initialize()
	self._opType = 412
	self._viewConfig = {
		{
			default = 1,
			name = "clearData",
			title = "清除全部赛季数据",
			type = "Input"
		}
	}
end

DebugClearServerGroup = class("DebugClearServerGroup", DebugViewTemplate, _M)

function DebugClearServerGroup:initialize()
	self._opType = 413
	self._viewConfig = {
		{
			default = 1,
			name = "clearServerGroup",
			title = "清除服务器分组",
			type = "Input"
		}
	}
end
