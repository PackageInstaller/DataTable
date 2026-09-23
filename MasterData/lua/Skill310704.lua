-- 天赋效果310704
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310704 = oo.class(SkillBase)
function Skill310704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310704:OnActionBegin(caster, target, data)
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
	-- 310704
	self:AddBuff(SkillEffect[310704], caster, self.card, data, 4505)
end
-- 行动结束
function Skill310704:OnActionOver(caster, target, data)
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
	-- 310714
	self:DelBuff(SkillEffect[310714], caster, self.card, data, 4505,1)
end
