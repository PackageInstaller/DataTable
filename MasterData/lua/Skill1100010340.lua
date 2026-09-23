-- 山脉攻击后每段伤害叠加山脉标记，下个不同阵营角色引爆基于防御力的真实伤害，每段攻击开局全体防御下降每有一个山脉角色下降12%防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010340 = oo.class(SkillBase)
function Skill1100010340:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010340:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010341
	self:OwnerAddBuffCount(SkillEffect[1100010341], caster, target, data, 1100010340,1,10)
end
-- 伤害前
function Skill1100010340:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8230
	if SkillJudger:IsCasterMech(self, caster, self.card, false,1) then
	else
		return
	end
	-- 1100010344
	self:OwnerAddBuffCount(SkillEffect[1100010344], caster, target, data, 1100010340,-1,10)
end
-- 入场时
function Skill1100010340:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010360
	self:AddBuff(SkillEffect[1100010360], caster, caster, data, 1100010360)
end
