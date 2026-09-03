-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/MenuEx.lua

local MenuItem = cc.MenuItem

function MenuItem:onClicked(callback)
	self:registerScriptTapHandler(callback)

	return self
end
