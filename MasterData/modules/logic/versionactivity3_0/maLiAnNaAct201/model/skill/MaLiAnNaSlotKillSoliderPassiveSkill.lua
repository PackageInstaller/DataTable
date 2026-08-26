-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaSlotKillSoliderPassiveSkill.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSlotKillSoliderPassiveSkill", package.seeall)

local MaLiAnNaSlotKillSoliderPassiveSkill = class("MaLiAnNaSlotKillSoliderPassiveSkill", MaLiAnNaSkillBase)

function MaLiAnNaSlotKillSoliderPassiveSkill:init(id, param)
	MaLiAnNaSlotKillSoliderPassiveSkill.super.init(self, id, nil)

	self._skillType = Activity201MaLiAnNaEnum.SkillType.passive
	self._effect = param
end

function MaLiAnNaSlotKillSoliderPassiveSkill:_initCdTime()
	self._cdTime = self._effect[3]
end

function MaLiAnNaSlotKillSoliderPassiveSkill:update(time)
	local state = MaLiAnNaSlotKillSoliderPassiveSkill.super.update(self, time)

	if state then
		self:execute()
		self:_initCdTime()
	end
end

function MaLiAnNaSlotKillSoliderPassiveSkill:setParams(x, y, camp)
	if self._params == nil then
		self._params = {}
	end

	table.insert(self._params, x)
	table.insert(self._params, y)
	table.insert(self._params, camp)
end

function MaLiAnNaSlotKillSoliderPassiveSkill:execute()
	Activity201MaLiAnNaGameController.instance:addAction(self:getEffect(), self._params)
end

return MaLiAnNaSlotKillSoliderPassiveSkill
