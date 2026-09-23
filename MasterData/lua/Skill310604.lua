-- 天赋效果310604
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310604 = oo.class(SkillBase)
function Skill310604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310604:OnActionBegin(caster, target, data)
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
	-- 8211
	if SkillJudger:IsCtrlType(self, caster, target, true,8) then
	else
		return
	end
	-- 310604
	self:AddBuff(SkillEffect[310604], caster, self.card, data, 4505)
end
-- 行动结束
function Skill310604:OnActionOver(caster, target, data)
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
	-- 8211
	if SkillJudger:IsCtrlType(self, caster, target, true,8) then
	else
		return
	end
	-- 310614
	self:DelBuff(SkillEffect[310614], caster, self.card, data, 4505,1)
end
