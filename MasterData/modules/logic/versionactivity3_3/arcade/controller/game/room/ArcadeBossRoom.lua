-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/room/ArcadeBossRoom.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.room.ArcadeBossRoom", package.seeall)

local ArcadeBossRoom = class("ArcadeBossRoom", ArcadeNormalRoom)

function ArcadeBossRoom:onCtor()
	return
end

function ArcadeBossRoom:onEnter()
	return
end

function ArcadeBossRoom:onInitEntities()
	local allInitEntityDataList = {}

	self:_fillInitMonsterData(allInitEntityDataList)
	self:_fillAllMonsterGroupData(allInitEntityDataList)
	ArcadeGameController.instance:tryAddEntityList(allInitEntityDataList, true, true, self._initEntitiesFinished, self)
end

function ArcadeBossRoom:removeEntityOccupyGrids(entityMO)
	ArcadeBossRoom.super.removeEntityOccupyGrids(self, entityMO)

	local entityType = entityMO and entityMO:getEntityType()

	if entityType == ArcadeGameEnum.EntityType.Monster then
		local monsterId = entityMO:getId()
		local curHP = entityMO:getHp()
		local isDead = curHP <= 0
		local alreadyDead = entityMO:getIsDead()
		local race = ArcadeConfig.instance:getMonsterRace(monsterId)

		if race == ArcadeGameEnum.MonsterRace.Boss and (isDead or alreadyDead) then
			local gridX, gridY = entityMO:getGridPos()

			self:_onDefeatBoss(gridX, gridY)
		end
	end
end

function ArcadeBossRoom:_onDefeatBoss(bossGridX, bossGridY)
	local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()

	if portalIdList and #portalIdList > 0 then
		local portalDataList = {}

		for i, portalId in ipairs(portalIdList) do
			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(portalId)

			portalDataList[#portalDataList + 1] = {
				entityType = ArcadeGameEnum.EntityType.Portal,
				id = portalId,
				x = bossGridX + (i - 1),
				y = bossGridY,
				sizeX = sizeX,
				sizeY = sizeY
			}
		end

		ArcadeGameController.instance:tryAddEntityList(portalDataList, true)
	else
		ArcadeGameModel.instance:addPassLevelCount()
		ArcadeGameHelper.addSettleRewardCount(true)
		ArcadeGameController.instance:endGame(ArcadeGameEnum.SettleType.Win, true)
	end
end

function ArcadeBossRoom:onExit()
	return
end

function ArcadeBossRoom:onClear()
	return
end

return ArcadeBossRoom
