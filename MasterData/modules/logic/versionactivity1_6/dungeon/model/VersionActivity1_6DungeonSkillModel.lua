-- chunkname: @modules/logic/versionactivity1_6/dungeon/model/VersionActivity1_6DungeonSkillModel.lua

module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6DungeonSkillModel", package.seeall)

local VersionActivity1_6DungeonSkillModel = class("VersionActivity1_6DungeonSkillModel", Activity148Model)

function VersionActivity1_6DungeonSkillModel:onInit()
	VersionActivity1_6DungeonSkillModel.super.onInit(self)
end

function VersionActivity1_6DungeonSkillModel:reInit()
	VersionActivity1_6DungeonSkillModel.super.reInit(self)
end

function VersionActivity1_6DungeonSkillModel:init()
	VersionActivity1_6DungeonSkillModel.super.init(self)
end

VersionActivity1_6DungeonSkillModel.instance = VersionActivity1_6DungeonSkillModel.New()

return VersionActivity1_6DungeonSkillModel
