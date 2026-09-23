-- 星坠天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329405 = oo.class(SkillBase)
function Skill329405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill329405:OnBefourHurt(caster, target, data)
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
	-- 329405
	self:AddTempAttr(SkillEffect[329405], caster, self.card, data, "damage",0.3)
end
-- 攻击结束
function Skill329405:OnAttackOver(caster, target, data)
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
	-- 329411
	self:OwnerAddBuffCount(SkillEffect[329411], caster, target, data, 4403501,1,5)
end
