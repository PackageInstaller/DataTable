require "class"
---@class ExtraAttributeController
local ExtraAttributeController = class("ExtraAttributeController")

function ExtraAttributeController:ctor(source)
	self._source = source
	self._extraAttribute = {}
	self._extraAttributeOnce = {}
	self._extraAttributeDurationSkill = {}
	self._extraAttributeRound = {}
	self._extraAttributeAction = {}
	self._actionUsed = false
end

function ExtraAttributeController:setExAttrib(attribType, value, periodType)
	if (not periodType) then
		periodType = GE.AttribPeriodType.Forever
	end
	local type = GE.AttribPeriodType[periodType]
	if (type == GE.AttribPeriodType.Once) then
		self:_setOnceExAttrib(attribType, value)
	elseif (type == GE.AttribPeriodType.Skill) then
		self:_setDurationSkillExAttrib(attribType, value)
	elseif (type == GE.AttribPeriodType.Round) then
		self:_setRoundExAttrib(attribType, value)
	elseif (type == GE.AttribPeriodType.Action) then
		self:_setActionExAttrib(attribType, value)
	else
		self:_setExAttrib(attribType, value)
	end
end

function ExtraAttributeController:_setExAttrib(attribType, value)
	self:_setAttrib(self._extraAttribute, attribType, value)
end

function ExtraAttributeController:_setOnceExAttrib(attribType, value)
	self:_setAttrib(self._extraAttributeOnce, attribType, value)
end

function ExtraAttributeController:_setDurationSkillExAttrib(attribType, value)
	self:_setAttrib(self._extraAttributeDurationSkill, attribType, value)
end

function ExtraAttributeController:_setRoundExAttrib(attribType, value)
	self:_setAttrib(self._extraAttributeRound, attribType, value)
end

function ExtraAttributeController:_setActionExAttrib(attribType, value)
	self:_setAttrib(self._extraAttributeAction, attribType, value)
end

function ExtraAttributeController:_setAttrib(attribTb, attribType, value)
	if (attribTb[attribType] and type(value) == "number") then
		attribTb[attribType] = attribTb[attribType] + value
	else
		attribTb[attribType] = value
	end
end

function ExtraAttributeController:getExAttrib(attribType)
	local attr = self._extraAttribute[attribType] or 0
	local onceAttr = self._extraAttributeOnce[attribType] or 0
	local skillAttr = self._extraAttributeDurationSkill[attribType] or 0
	local roundAttr = self._extraAttributeRound[attribType] or 0
	local actionAttr = self._extraAttributeAction[attribType] or 0
	return attr + onceAttr + skillAttr + roundAttr + actionAttr
end

function ExtraAttributeController:checkHasExtraAttribute()
	return next(self._extraAttribute) ~= nil
		or next(self._extraAttributeOnce) ~= nil
		or next(self._extraAttributeDurationSkill) ~= nil
		or next(self._extraAttributeRound) ~= nil
		or next(self._extraAttributeAction) ~= nil
end

function ExtraAttributeController:clearOnceAttribute()
	self._extraAttributeOnce = {}
end

function ExtraAttributeController:clearDurationSkillAttribute()
	self._extraAttributeDurationSkill = {}
end

function ExtraAttributeController:clearRoundAttribute()
	self._extraAttributeRound = {}
end

function ExtraAttributeController:clearActionAttribute()
	if (self._actionUsed) then
		self._extraAttributeAction = {}
		self._actionUsed = false
	end
end

function ExtraAttributeController:setActionUsed()
	self._actionUsed = true
end

return ExtraAttributeController