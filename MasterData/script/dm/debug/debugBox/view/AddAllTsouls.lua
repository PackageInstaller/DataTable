-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddAllTsouls.lua

AddAllTsouls = class("AddAllTsouls", DebugViewTemplate, _M)

function AddAllTsouls:initialize()
	self._opType = 421
	self._viewConfig = {
		{
			default = 1,
			name = "num",
			title = "道具数量",
			type = "Input"
		}
	}
end

AddCustomTsoul = class("AddCustomTsoul", DebugViewTemplate, _M)

function AddCustomTsoul:initialize()
	self._opType = 422
	self._viewConfig = {
		{
			default = "",
			name = "id",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "选择Id",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}
				local maxRows = 50

				if not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("Tsoul")
					local datas = dataTable.table:getRowsByConditionStr("inner join Translate on Tsoul.Name_key = Translate.Id where Tsoul.Id like \"%" .. selectStr .. "%\" or Translate.Zh_CN_key like \"%" .. selectStr .. "%\";")
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
			default = "",
			name = "Attrs",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "属性展示",
			_selectBoxAutoHide = false,
			selectHandler = function(selectStr)
				if not self._viewConfig[1].mtext then
					local mText = "Gem1001"
					local ret = {}

					if not GameConfigs.useLuaCfg then
						local data = ConfigReader:getRecordById("Tsoul", mText)

						if not data then
							return ret
						end

						for i, v in ipairs(data.Addattr) do
							table.insert(ret, {
								i .. " " .. v,
								getAttrNameByType(v)
							})
						end

						self._Attrs = data.Addattr

						return ret
					end

					return ret
				end
			end
		},
		{
			default = "",
			name = "AttrIndex",
			title = "属性下标",
			type = "Input"
		},
		{
			default = "1",
			name = "num",
			title = "数量",
			type = "Input"
		}
	}
end

function AddCustomTsoul:onClick(data)
	local attrIndex = data.AttrIndex
	local id = data.id
	local config = ConfigReader:getRecordById("Tsoul", id)
	local parts = string.split(attrIndex, ",")

	if #parts > config.Attrnum then
		self:dispatch(ShowTipEvent({
			tip = "属性条数过多"
		}))

		return
	end

	local addAttr = {}

	for i, v in ipairs(parts) do
		addAttr[#addAttr + 1] = self._Attrs[tonumber(v)]
	end

	local param = {}

	param.id = id
	param.addAttr = addAttr
	param.num = data.num
	param.type = 422

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(param, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

AddSuitTsoul = class("AddSuitTsoul", DebugViewTemplate, _M)

function AddSuitTsoul:initialize()
	self._opType = 423
	self._viewConfig = {
		{
			default = "SuitCri_1",
			name = "suitId",
			title = "套装id",
			type = "Input"
		},
		{
			default = 1,
			name = "num",
			title = "套装数量",
			type = "Input"
		}
	}
end
