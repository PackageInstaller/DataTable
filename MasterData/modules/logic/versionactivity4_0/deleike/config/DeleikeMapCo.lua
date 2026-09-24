-- chunkname: @modules/logic/versionactivity4_0/deleike/config/DeleikeMapCo.lua

module("modules.logic.versionactivity4_0.deleike.config.DeleikeMapCo", package.seeall)

local DeleikeMapCo = pureTable("DeleikeMapCo")

function DeleikeMapCo:init(data)
	self.id = data.id
	self.spawn = data.spawn
	self.endpoint = data.endpoint
	self.triggers = data.endpoints or {}
	self.walls = data.walls or {}

	table.sort(self.walls, function(a, b)
		return a.y < b.y
	end)
end

return DeleikeMapCo
