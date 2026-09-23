-- 科拉达机神boss技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913910401 = oo.class(SkillBase)
function Skill913910401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913910401:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 攻击结束2
function Skill913910401:OnAttackOver2(caster, target, data)
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
	-- 803600301
	self:LimitDamage(SkillEffect[803600301], caster, target, data, 0.1,8)
end
-- 攻击结束
function Skill913910401:OnAttackOver(caster, target, data)
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
	-- 913910106
	local countKeLaDa = SkillApi:GetCount(self, caster, target,2,913910101)
	-- 913910510
	if SkillJudger:HasBuff(self, caster, target, true,2,913910101) then
	else
		return
	end
	-- 913910104
	self:HitAddBuffCount(SkillEffect[913910104], caster, target, data, 10000,913910101,countKeLaDa,25)
end
