-- 哈托莉4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332203 = oo.class(SkillBase)
function Skill332203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill332203:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8253
	if SkillJudger:IsLive(self, caster, target, false) then
	else
		return
	end
	-- 332203
	self:PassiveRevive(SkillEffect[332203], caster, target, data, 2,1,{progress=1002})
	-- 332213
	self:AddBuff(SkillEffect[332213], caster, self.card, data, 4504,2)
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
end
