-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/model/WuErLiXiMapRayMo.lua

module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapRayMo", package.seeall)

local WuErLiXiMapRayMo = pureTable("WuErLiXiMapRayMo")

function WuErLiXiMapRayMo:ctor()
	self.rayId = 0
	self.rayParent = 0
	self.rayDir = 0
	self.rayType = WuErLiXiEnum.RayType.NormalSignal
	self.rayTime = ServerTime.now()
end

function WuErLiXiMapRayMo:init(rayId, rayType, rayDir, rayParent)
	self.rayId = rayId
	self.rayType = rayType
	self.rayDir = rayDir
	self.rayParent = rayParent
	self.rayTime = ServerTime.now()
end

function WuErLiXiMapRayMo:reset(rayId, rayType, rayDir, rayParent)
	if self.rayId ~= rayId or self.rayType ~= rayType then
		self.rayTime = ServerTime.now()
	end

	self.rayId = rayId
	self.rayType = rayType
	self.rayDir = rayDir
	self.rayParent = rayParent
end

function WuErLiXiMapRayMo:setId(rayId)
	self.rayId = rayId
end

function WuErLiXiMapRayMo:setType(type)
	self.rayType = type
end

function WuErLiXiMapRayMo:setRayDir(rayDir)
	self.rayDir = rayDir
end

function WuErLiXiMapRayMo:setRayParent(rayParent)
	self.rayParent = rayParent
end

return WuErLiXiMapRayMo
