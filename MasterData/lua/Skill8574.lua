-- 狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8574 = oo.class(SkillBase)
function Skill8574:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill8574:OnDeath(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8574
	self:AddProgress(SkillEffect[8574], caster, self.card, data, 600)
	-- 8575
	self:AddBuff(SkillEffect[8575], caster, self.card, data, 4004)
	-- 8576
	self:AddXp(SkillEffect[8576], caster, self.card, data, 1)
end
