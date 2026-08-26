-- chunkname: @modules/logic/explore/map/unit/ExploreIce.lua

module("modules.logic.explore.map.unit.ExploreIce", package.seeall)

local ExploreIce = class("ExploreIce", ExploreBaseDisplayUnit)

function ExploreIce:onRoleEnter(nowNode, preNode, unit)
	if unit:isRole() then
		ExploreController.instance:getMap():getHero():setBool(ExploreAnimEnum.RoleAnimKey.IsIce, true)
	end

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UseItem)

	if unit:isRole() and preNode and ExploreModel.instance:isHeroInControl() then
		local nodeKey = ExploreHelper.getKey(self.nodePos)
		local tempNode = ExploreMapModel.instance:getNode(nodeKey)
		local startH = tempNode.height
		local offV = nowNode - preNode
		local map = ExploreController.instance:getMap()
		local nextPos = self.nodePos
		local nextUnitList = map:getUnitByPos(offV + nowNode)
		local nextUnit

		nodeKey = ExploreHelper.getKey(offV + nowNode)
		tempNode = ExploreMapModel.instance:getNode(nodeKey)

		if tempNode and tempNode:isWalkable(startH) then
			for i, v in ipairs(nextUnitList) do
				if v:getUnitType() == ExploreEnum.ItemType.Ice then
					nextUnit = v
					nextPos = nowNode + offV
				end
			end
		end

		while nextUnit do
			local tempPos = offV + nextPos

			nextUnitList = map:getUnitByPos(tempPos)
			nodeKey = ExploreHelper.getKey(tempPos)
			tempNode = ExploreMapModel.instance:getNode(nodeKey)
			nextUnit = nil

			if tempNode and tempNode:isWalkable(startH) then
				for i, v in ipairs(nextUnitList) do
					if v:getUnitType() == ExploreEnum.ItemType.Ice then
						nextUnit = v
						nextPos = offV + nextPos
					end
				end
			end
		end

		local tempPos = offV + nextPos

		nodeKey = ExploreHelper.getKey(tempPos)
		tempNode = ExploreMapModel.instance:getNode(nodeKey)

		if tempNode and tempNode:isWalkable(startH) then
			nextPos = tempPos
		end

		if nextPos ~= self.nodePos then
			ExploreController.instance:dispatchEvent(ExploreEvent.MoveHeroToPos, nextPos, self.onIceMoveEnd, self)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Ice)
			unit:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Glide)
			ExploreRpc.instance:sendExploreMoveRequest(nextPos.x, nextPos.y)
		end
	end
end

function ExploreIce:canTrigger()
	return false
end

function ExploreIce:onRoleStay()
	return
end

function ExploreIce:onRoleLeave(nowNode, preNode, unit)
	if unit:isRole() then
		ExploreController.instance:getMap():getHero():setBool(ExploreAnimEnum.RoleAnimKey.IsIce, false)
	end
end

function ExploreIce:onIceMoveEnd()
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Ice)
end

return ExploreIce
