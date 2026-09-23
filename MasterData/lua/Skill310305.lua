-- 天赋效果310305
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310305 = oo.class(SkillBase)
function Skill310305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310305:OnActionBegin(caster, target, data)
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
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 310305
	self:AddBuff(SkillEffect[310305], caster, self.card, data, 4506)
end
-- 行动结束
function Skill310305:OnActionOver(caster, target, data)
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
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 310315
	self:DelBuff(SkillEffect[310315], caster, self.card, data, 4506,1)
end
