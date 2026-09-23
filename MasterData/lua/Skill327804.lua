-- 格恩达尔天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327804 = oo.class(SkillBase)
function Skill327804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill327804:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 327804
	self:AddTempAttr(SkillEffect[327804], caster, self.card, data, "damage",0.16)
end
-- 攻击结束
function Skill327804:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8636
	local count636 = SkillApi:BuffCount(self, caster, target,2,4,23)
	-- 8838
	if SkillJudger:Greater(self, caster, target, true,count636,0) then
	else
		return
	end
	-- 327811
	self:HitAddBuff(SkillEffect[327811], caster, target, data, 5000,3002)
end
