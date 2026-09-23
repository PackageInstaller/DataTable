-- 耐寒特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910800501 = oo.class(SkillBase)
function Skill910800501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill910800501:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 驱散buff时
function Skill910800501:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 910800502
	self:OwnerAddBuffCount(SkillEffect[910800502], caster, self.card, data, 910800502,1,10)
end
