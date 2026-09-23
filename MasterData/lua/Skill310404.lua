-- 天赋效果310404
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310404 = oo.class(SkillBase)
function Skill310404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310404:OnActionBegin(caster, target, data)
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
	-- 8209
	if SkillJudger:IsCtrlType(self, caster, target, true,6) then
	else
		return
	end
	-- 310404
	self:AddBuff(SkillEffect[310404], caster, self.card, data, 4505)
end
-- 行动结束
function Skill310404:OnActionOver(caster, target, data)
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
	-- 8209
	if SkillJudger:IsCtrlType(self, caster, target, true,6) then
	else
		return
	end
	-- 310414
	self:DelBuff(SkillEffect[310414], caster, self.card, data, 4505,1)
end
