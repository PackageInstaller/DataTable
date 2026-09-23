-- 天赋效果310401
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310401 = oo.class(SkillBase)
function Skill310401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310401:OnActionBegin(caster, target, data)
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
	-- 310401
	self:AddBuff(SkillEffect[310401], caster, self.card, data, 4502)
end
-- 行动结束
function Skill310401:OnActionOver(caster, target, data)
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
	-- 310411
	self:DelBuff(SkillEffect[310411], caster, self.card, data, 4502,1)
end
