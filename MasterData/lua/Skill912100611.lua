-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100611 = oo.class(SkillBase)
function Skill912100611:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912100611:DoSkill(caster, target, data)
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
	-- 912103021
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912103021], caster, self.card, data, 912102001)
	-- 912102400
	self.order = self.order + 1
	self:SetInvincible(SkillEffect[912102400], caster, target, data, 4,4,99999999,50)
	-- 912102410
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912102410], caster, self.card, data, 912102410)
end
