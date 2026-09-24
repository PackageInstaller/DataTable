-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/model/SpLilyaSceneBaseMo.lua

module("modules.logic.versionactivity4_0.sp_lilya.model.SpLilyaSceneBaseMo", package.seeall)

local SpLilyaSceneBaseMo = class("SpLilyaSceneBaseMo")

function SpLilyaSceneBaseMo:ctor()
	self:reset()
end

function SpLilyaSceneBaseMo:reset()
	self.posX = 0
	self.posY = 0
	self.rotationZ = 0
	self.uid = 0
	self.radius = 0
end

function SpLilyaSceneBaseMo:setPos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function SpLilyaSceneBaseMo:getPos()
	return self.posX, self.posY
end

function SpLilyaSceneBaseMo:setRotationZ(rotationZ)
	self.rotationZ = rotationZ
end

function SpLilyaSceneBaseMo:getRotationZ()
	return self.rotationZ
end

return SpLilyaSceneBaseMo
