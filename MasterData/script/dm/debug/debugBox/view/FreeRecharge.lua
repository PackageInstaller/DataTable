-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/FreeRecharge.lua

FreeRecharge = class("FreeRecharge", DebugViewTemplate, _M)

function FreeRecharge:initialize()
	self._opType = 295
	self._viewConfig = {
		{
			default = 0,
			name = "isPay",
			title = "1开启，其它关闭",
			type = "Input"
		}
	}
end

function FreeRecharge:onClick(data)
	print("rechargetype", data.rechargetype)
	dump(data)

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end
