-- chunkname: @modules/logic/versionactivity4_0/deleike/define/DeleikeMeshHelper.lua

module("modules.logic.versionactivity4_0.deleike.define.DeleikeMeshHelper", package.seeall)

local DeleikeMeshHelper = class("DeleikeMeshHelper")

function DeleikeMeshHelper.ApplyToPolygonMesh(meshComp, polygon)
	if not meshComp or gohelper.isNil(meshComp) then
		return
	end

	if polygon then
		if not #polygon then
			local count = 0

			if count < 3 then
				meshComp:ClearPolygon()

				return
			end

			meshComp:SetVertexCount(count)

			for i = 1, count do
				meshComp:SetVertexPosition(i - 1, polygon[i].x, polygon[i].y)
			end

			meshComp:ApplyPolygon()
		end
	end
end

function DeleikeMeshHelper.GetPolygonBounds(polygon)
	local minX, minY = polygon[1].x, polygon[1].y
	local maxX, maxY = minX, minY

	for i = 2, #polygon do
		minX = math.min(minX, polygon[i].x)
		minY = math.min(minY, polygon[i].y)
		maxX = math.max(maxX, polygon[i].x)
		maxY = math.max(maxY, polygon[i].y)
	end

	return minX, minY, maxX, maxY
end

return DeleikeMeshHelper
