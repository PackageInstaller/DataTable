-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetLinkColor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetLinkColor", package.seeall)

local ArcadeSkillTargetLinkColor = class("ArcadeSkillTargetLinkColor", ArcadeSkillTargetBase)

function ArcadeSkillTargetLinkColor:onFindTarget()
	if not self.gridX or not self.gridY then
		logError("ArcadeSkillTargetLinkColor:onFindTarget error, gridX or gridY is nil")

		return
	end

	self:_beginFindLinkedMonster(self.gridX, self.gridY)
end

function ArcadeSkillTargetLinkColor:_beginFindLinkedMonster(gridX, gridY)
	local hasCheckGridDict = {}
	local waitCheckMODict = {}
	local targetRace = self:_tryAddLinkedMonster(gridX, gridY, nil, hasCheckGridDict, waitCheckMODict)

	if not targetRace then
		return
	end

	while true do
		local nextUid, nextMO = next(waitCheckMODict)

		if not nextUid then
			break
		end

		waitCheckMODict[nextUid] = nil

		local borderGridList = nextMO:getBorderGridList()

		for _, gridData in ipairs(borderGridList) do
			local borderGridX = gridData.gridX
			local borderGridY = gridData.gridY
			local gridId = ArcadeGameHelper.getGridId(borderGridX, borderGridY)

			if not hasCheckGridDict[gridId] then
				self:_tryAddLinkedMonster(borderGridX, borderGridY, targetRace, hasCheckGridDict, waitCheckMODict)
			end
		end
	end
end

function ArcadeSkillTargetLinkColor:_tryAddLinkedMonster(gridX, gridY, targetRace, refHasCheckGridDict, refWaitCheckMODict)
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if not curRoom then
		return
	end

	local adjEntityData = curRoom:getEntityDataInTargetGrid(gridX, gridY)
	local adjEntityType = adjEntityData and adjEntityData.entityType

	if adjEntityType ~= ArcadeGameEnum.EntityType.Monster then
		return
	end

	local adjUid = adjEntityData.uid
	local adjMO = ArcadeGameModel.instance:getMOWithType(adjEntityType, adjUid)
	local isAlive = adjMO and adjMO:getIsAlive()

	if not isAlive then
		return
	end

	local alreadyHas = self:isHasTarget(adjMO)

	if alreadyHas then
		return
	end

	local ajdId = adjMO:getId()
	local adjRace = ArcadeConfig.instance:getMonsterRace(ajdId)

	if not adjRace or targetRace and adjRace ~= targetRace then
		return
	end

	self:addTarget(adjMO)

	local occupyGridList = curRoom:getEntityOccupyGridList(adjEntityType, adjUid)

	for _, gridId in ipairs(occupyGridList) do
		refHasCheckGridDict[gridId] = true
	end

	refWaitCheckMODict[adjUid] = adjMO

	return adjRace
end

return ArcadeSkillTargetLinkColor
