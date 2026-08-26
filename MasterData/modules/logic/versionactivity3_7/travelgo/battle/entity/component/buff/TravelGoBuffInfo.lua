-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/component/buff/TravelGoBuffInfo.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.component.buff.TravelGoBuffInfo", package.seeall)

local TravelGoBuffInfo = class("TravelGoBuffInfo", TravelGoBase)

function TravelGoBuffInfo:ctor(entity, uid, cfgId, skillId)
	TravelGoBuffInfo.super.ctor(self)

	self.entity = entity
	self.uid = uid
	self.cfgId = cfgId
	self.cfg = lua_activity220_buff.configDict[cfgId]
	self.skillId = skillId
	self.lives = self.cfg.lifeParam
end

function TravelGoBuffInfo:onEnable()
	self.entity.attributes:addModifier(self.cfg.type == 1, self.cfg.attriId, self.cfg.param, {
		uid = self.uid,
		buffId = self.cfgId
	})

	if self.cfg.lifeRule == 1 then
		self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnRoundEnd, self.onLivesReduce, self)
	elseif self.cfg.lifeRule == 2 then
		self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnAttack, self.onLivesReduce, self)
	elseif self.cfg.lifeRule == 3 then
		self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnSkillEffect, self.onLivesReduce, self)
	end
end

function TravelGoBuffInfo:onLivesReduce(entity)
	if self.entity.uid ~= entity.uid then
		return
	end

	self.lives = self.lives - 1

	if self.lives <= 0 then
		self.entity.buff:removeBuff(self.uid)
	end
end

function TravelGoBuffInfo:onDisable()
	if self.cfg.lifeRule == -1 and self:isBasicAttr() then
		-- block empty
	else
		self.entity.attributes:removeFlatModifier(self.cfg.type == 0, self.cfg.attriId, self.uid)
	end
end

function TravelGoBuffInfo:isBasicAttr()
	local attr = self.cfg.attriId
	local AttrType = TravelGoBattleEnum.AttrType

	return attr == AttrType.MaxHp or attr == AttrType.Attack or attr == AttrType.Defence
end

return TravelGoBuffInfo
