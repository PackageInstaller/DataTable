-- chunkname: @modules/logic/versionactivity1_6/dungeon/model/VersionActivity1_6DungeonModel.lua

module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6DungeonModel", package.seeall)

local VersionActivity1_6DungeonModel = class("VersionActivity1_6DungeonModel", BaseModel)

function VersionActivity1_6DungeonModel:onInit()
	self._skillPointNum = 0
end

function VersionActivity1_6DungeonModel:reInit()
	return
end

function VersionActivity1_6DungeonModel:init()
	return
end

VersionActivity1_6DungeonModel.instance = VersionActivity1_6DungeonModel.New()

return VersionActivity1_6DungeonModel
