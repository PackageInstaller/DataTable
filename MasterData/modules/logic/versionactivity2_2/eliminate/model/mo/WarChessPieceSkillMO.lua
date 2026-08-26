-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessPieceSkillMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessPieceSkillMO", package.seeall)

local WarChessPieceSkillMO = class("WarChessPieceSkillMO")

function WarChessPieceSkillMO:init(info)
	self.id = info.id
	self.tag = info.tag
	self.currGrowUpTime = info.currGrowUpTime
	self.growUpTime = info.growUpTime
	self.canGrowUp = info.canGrowUp
end

function WarChessPieceSkillMO:updateSkillGrowUp(growUp)
	self.currGrowUpTime = math.max(self.currGrowUpTime + growUp, 0)
end

function WarChessPieceSkillMO:needShowGrowUp()
	return self.growUpTime ~= 0
end

function WarChessPieceSkillMO:getGrowUpProgress()
	return (self.growUpTime - self.currGrowUpTime) / self.growUpTime
end

return WarChessPieceSkillMO
