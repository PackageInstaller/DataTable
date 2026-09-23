-- 治疗能量
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323801 = oo.class(SkillBase)
function Skill323801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill323801:OnCure(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8466
	local count66 = SkillApi:GetCureHp(self, caster, target,2)
	-- 200700102
	self:AddEnergy(SkillEffect[200700102], caster, self.card, data, count66*0.1,1)
	-- 200700403
	self:AddBuff(SkillEffect[200700403], caster, self.card, data, 200700102)
end
