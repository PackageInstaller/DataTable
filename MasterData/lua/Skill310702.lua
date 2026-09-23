-- 天赋效果310702
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310702 = oo.class(SkillBase)
function Skill310702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310702:OnActionBegin(caster, target, data)
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
	-- 310702
	self:AddBuff(SkillEffect[310702], caster, self.card, data, 4503)
end
-- 行动结束
function Skill310702:OnActionOver(caster, target, data)
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
	-- 310712
	self:DelBuff(SkillEffect[310712], caster, self.card, data, 4503,1)
end
