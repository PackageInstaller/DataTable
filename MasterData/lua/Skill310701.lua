-- 天赋效果310701
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310701 = oo.class(SkillBase)
function Skill310701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310701:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8212
	if SkillJudger:IsCtrlType(self, caster, target, true,9) then
	else
		return
	end
	-- 310701
	self:AddBuff(SkillEffect[310701], caster, self.card, data, 4502)
end
-- 行动结束
function Skill310701:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8212
	if SkillJudger:IsCtrlType(self, caster, target, true,9) then
	else
		return
	end
	-- 310711
	self:DelBuff(SkillEffect[310711], caster, self.card, data, 4502,1)
end
