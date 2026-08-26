-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/TravelGoPlayerEntity.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.TravelGoPlayerEntity", package.seeall)

local TravelGoPlayerEntity = class("TravelGoPlayerEntity", TravelGoBase)

function TravelGoPlayerEntity:ctor(uid)
	TravelGoPlayerEntity.super.ctor(self)

	self.uid = uid
	self.entityType = TravelGoBattleEnum.EntityType.Player
	self.attributes = self:addComponentByObject(TravelGoAttributesComp.New(self.entityType))
	self.tag = self:addComponentByObject(TravelGoTagComp.New())
	self.buff = self:addComponentByObject(TravelGoBuffComp.New())
	self.skill = self:addComponentByObject(TravelGoSkillComp.New())
end

function TravelGoPlayerEntity:onAwake()
	return
end

function TravelGoPlayerEntity:onEnable()
	self.skill:addSkill(TravelGoConst.UltimateSkillId)
	self.skill:addSkill(TravelGoConst.FrozenSkillId)
end

function TravelGoPlayerEntity:setGetAnimTimeFunc(getAnimTimeFunc, context)
	self.getAnimTimeFunc = getAnimTimeFunc
	self.getAnimTimeFuncContext = context
end

function TravelGoPlayerEntity:getAnimTime(animName)
	if self.getAnimTimeFunc then
		return self.getAnimTimeFunc(self.getAnimTimeFuncContext, animName)
	end
end

function TravelGoPlayerEntity:getAttackAnimTime()
	local attackAnim = "skill1"
	local attackAnimTime = self:getAnimTime(attackAnim) or 1

	return attackAnim, attackAnimTime
end

return TravelGoPlayerEntity
