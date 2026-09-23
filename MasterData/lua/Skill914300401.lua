-- 蜘蛛召唤物被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914300401 = oo.class(SkillBase)
function Skill914300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill914300401:OnBorn(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 914300401
	self:AddBuff(SkillEffect[914300401], caster, target, data, 6117)
end
-- 特殊入场时(复活，召唤，合体)
function Skill914300401:OnBornSpecial(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 914300401
	self:AddBuff(SkillEffect[914300401], caster, target, data, 6117)
end
