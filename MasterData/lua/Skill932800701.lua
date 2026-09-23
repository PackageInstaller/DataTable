-- 测试阿曼增伤标记技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill932800701 = oo.class(SkillBase)
function Skill932800701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill932800701:OnAttackOver(caster, target, data)
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
	-- 932800801
	self:AddBuff(SkillEffect[932800801], caster, target, data, 932800803)
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
	-- 932800802
	self:AddBuffCount(SkillEffect[932800802], caster, target, data, 932800802,1,1)
end
-- 攻击结束2
function Skill932800701:OnAttackOver2(caster, target, data)
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
	-- 932800702
	local caman = SkillApi:GetCount(self, caster, target,3,932800701)
	-- 932800703
	if SkillJudger:Equal(self, caster, self.card, true,caman,1) then
	else
		return
	end
	-- 932800803
	self:AddBuffCount(SkillEffect[932800803], caster, caster, data, 932800801,1,10)
end
-- 行动结束
function Skill932800701:OnActionOver(caster, target, data)
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
	-- 932800605
	if self:Rand(5000) then
		self:AddNp(SkillEffect[932800605], caster, target, data, -5)
	end
end
