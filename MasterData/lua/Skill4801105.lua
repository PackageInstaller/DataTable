-- 缴获
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4801105 = oo.class(SkillBase)
function Skill4801105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill4801105:OnDeath(caster, target, data)
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
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8104
	if SkillJudger:Greater(self, caster, self.card, true,count18,99) then
	else
		return
	end
	-- 4800901
	self:ExtraRound(SkillEffect[4800901], caster, self.card, data, nil)
end
