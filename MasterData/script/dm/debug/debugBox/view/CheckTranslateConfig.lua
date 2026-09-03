-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/CheckTranslateConfig.lua

CheckTranslateConfig = class("CheckTranslateConfig", DebugViewTemplate, _M)

function CheckTranslateConfig:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "Translate",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "输入查询的字符串",
			_selectBoxAutoHide = false,
			selectHandler = function(selectStr)
				local ret = {}

				if selectStr and string.len(selectStr) > 0 and not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("Translate")
					local datas = dataTable.table:getRowsByConditionStr("where Id like \"%" .. selectStr .. "%\" or Zh_CN_key like \"%" .. selectStr .. "%\";")

					for k, v in pairs(datas) do
						table.insert(ret, {
							v[1],
							string.gsub(v[2], "\n", "")
						})
					end
				end

				return ret
			end
		}
	}
end

function CheckTranslateConfig:onClick(data)
	dump(data, "CheckTranslateConfig:onClick")

	local text = ConfigReader:getDataByNameIdAndKey("Translate", data.Translate, "Zh_CN")

	if text then
		self:dispatch(ShowTipEvent({
			delay = 4,
			tip = data.Translate .. "对应值为:" .. text
		}))
	else
		self:dispatch(ShowTipEvent({
			delay = 4,
			tip = "没有查找到" .. data.Translate .. "对应的值"
		}))
	end
end
