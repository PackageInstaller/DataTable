-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/CooperateBossTest.lua

CooperateBossTrigger = class("CooperateBossTrigger", DebugViewTemplate, _M)

function CooperateBossTrigger:initialize()
	self._opType = 300
	self._viewConfig = {
		{
			default = 50,
			name = "cost",
			title = "cost",
			type = "Input"
		},
		{
			default = "NORMAL",
			name = "pointType",
			title = "pointType",
			type = "Input"
		}
	}
end

AddCopperateBossTime = class("AddCopperateBossTime", DebugViewTemplate, _M)

function AddCopperateBossTime:initialize()
	self._opType = 301
	self._viewConfig = {
		{
			default = 50,
			name = "bossFightTimes",
			title = "bossFightTimes",
			type = "Input"
		}
	}
end

CooperateBossCommand = class("CooperateBossCommand", DebugViewTemplate, _M)

function CooperateBossCommand:initialize()
	self._opType = 300
	self._viewConfig = {
		{
			default = 50,
			name = "cmd",
			title = "cmd",
			type = "Input"
		},
		{
			default = "{}",
			name = "params",
			title = "params",
			type = "Input"
		}
	}
end

function CooperateBossCommand:onClick(data)
	self._opType = data.type
	data.type = data.cmd

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end
