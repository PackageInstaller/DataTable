-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIFindNearestChair.lua

module("logic.extensions.ai.impl.action.AIFindNearestChair", package.seeall)

local M = class("AIFindNearestChair", AINode)
local vec3Temp = Vector3.New()

function M:ctor(context)
	M.super.ctor(self, context)
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	local chairMO = self:_findNearestChair()

	if not chairMO then
		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	local posX, posY, posZ = chairMO:getPosInHouseScene()

	vec3Temp:Set(posX, posY, posZ)
	self:getContext():setTargetPos(vec3Temp, chairMO:getRoomId())
	self:getContext():setUseRandomPos(false)
	self:getContext():setEatFoodChairId(chairMO:getUUId())
	chairMO:setUsed(true)

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

function M:_findNearestChair()
	local unit = self:getContext():getUnit()
	local unitRingType = unit.navMesh:getCurRingType()

	vec3Temp:Set(unit.navMesh:getNavMeshGoPos())

	local furnitures = {}
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.roomMgr then
		local roomUnits = curScene.roomMgr:getUnitsByType(HouseEnum.RoomType.Living)

		for _, roomUnit in ipairs(roomUnits) do
			if not roomUnit.furnitureMgr:_isEdit() then
				local moList = HouseFurnitureModel.instance:getRoomFurnitures(roomUnit.model:getRoomId())

				for _, mo in ipairs(moList) do
					local id = mo:getId()
					local uuid = mo:getUUId()
					local CO = BackpackConfig.instance:getItemInfoByItemId(id)

					if (CO.subType == 201 or CO.subType == 202) and not mo:getUsed() then
						local furnUnit = roomUnit.furnitureMgr:getFurnitureByUUId(uuid)

						if furnUnit then
							local triggers = furnUnit.perform:getFreeTriggers()

							if furnUnit.perform:hasPathToTrigger() and #triggers > 0 then
								table.insert(furnitures, mo)
							end
						else
							table.insert(furnitures, mo)
						end
					end
				end
			end
		end
	end

	table.sort(furnitures, function(moA, moB)
		local idA = moA:getId()
		local idB = moB:getId()
		local roomIdA = moA:getRoomId()
		local roomIdB = moB:getRoomId()
		local aRingType = NavMeshUtil.getRingTypeByZoneId(roomIdA)
		local bRingType = NavMeshUtil.getRingTypeByZoneId(roomIdB)
		local navMOA = HouseNavigationModel.instance:getMOByZoneId(roomIdA)
		local navMOB = HouseNavigationModel.instance:getMOByZoneId(roomIdB)
		local coA = BackpackConfig.instance:getItemInfoByItemId(idA)
		local coB = BackpackConfig.instance:getItemInfoByItemId(idB)
		local ids = HouseConfig.instance:getChairIdsForLunch()
		local idxA = table.indexof(ids, idA)
		local idxB = table.indexof(ids, idB)

		if idxA and not idxB then
			return true
		end

		if not idxA and idxB then
			return false
		end

		if aRingType == unitRingType and bRingType ~= unitRingType then
			return true
		end

		if aRingType ~= unitRingType and bRingType == unitRingType then
			return false
		end

		if roomIdA ~= roomIdB then
			local pointA = navMOA:getPatrolPoints()[1]
			local pointB = navMOB:getPatrolPoints()[1]

			return Vector3.Distance(vec3Temp, pointA) < Vector3.Distance(vec3Temp, pointB)
		end

		if coA.quality ~= coB.quality then
			return coA.quality > coB.quality
		end

		return coA.id > coB.id
	end)

	return furnitures[1]
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M
