-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DebugViewTemplate.lua

DebugViewTemplate = class("DebugViewTemplate", _G.DisposableObject, _M)

DebugViewTemplate:has("_view", {
	is = "rw"
})
DebugViewTemplate:has("_injector", {
	is = "rw"
})
DebugViewTemplate:has("_viewConfig", {
	is = "rw"
})
DebugViewTemplate:has("_opType", {
	is = "rw"
})
DebugViewTemplate:has("_eventDispatcher", {
	is = "rw"
})

function DebugViewTemplate:initialize()
	self._dynamic = false
end

function DebugViewTemplate:dispatch(event)
	if self:getEventDispatcher() then
		self:getEventDispatcher():dispatchEvent(event)
	end
end

function DebugViewTemplate:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

function DebugViewTemplate:isDynamic()
	return self._dynamic
end
