-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100411 = oo.class(SkillBase)
function Skill912100411:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912100411:DoSkill(caster, target, data)
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
	-- 912103011
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912103011], caster, self.card, data, 912102001)
	-- 912102300
	self.order = self.order + 1
	self:SetInvincible(SkillEffect[912102300], caster, target, data, 4,3,600000,12)
	-- 912102310
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912102310], caster, self.card, data, 912102310)
end
