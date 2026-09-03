-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/OnekeyInvincible.lua

OnekeyInvincible = class("OnekeyInvincible", DebugViewTemplate, _M)

function OnekeyInvincible:initialize()
	self._opType = 131
	self._viewConfig = {
		{
			default = 1,
			name = "count",
			title = "0关闭，1打开",
			type = "Input"
		}
	}
end

function OnekeyInvincible:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end
