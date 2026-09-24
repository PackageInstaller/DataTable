-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeTileNormal.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeTileNormal", package.seeall)

local DeleikeTileNormal = class("DeleikeTileNormal", LuaCompBase)
local Vector2 = UnityEngine.Vector2
local UIPolygonImageType = typeof(ZProj.UIPolygonImage)

function DeleikeTileNormal:init(go)
	self.go = go
	self.transform = go.transform
	self.polygonImage = gohelper.onceAddComponent(go, UIPolygonImageType)
	self.goUncut = gohelper.findChild(go, "uncut")
end

function DeleikeTileNormal:setData(mo)
	self.mo = mo

	local rect = mo.rect

	recthelper.setSize(self.transform, rect.w, rect.h)
	transformhelper.setLocalRotation(self.transform, 0, 0, mo.rotation)
	self:setLogicPos(mo.pos.x, mo.pos.y)

	local verts = {}

	for i = 1, #mo.polygon do
		verts[i] = Vector2(mo.polygon[i].x - rect.cx, mo.polygon[i].y - rect.cy)
	end

	DeleikeMeshHelper.ApplyToPolygonMesh(self.polygonImage, verts)
end

function DeleikeTileNormal:getLogicPos()
	return self.mo.pos.x, self.mo.pos.y
end

function DeleikeTileNormal:setLogicPos(x, y)
	self.mo.pos.x = x
	self.mo.pos.y = y

	local rect = self.mo.rect
	local cosR, sinR = self.mo.cosR, self.mo.sinR

	recthelper.setAnchor(self.transform, x + rect.cx * cosR - rect.cy * sinR, y + rect.cx * sinR + rect.cy * cosR)
end

function DeleikeTileNormal:getWorldPolygon()
	local result = {}
	local cosR, sinR = self.mo.cosR, self.mo.sinR
	local px, py = self.mo.pos.x, self.mo.pos.y

	for i = 1, #self.mo.polygon do
		local p = self.mo.polygon[i]

		result[i] = {
			x = px + p.x * cosR - p.y * sinR,
			y = py + p.x * sinR + p.y * cosR
		}
	end

	return result
end

return DeleikeTileNormal
