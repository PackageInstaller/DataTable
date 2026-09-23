-- 分解者被动技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914100601 = oo.class(SkillBase)
function Skill914100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill914100601:OnBefourHurt(caster, target, data)
	-- 914100508
	self:tFunc_914100508_914100506(caster, target, data)
	self:tFunc_914100508_914100507(caster, target, data)
end
-- 入场时
function Skill914100601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914100509
	self:AddBuff(SkillEffect[914100509], caster, self.card, data, 914100508)
end
function Skill914100601:tFunc_914100508_914100506(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914100506
	self:AddTempAttr(SkillEffect[914100506], caster, target, data, "bedamage",0.5)
end
function Skill914100601:tFunc_914100508_914100507(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914100507
	self:AddTempAttr(SkillEffect[914100507], caster, target, data, "bedamage",-0.3)
end
