-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/TravelGoEntity.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.TravelGoEntity", package.seeall)

local TravelGoEntity = class("TravelGoEntity", TravelGoBase)

function TravelGoEntity:ctor(uid, cfgId, entityType)
	TravelGoEntity.super.ctor(self)

	self.uid = uid
	self.cfgId = cfgId
	self.cfg = lua_activity220_unit.configDict[self.cfgId]
	self.entityType = entityType
	self.attributes = self:addComponentByObject(TravelGoAttributesComp.New(self.entityType, self.cfgId))
	self.tag = self:addComponentByObject(TravelGoTagComp.New())
	self.buff = self:addComponentByObject(TravelGoBuffComp.New())
	self.skill = self:addComponentByObject(TravelGoSkillComp.New())
end

function TravelGoEntity:onAwake()
	return
end

function TravelGoEntity:onEnable()
	self.skill:addSkill(self.cfg.monsterSkill)
end

function TravelGoEntity:setGetAnimTimeFunc(getAnimTimeFunc, context)
	self.getAnimTimeFunc = getAnimTimeFunc
	self.getAnimTimeFuncContext = context
end

function TravelGoEntity:getAnimTime(animName)
	if self.getAnimTimeFunc then
		return self.getAnimTimeFunc(self.getAnimTimeFuncContext, animName)
	end
end

function TravelGoEntity:getAttackAnimTime()
	local attackAnim = self.cfg.atkAnimator

	if string.nilorempty(attackAnim) then
		attackAnim = "skill1"
	end

	local attackAnimTime = self:getAnimTime(attackAnim) or 1

	return attackAnim, attackAnimTime
end

return TravelGoEntity
