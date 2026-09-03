-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddEquip.lua

AddEquip = class("AddEquip", DebugViewTemplate, _M)

function AddEquip:initialize()
	self._opType = 271
	self._viewConfig = {
		{
			default = "Weapon_11001",
			name = "equipId",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "装备ID",
			selectHandler = function(selectStr)
				local ret = {}
				local maxRows = 50

				if string.len(selectStr) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("HeroEquipBase")
					local datas = dataTable.table:getRowsByConditionStr("inner join Translate on HeroEquipBase.Name_key = Translate.Id where HeroEquipBase.Id like \"%" .. selectStr .. "%\" or Translate.Zh_CN_key like \"%" .. selectStr .. "%\";")
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
			default = 5,
			name = "amount",
			title = "装备数量",
			type = "Input"
		}
	}
end
