-- 深塔计划怪物buff2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5900002 = oo.class(SkillBase)
function Skill5900002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill5900002:OnActionOver2(caster, target, data)
	-- 5900005
	self:tFunc_5900005_5900002(caster, target, data)
	self:tFunc_5900005_5900003(caster, target, data)
end
-- 攻击结束
function Skill5900002:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 5900004
	self:AddSp(SkillEffect[5900004], caster, self.card, data, 10)
end
function Skill5900002:tFunc_5900005_5900002(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 5900002
	self:AddSp(SkillEffect[5900002], caster, caster, data, 20)
end
function Skill5900002:tFunc_5900005_5900003(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5900003
	self:AddSp(SkillEffect[5900003], caster, caster, data, 20)
end
