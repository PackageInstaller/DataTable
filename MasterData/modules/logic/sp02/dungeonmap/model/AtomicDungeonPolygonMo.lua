-- chunkname: @modules/logic/sp02/dungeonmap/model/AtomicDungeonPolygonMo.lua

module("modules.logic.sp02.dungeonmap.model.AtomicDungeonPolygonMo", package.seeall)

local AtomicDungeonPolygonMo = pureTable("AtomicDungeonPolygonMo")

function AtomicDungeonPolygonMo:init(id)
	self.id = id
	self.config = AtomicDungeonConfig.instance:getPolygonConfig(id)
end

function AtomicDungeonPolygonMo:updateInfo(info)
	self.id = info.id
	self.unlockDiffList = {}
	self.passDiffList = {}

	for _, unlockDiff in ipairs(info.unlockDifs) do
		table.insert(self.unlockDiffList, unlockDiff)
	end

	for _, passDiff in ipairs(info.passDifs) do
		table.insert(self.passDiffList, passDiff)
	end
end

function AtomicDungeonPolygonMo:getCurPassDiff()
	return self.passDiffList[#self.passDiffList] or 0
end

function AtomicDungeonPolygonMo:getCurUnlockDiff()
	return self.unlockDiffList[#self.unlockDiffList] or 1
end

return AtomicDungeonPolygonMo
