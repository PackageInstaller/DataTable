-- chunkname: @modules/logic/versionactivity4_0/deleike/model/DeleikeTileMo.lua

module("modules.logic.versionactivity4_0.deleike.model.DeleikeTileMo", package.seeall)

local DeleikeTileMo = pureTable("DeleikeTileMo")

function DeleikeTileMo:init(type, x, y, pos, rotation, polygon, rect)
	self.tileType = type
	self.x = x
	self.y = y
	self.pos = {
		x = pos.x,
		y = pos.y
	}
	self.rotation = rotation or 0

	local rad = math.rad(self.rotation)

	self.cosR = math.cos(rad)
	self.sinR = math.sin(rad)
	self.polygon = polygon or DeleikeHelper.GetSquarePoly(type)

	if rect then
		self.rect = rect
	else
		local minX, minY, maxX, maxY = DeleikeMeshHelper.GetPolygonBounds(self.polygon)

		self.rect = {
			w = maxX - minX,
			h = maxY - minY,
			cx = (minX + maxX) * 0.5,
			cy = (minY + maxY) * 0.5
		}
	end
end

return DeleikeTileMo
