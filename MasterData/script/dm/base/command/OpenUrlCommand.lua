-- chunkname: @/tmp/or_script/lua_compile/dm/base/command/OpenUrlCommand.lua

EVT_OPENURL = "EVT_OPENURL"
OpenUrlCommand = class("OpenUrlCommand", legs.Command)

function OpenUrlCommand:execute(event)
	local data = event:getData()
	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(data.url)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))

		return
	end

	if data.extParams then
		for k, value in pairs(data.extParams) do
			params[k] = value
		end
	end

	entry:response(context, params)
end
