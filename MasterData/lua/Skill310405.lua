-- 天赋效果310405
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310405 = oo.class(SkillBase)
function Skill310405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310405:OnActionBegin(caster, target, data)
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
	-- 310405
	self:AddBuff(SkillEffect[310405], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310405:OnActionOver(caster, target, data)
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
	-- 310415
	self:DelBuff(SkillEffect[310415], caster, self.card, data, 4506,1)
end
