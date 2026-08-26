-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadHelper.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadHelper", package.seeall)

local FightPreloadHelper = _M

function FightPreloadHelper.getTimelineRefRes(assetItem, timelineUrl, skinId)
	if gohelper.isNil(assetItem) then
		return
	end

	local resList = {}
	local jsonArr = FightTLHelper.getTLJsonData(assetItem, timelineUrl)

	for i = 1, #jsonArr, 2 do
		local tlType = tonumber(jsonArr[i])
		local paramList = jsonArr[i + 1]

		if tlType == 32 then
			local resName = paramList[2]

			if not string.nilorempty(resName) then
				table.insert(resList, ResUrl.getRoleSpineMatTex(resName))
			end
		elseif tlType == 11 then
			local spineName = FightTLEventCreateSpine.getSkinSpineName(paramList[1], skinId)

			if not string.nilorempty(spineName) then
				if string.sub(spineName, 1, 8) == "roles_3d" then
					table.insert(resList, string.format("%s.prefab", spineName))
				else
					table.insert(resList, ResUrl.getSpineFightPrefab(spineName))
				end
			end
		end
	end

	return resList
end

return FightPreloadHelper
