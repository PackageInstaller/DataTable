-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/FullStarFinishPracticle.lua

FullStarFinishPracticle = class("FullStarFinishPracticle", DebugViewTemplate, _M)

function FullStarFinishPracticle:initialize()
	self._opType = 240
	self._viewConfig = {
		{
			default = 100,
			name = "",
			title = "训练本全部满星通关",
			type = ""
		}
	}
end
