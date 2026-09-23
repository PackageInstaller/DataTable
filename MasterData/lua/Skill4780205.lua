-- 卡提那·联域
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4780205 = oo.class(SkillBase)
function Skill4780205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4780205:OnActionOver(caster, target, data)
	-- 4780205
	self:tFunc_4780205_4780210(caster, target, data)
	self:tFunc_4780205_4780215(caster, target, data)
end
function Skill4780205:tFunc_4780205_4780215(caster, target, data)
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
	-- 4780215
	self:OwnerAddBuff(SkillEffect[4780215], caster, caster, data, 4780210)
end
function Skill4780205:tFunc_4780205_4780210(caster, target, data)
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
	-- 4780210
	self:OwnerAddBuff(SkillEffect[4780210], caster, caster, data, 4780205)
end
