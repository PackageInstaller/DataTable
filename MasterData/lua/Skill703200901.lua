-- 灾祸破灭
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703200901 = oo.class(SkillBase)
function Skill703200901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703200901:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 攻击结束
function Skill703200901:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 703200901
	self:AddBuff(SkillEffect[703200901], caster, target, data, 703200101)
	-- 703200904
	self:AddBuff(SkillEffect[703200904], caster, target, data, 703200101)
	-- 703200902
	self:AddSp(SkillEffect[703200902], caster, target, data, -100)
	-- 703201101
	self:DelBufferGroup(SkillEffect[703201101], caster, target, data, 2,10)
end
-- 行动结束
function Skill703200901:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 703200903
	self:AddNp(SkillEffect[703200903], caster, target, data, -50)
end
