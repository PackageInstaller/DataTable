-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ClubBoss.lua

ClubBashenResetOpenNum = class("ClubBashenResetOpenNum", DebugViewTemplate, _M)

function ClubBashenResetOpenNum:initialize()
	self._opType = 285
	self._viewConfig = {}
end

ClubBashenResetReopenNum = class("ClubBashenResetReopenNum", DebugViewTemplate, _M)

function ClubBashenResetReopenNum:initialize()
	self._opType = 286
	self._viewConfig = {}
end

ClubBashenResetState = class("ClubBashenResetState", DebugViewTemplate, _M)

function ClubBashenResetState:initialize()
	self._opType = 287
	self._viewConfig = {}
end

ClubBashenRankData = class("ClubBashenRankData", DebugViewTemplate, _M)

function ClubBashenRankData:initialize()
	self._opType = 459
	self._viewConfig = {
		{
			default = "100",
			name = "count",
			title = "数量",
			type = "Input"
		},
		{
			default = "50",
			name = "rankType",
			title = "排行类型",
			type = "Input"
		},
		{
			default = "2",
			name = "subId",
			title = "社团id",
			type = "Input"
		},
		{
			default = "10000",
			name = "max",
			title = "最高分",
			type = "Input"
		},
		{
			default = "1",
			name = "min",
			title = "最低分",
			type = "Input"
		}
	}
end

AddClubBossTimes = class("AddClubBossTimes", DebugViewTemplate, _M)

function AddClubBossTimes:initialize()
	self._opType = 211
	self._viewConfig = {
		{
			title = "增加boss挑战100次",
			name = "",
			type = "Label"
		},
		{
			default = 0,
			name = "useAcitity",
			title = "夏活Boss,是1,否0",
			type = "Input"
		}
	}
end

function AddClubBossTimes:onClick(data)
	local param = {}

	param.type = data.type
	param.actId = ""

	if data.useAcitity == "1" then
		local ClubSystem = self:getInjector():getInstance("ClubSystem")

		param.actId = ClubSystem:getClubBossSummerActivityID()
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(param, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

ClearClubBossTiredHeros = class("ClearClubBossTiredHeros", DebugViewTemplate, _M)

function ClearClubBossTiredHeros:initialize()
	self._opType = 213
	self._viewConfig = {
		{
			title = "清空单日疲劳英雄",
			name = "",
			type = "Label"
		},
		{
			default = 0,
			name = "useAcitity",
			title = "夏活Boss,是1,否0",
			type = "Input"
		}
	}
end

function ClearClubBossTiredHeros:onClick(data)
	local param = {}

	param.type = data.type
	param.actId = ""

	if data.useAcitity == "1" then
		local ClubSystem = self:getInjector():getInstance("ClubSystem")

		param.actId = ClubSystem:getClubBossSummerActivityID()
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(param, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

PassClubBoss = class("PassClubBoss", DebugViewTemplate, _M)

function PassClubBoss:initialize()
	self._opType = 212
	self._viewConfig = {
		{
			default = 100,
			name = "toNum",
			title = "通关到X层",
			type = "Input"
		},
		{
			default = 0,
			name = "useAcitity",
			title = "夏活Boss,是1,否0",
			type = "Input"
		}
	}
end

function PassClubBoss:onClick(data)
	local param = {}

	param.type = data.type
	param.toNum = data.toNum
	param.actId = ""

	if data.useAcitity == "1" then
		local ClubSystem = self:getInjector():getInstance("ClubSystem")

		param.actId = ClubSystem:getClubBossSummerActivityID()
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(param, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

ClubResourcesBattleStart = class("ClubResourcesBattleStart", DebugViewTemplate, _M)

function ClubResourcesBattleStart:initialize()
	self._opType = 401
	self._viewConfig = {
		{
			default = "",
			name = "code",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "选择社团打榜活动",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				if not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("HitCharts")

					if string.len(selectStr) > 0 and dataTable then
						local datas = dataTable.table:getRowsByConditionStr(" where Id like \"%" .. selectStr .. "%\";")

						for k, v in pairs(datas) do
							table.insert(ret, v[1])
						end
					elseif dataTable then
						local datas = dataTable.table:getRowsByConditionStr(" limit 50;")

						for k, v in pairs(datas) do
							table.insert(ret, v[1])
						end
					end
				end

				return ret
			end
		}
	}
end

StartClubBoss = class("StartClubBoss", DebugViewTemplate, _M)

function StartClubBoss:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "Point",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "选择关卡",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				if not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("ClubBlockPoint")

					if string.len(selectStr) > 0 and dataTable then
						local datas = dataTable.table:getRowsByConditionStr(" where Id like \"%" .. selectStr .. "%\";")

						for k, v in pairs(datas) do
							table.insert(ret, v[1])
						end
					elseif dataTable then
						local datas = dataTable.table:getRowsByConditionStr(" limit 50;")

						for k, v in pairs(datas) do
							table.insert(ret, v[1])
						end
					end
				end

				return ret
			end
		},
		{
			default = "",
			name = "Hero",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "选择英魂",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				if not GameConfigs.useLuaCfg then
					local dataTable = DataReader:getDBTable("HeroBase")

					if string.len(selectStr) > 0 and dataTable then
						local datas = dataTable.table:getRowsByConditionStr(" where Id like \"%" .. selectStr .. "%\";")

						for k, v in pairs(datas) do
							table.insert(ret, v[1])
						end
					elseif dataTable then
						local datas = dataTable.table:getRowsByConditionStr(" limit 50;")

						for k, v in pairs(datas) do
							table.insert(ret, v[1])
						end
					end
				end

				return ret
			end
		}
	}
end

function StartClubBoss:onClick(data)
	local Point = data.Point
	local id = data.Hero

	dump({
		Point,
		id
	}, "StartClubBoss:onClick")

	if Point and id then
		local ClubSystem = self:getInjector():getInstance("ClubSystem")
		local params = {
			maseterId = "Master_XueZhan",
			pointId = Point,
			heros = {
				id
			}
		}

		ClubSystem:requestStartOpenBoss(function()
			ClubSystem:requestStartBossBattle(params, function(data)
				ClubSystem:enterBattle(data)
			end)
		end)
	end
end
