-- chunkname: @modules/logic/versionactivity3_3/arcade/model/game/entity/ArcadeGameFloorGridMO.lua

module("modules.logic.versionactivity3_3.arcade.model.game.entity.ArcadeGameFloorGridMO", package.seeall)

local ArcadeGameFloorGridMO = class("ArcadeGameFloorGridMO", ArcadeGameBaseUnitMO)

function ArcadeGameFloorGridMO:ctor(x, y)
	local id = ArcadeGameHelper.getGridId(x, y)

	self._cfg = {
		x = x,
		y = y,
		id = id,
		uid = id,
		entityType = ArcadeGameEnum.EntityType.Grid
	}

	ArcadeGameFloorGridMO.super.ctor(self, self._cfg)
end

function ArcadeGameFloorGridMO:reset()
	self._skillSetMO:reset()
	self._buffSetMO:reset()
	self._baseAttrSetMO:reset()
end

function ArcadeGameFloorGridMO:onCtor()
	return
end

function ArcadeGameFloorGridMO:getCfg()
	return self._cfg
end

function ArcadeGameFloorGridMO:getSize()
	return 1, 1
end

function ArcadeGameFloorGridMO:getRes()
	return nil
end

return ArcadeGameFloorGridMO
