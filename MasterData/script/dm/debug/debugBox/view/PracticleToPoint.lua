-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/PracticleToPoint.lua

PracticleToPoint = class("PracticleToPoint", DebugViewTemplate, _M)

function PracticleToPoint:initialize()
	self._opType = 241
	self._viewConfig = {
		{
			default = "100",
			name = "mapId",
			title = "地图id",
			type = "Input"
		},
		{
			default = "100",
			name = "pointId",
			title = "关卡id",
			type = "Input"
		}
	}
end
