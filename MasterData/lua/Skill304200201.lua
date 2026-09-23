-- 喵之心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304200201 = oo.class(SkillBase)
function Skill304200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill304200201:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 304200221
	self:CallOwnerSkill(SkillEffect[304200221], caster, self.card, data, 304200401)
end
-- 行动结束2
function Skill304200201:OnActionOver2(caster, target, data)
	-- 304200216
	self:tFunc_304200216_304200217(caster, target, data)
	self:tFunc_304200216_304200218(caster, target, data)
end
function Skill304200201:tFunc_304200216_304200217(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8628
	local count628 = SkillApi:BuffCount(self, caster, target,3,4,30420)
	-- 8828
	if SkillJudger:Greater(self, caster, target, true,count628,0) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 304200217
	if self:Rand(5000) then
		self:Help(SkillEffect[304200217], caster, target, data, 2)
	end
end
function Skill304200201:tFunc_304200216_304200218(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 304200218
	self:Help(SkillEffect[304200218], caster, target, data, 2)
end
