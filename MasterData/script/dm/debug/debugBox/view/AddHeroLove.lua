-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddHeroLove.lua

AddHeroLove = class("AddHeroLove", DebugViewTemplate, _M)

function AddHeroLove:initialize()
	self._opType = 260
	self._viewConfig = {
		{
			default = "YFZZhu",
			name = "heroId",
			title = "英魂ID",
			type = "Input"
		},
		{
			default = 0,
			name = "loveLevel",
			title = "好感度等级",
			type = "Input"
		},
		{
			default = 0,
			name = "count",
			title = "好感度经验",
			type = "Input"
		}
	}
end
