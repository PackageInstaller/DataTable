-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillHitBase.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillHitBase", package.seeall)

local ArcadeSkillHitBase = class("ArcadeSkillHitBase", ArcadeSkillClass)

function ArcadeSkillHitBase:ctor(params)
	ArcadeSkillHitBase.super.ctor(self)

	self.limit = 0
	self._curLimit = 0
	self.effectId = 0
	self.atkEffectId = 0
	self._params = params
	self._hiterList = {}

	self:tryCallFunc(self.onCtor)
end

function ArcadeSkillHitBase:addHiter(hiter)
	if hiter then
		table.insert(self._hiterList, hiter)
	end
end

function ArcadeSkillHitBase:addHiterList(hiterList)
	tabletool.addValues(self._hiterList, hiterList)
end

function ArcadeSkillHitBase:hit(context)
	self._context = context

	self:clearList(self._hiterList)
	self:tryCallFunc(self.onHitLimitCount)
	self:tryCallFunc(self.onHit)
	self:tryCallFunc(self.onPlayEffect)

	if ArcadeGameEnum.PrintLog or GameResMgr.IsFromEditorDir then
		self:tryCallFunc(self.onHitPrintLog)
	end
end

function ArcadeSkillHitBase:onHitLimitCount()
	self._curLimit = self._curLimit + 1
end

function ArcadeSkillHitBase:onPlayEffect()
	if self.atkEffectId and self.atkEffectId ~= 0 and self.isNotPlayAtkEffct ~= true and self._context and self._context.target then
		ArcadeGameSkillController.instance:playEffectByTarget(self._context.target, self.atkEffectId)
	end

	if self.effectId and self.effectId ~= 0 then
		ArcadeGameSkillController.instance:playEffectByTargetList(self._hiterList, self.effectId)
	end
end

function ArcadeSkillHitBase:isReachMaxLimit()
	if self.limit ~= 0 and self.limit <= self._curLimit then
		return true
	end

	return false
end

function ArcadeSkillHitBase:getCurLimit()
	return self._curLimit
end

function ArcadeSkillHitBase:getLogPrefixStr()
	return string.format("%s:onHit() skillId:%s key:%s ", self.__cname, self:getSkillId(), self._changeName or "nil")
end

function ArcadeSkillHitBase:onCtor()
	return
end

function ArcadeSkillHitBase:onHit()
	return
end

function ArcadeSkillHitBase:onHitPrintLog()
	return
end

return ArcadeSkillHitBase
