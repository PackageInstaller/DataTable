-- chunkname: @modules/logic/fight/model/datahelper/FightEntityDataHelper.lua

module("modules.logic.fight.model.datahelper.FightEntityDataHelper", package.seeall)

local FightEntityDataHelper = {}
local filterCopyEntityMOKey = {
	class = true
}

function FightEntityDataHelper.isPlayerUid(uid)
	return uid == FightEntityScene.MySideId or uid == FightEntityScene.EnemySideId
end

function FightEntityDataHelper.isNotPlayerUid(uid)
	return uid ~= FightEntityScene.MySideId and uid ~= FightEntityScene.EnemySideId
end

function FightEntityDataHelper.copyEntityMO(entityMO1, entityMO2)
	FightDataUtil.coverData(entityMO1, entityMO2, filterCopyEntityMOKey)
end

function FightEntityDataHelper.sortSubEntityList(item1, item2)
	return item1.position > item2.position
end

return FightEntityDataHelper
