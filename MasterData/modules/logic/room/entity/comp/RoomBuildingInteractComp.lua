-- chunkname: @modules/logic/room/entity/comp/RoomBuildingInteractComp.lua

module("modules.logic.room.entity.comp.RoomBuildingInteractComp", package.seeall)

local RoomBuildingInteractComp = class("RoomBuildingInteractComp", RoomBaseEffectKeyComp)

function RoomBuildingInteractComp:ctor(entity)
	RoomBuildingInteractComp.super.ctor(self, entity)

	self.entity = entity
end

function RoomBuildingInteractComp:init(go)
	self.go = go
end

function RoomBuildingInteractComp:addEventListeners()
	return
end

function RoomBuildingInteractComp:removeEventListeners()
	return
end

function RoomBuildingInteractComp:beforeDestroy()
	self:removeEventListeners()
end

function RoomBuildingInteractComp:onRebuildEffectGO()
	return
end

function RoomBuildingInteractComp:onReturnEffectGO()
	return
end

function RoomBuildingInteractComp:startInteract()
	local buildingMO = self.entity:getMO()

	if not buildingMO then
		return
	end

	local interactMO = buildingMO:getInteractMO()

	if not interactMO then
		return
	end

	local heroIdList = interactMO:getHeroIdList()
	local roomScene = RoomCameraController.instance:getRoomScene()

	if not roomScene then
		return
	end

	for siteId, heroId in ipairs(heroIdList) do
		local characterEntity = roomScene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

		if characterEntity and characterEntity.interactActionComp then
			characterEntity.interactActionComp:startInteract(buildingMO.buildingUid, siteId, interactMO.config.showTime * 0.001)
		end
	end

	if interactMO.config and not string.nilorempty(interactMO.config.buildingAnim) then
		self.entity:playAnimator(interactMO.config.buildingAnim)
	end
end

function RoomBuildingInteractComp:getPointGOByName(name)
	local goList = self.entity.effect:getGameObjectsByName(self._effectKey, name)

	if goList and #goList > 0 then
		return goList[1]
	end
end

function RoomBuildingInteractComp:getPointGOTrsByName(name)
	local trsList = self.entity.effect:getGameObjectsTrsByName(self._effectKey, name)

	if trsList and #trsList > 0 then
		return trsList[1]
	end
end

return RoomBuildingInteractComp
