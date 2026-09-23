-- 哈托莉4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332205 = oo.class(SkillBase)
function Skill332205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill332205:OnDeath(caster, target, data)
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
	-- 332205
	self:PassiveRevive(SkillEffect[332205], caster, target, data, 2,1,{progress=1002})
	-- 332215
	self:AddBuff(SkillEffect[332215], caster, self.card, data, 4506,2)
	-- 93005
	self:ResetCD(SkillEffect[93005], caster, target, data, 99)
end
