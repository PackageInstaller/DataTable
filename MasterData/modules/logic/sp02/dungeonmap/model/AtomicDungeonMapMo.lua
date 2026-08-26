-- chunkname: @modules/logic/sp02/dungeonmap/model/AtomicDungeonMapMo.lua

module("modules.logic.sp02.dungeonmap.model.AtomicDungeonMapMo", package.seeall)

local AtomicDungeonMapMo = pureTable("AtomicDungeonMapMo")

function AtomicDungeonMapMo:init(id)
	self.id = id
	self.config = AtomicDungeonConfig.instance:getDungeonMapConfig(id)
end

function AtomicDungeonMapMo:updateInfo(info)
	self.id = info.id
	self.exploreValue = info.exploreValue
end

function AtomicDungeonMapMo:getExploreValue()
	return self.exploreValue or 0
end

return AtomicDungeonMapMo
