-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddAllItems.lua

AddAllItems = class("AddAllItems", DebugViewTemplate, _M)

function AddAllItems:initialize()
	self._opType = 113
	self._viewConfig = {
		{
			default = 100,
			name = "count",
			title = "道具数量",
			type = "Input"
		}
	}
end

AddSkin = class("AddSkin", DebugViewTemplate, _M)

function AddSkin:initialize()
	self._opType = 298
	self._viewConfig = {
		{
			default = "Surface_SDTZi_2",
			name = "surfaceId",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "皮肤ID",
			selectHandler = function(selectStr)
				local ret = {}
				local maxRows = 50

				if string.len(selectStr) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("Surface")
					local datas = dataTable.table:getRowsByConditionStr("inner join Translate on Surface.Name_key = Translate.Id where Surface.Id like \"%" .. selectStr .. "%\" or Translate.Zh_CN_key like \"%" .. selectStr .. "%\";")
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
		}
	}
end
