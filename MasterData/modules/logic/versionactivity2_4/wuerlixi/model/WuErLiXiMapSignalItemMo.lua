-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapSignalItemMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapSignalItemMo", package.seeall)

local WuErLiXiMapSignalItemMo = pureTable("WuErLiXiMapSignalItemMo")

function WuErLiXiMapSignalItemMo:ctor()
	self.rayId = 0
	self.rayDir = 0
	self.rayType = WuErLiXiEnum.RayType.NormalSignal
	self.startNodeMo = {}
	self.endNodeMo = {}
	self.startPos = {}
	self.endPos = {}
end

function WuErLiXiMapSignalItemMo:init(rayId, rayType, rayDir, startNodeMo, endNodeMo)
	self.rayId = rayId
	self.rayType = rayType
	self.rayDir = rayDir
	self.startNodeMo = startNodeMo
	self.endNodeMo = endNodeMo
	self.startPos = {
		startNodeMo.x,
		startNodeMo.y
	}
	self.endPos = {
		endNodeMo.x,
		endNodeMo.y
	}
end

function WuErLiXiMapSignalItemMo:reset(rayId, rayType, rayDir, endNodeMo)
	self.rayId = rayId
	self.rayType = rayType
	self.rayDir = rayDir
	self.endNodeMo = endNodeMo
	self.endPos = {
		endNodeMo.x,
		endNodeMo.y
	}
end

function WuErLiXiMapSignalItemMo:setId(rayId)
	self.rayId = rayId
end

function WuErLiXiMapSignalItemMo:setType(type)
	self.rayType = type
end

function WuErLiXiMapSignalItemMo:setRayDir(rayDir)
	self.rayDir = rayDir
end

function WuErLiXiMapSignalItemMo:resetEndNodeMo(endNodeMo)
	self.endNodeMo = endNodeMo
end

function WuErLiXiMapSignalItemMo:getSignalLength()
	return math.abs(self.startPos[1] + self.startPos[2] - self.endPos[1] - self.endPos[2]) + 1
end

return WuErLiXiMapSignalItemMo
