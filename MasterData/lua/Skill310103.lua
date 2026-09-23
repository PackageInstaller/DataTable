-- 天赋效果310103
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310103 = oo.class(SkillBase)
function Skill310103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310103:OnActionBegin(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 310103
	self:AddBuff(SkillEffect[310103], caster, self.card, data, 4504)
end
-- 行动结束
function Skill310103:OnActionOver(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 310113
	self:DelBuff(SkillEffect[310113], caster, self.card, data, 4504,1)
end
