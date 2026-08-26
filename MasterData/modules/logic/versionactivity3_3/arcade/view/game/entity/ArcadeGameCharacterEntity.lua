-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/entity/ArcadeGameCharacterEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.game.entity.ArcadeGameCharacterEntity", package.seeall)

local ArcadeGameCharacterEntity = class("ArcadeGameCharacterEntity", ArcadeGameBaseEntity)

function ArcadeGameCharacterEntity:refreshDirection()
	local mo = self:getMO()

	if not mo then
		return
	end

	local prefabItem = self:getCurPrefabItem()

	if not prefabItem then
		return
	end

	local transScale = prefabItem.transScale
	local entityDirection = mo:getDirection(true)

	transformhelper.setLocalRotation(transScale, 0, entityDirection == ArcadeEnum.Direction.Right and 180 or 0, 0)
end

return ArcadeGameCharacterEntity
