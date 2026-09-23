-- 天赋效果310705
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310705 = oo.class(SkillBase)
function Skill310705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310705:OnActionBegin(caster, target, data)
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
	-- 310705
	self:AddBuff(SkillEffect[310705], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310705:OnActionOver(caster, target, data)
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
	-- 310715
	self:DelBuff(SkillEffect[310715], caster, self.card, data, 4506,1)
end
