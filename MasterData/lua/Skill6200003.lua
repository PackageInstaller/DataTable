-- 每周boss迷之金字塔角色buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6200003 = oo.class(SkillBase)
function Skill6200003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6200003:OnBefourHurt(caster, target, data)
	-- 6200014
	self:tFunc_6200014_6200012(caster, target, data)
	self:tFunc_6200014_6200013(caster, target, data)
end
function Skill6200003:tFunc_6200014_6200013(caster, target, data)
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 8965
	if SkillJudger:IsCallSkill(self, caster, target, false) then
	else
		return
	end
	-- 6200013
	self:AddTempAttr(SkillEffect[6200013], caster, self.card, data, "damage2",1.2)
end
function Skill6200003:tFunc_6200014_6200012(caster, target, data)
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
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 6200012
	self:AddTempAttr(SkillEffect[6200012], caster, self.card, data, "damage2",0.3)
end
