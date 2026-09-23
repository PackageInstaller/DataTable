-- 天赋效果310002
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310002 = oo.class(SkillBase)
function Skill310002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310002:OnActionBegin(caster, target, data)
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
	-- 8205
	if SkillJudger:IsCtrlType(self, caster, target, true,2) then
	else
		return
	end
	-- 310002
	self:AddBuff(SkillEffect[310002], caster, self.card, data, 4503)
end
-- 行动结束
function Skill310002:OnActionOver(caster, target, data)
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
	-- 8205
	if SkillJudger:IsCtrlType(self, caster, target, true,2) then
	else
		return
	end
	-- 310012
	self:DelBuff(SkillEffect[310012], caster, self.card, data, 4503,1)
end
