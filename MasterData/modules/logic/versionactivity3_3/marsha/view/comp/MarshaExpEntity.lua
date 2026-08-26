-- chunkname: @modules/logic/versionactivity3_3/marsha/view/comp/MarshaExpEntity.lua

module("modules.logic.versionactivity3_3.marsha.view.comp.MarshaExpEntity", package.seeall)

local MarshaExpEntity = class("MarshaExpEntity", MarshaBaseEntity)

function MarshaExpEntity:ctor()
	MarshaExpEntity.super.ctor(self)

	self.shape = MarshaEnum.Shape.Rect
end

function MarshaExpEntity:initData(uid, weight, x, y)
	self:initBase(MarshaEnum.UnitType.Exp, uid)
	self:setWeight(weight)
	self:setPos(x, y)
	self:setImage()
end

function MarshaExpEntity:setImage()
	local index = math.random(5, 7)

	UISpriteSetMgr.instance:setV3a3MarshaSprite(self.image, "icon_" .. index)
end

return MarshaExpEntity
