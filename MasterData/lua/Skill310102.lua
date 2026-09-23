-- 天赋效果310102
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310102 = oo.class(SkillBase)
function Skill310102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310102:OnActionBegin(caster, target, data)
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
	-- 310102
	self:AddBuff(SkillEffect[310102], caster, self.card, data, 4503)
end
-- 行动结束
function Skill310102:OnActionOver(caster, target, data)
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
	-- 310112
	self:DelBuff(SkillEffect[310112], caster, self.card, data, 4503,1)
end
