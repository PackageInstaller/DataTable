-- chunkname: @modules/logic/versionactivity4_0/deleike/define/DeleikeHelper.lua

module("modules.logic.versionactivity4_0.deleike.define.DeleikeHelper", package.seeall)

local DeleikeHelper = class("DeleikeHelper")

function DeleikeHelper.GetTileName(type, col, row)
	local name = DeleikeEnum.TileTypeToName[type]

	return string.format("%s_%d_%d", name, col, row)
end

function DeleikeHelper.GetSquarePoly(type)
	if type == DeleikeEnum.TileType.Line then
		local w = DeleikeEnum.SkillWidth * 0.5
		local h = DeleikeEnum.SkilllHeight * 0.5

		return {
			Vector2.New(-w, -h),
			Vector2.New(w, -h),
			Vector2.New(w, h),
			Vector2.New(-w, h)
		}
	elseif type == DeleikeEnum.TileType.Bg then
		local w = DeleikeEnum.BgWidth * 0.5
		local h = DeleikeEnum.BgHeight * 0.5

		return {
			Vector2.New(-w, -h),
			Vector2.New(w, -h),
			Vector2.New(w, h),
			Vector2.New(-w, h)
		}
	else
		local w = DeleikeEnum.CubeSize.x * 0.5
		local h = DeleikeEnum.CubeSize.y * 0.5

		return {
			Vector2.New(-w, -h),
			Vector2.New(w, -h),
			Vector2.New(w, h),
			Vector2.New(-w, h)
		}
	end
end

function DeleikeHelper.GridToWorld(x, y)
	local posX = -DeleikeEnum.GridColumn * DeleikeEnum.GridUnit * 0.5 + (x - 1) * DeleikeEnum.GridUnit + DeleikeEnum.GridUnit * 0.5
	local posY = -DeleikeEnum.GridRow * DeleikeEnum.GridUnit * 0.5 + (y - 1) * DeleikeEnum.GridUnit + DeleikeEnum.GridUnit * 0.5

	return Vector2.New(posX, -posY)
end

function DeleikeHelper.getSharedTiles()
	local result = {}
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if unitCoord then
		if not unitCoord.unitList then
			local unitList = {}

			for i = 1, #unitList do
				local comp = unitList[i]

				if comp.mo and comp.go and not gohelper.isNil(comp.go) then
					result[#result + 1] = comp
				end
			end

			return result
		end
	end
end

return DeleikeHelper
