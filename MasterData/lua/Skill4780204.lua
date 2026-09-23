-- 卡提那·联域
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4780204 = oo.class(SkillBase)
function Skill4780204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4780204:OnActionOver(caster, target, data)
	-- 4780204
	self:tFunc_4780204_4780209(caster, target, data)
	self:tFunc_4780204_4780214(caster, target, data)
end
function Skill4780204:tFunc_4780204_4780209(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 914100302
	if SkillJudger:IsUltimate(self, caster, target, false) then
	else
		return
	end
	-- 4780209
	self:OwnerAddBuff(SkillEffect[4780209], caster, caster, data, 4780204)
end
function Skill4780204:tFunc_4780204_4780214(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4780214
	self:OwnerAddBuff(SkillEffect[4780214], caster, caster, data, 4780209)
end
