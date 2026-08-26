-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitRemoveFloor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitRemoveFloor", package.seeall)

local ArcadeSkillHitRemoveFloor = class("ArcadeSkillHitRemoveFloor", ArcadeSkillHitBase)

function ArcadeSkillHitRemoveFloor:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._removeFloorId = tonumber(params[2])
end

function ArcadeSkillHitRemoveFloor:onHit()
	if not self._removeFloorId then
		return
	end

	local removeUidList = {}
	local floorEntityType = ArcadeGameEnum.EntityType.Floor
	local floorMOList = ArcadeGameModel.instance:getEntityMOList(floorEntityType)

	if floorMOList then
		for _, floorMO in ipairs(floorMOList) do
			local id = floorMO:getId()

			if id == self._removeFloorId then
				removeUidList[#removeUidList + 1] = floorMO:getUid()
			end
		end
	end

	for _, floorUid in ipairs(removeUidList) do
		ArcadeGameController.instance:removeEntity(floorEntityType, floorUid)
	end

	if self._context then
		self:addHiter(self._context)
	end
end

function ArcadeSkillHitRemoveFloor:onHitPrintLog()
	logNormal(string.format("%s ==> 移除特定id的地块:[%s]", self:getLogPrefixStr(), self._removeFloorId))
end

return ArcadeSkillHitRemoveFloor
