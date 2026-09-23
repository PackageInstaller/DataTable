-- 缇尔锋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334603 = oo.class(SkillBase)
function Skill334603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334603:OnBefourHurt(caster, target, data)
	-- 334623
	self:tFunc_334623_334603(caster, target, data)
	self:tFunc_334623_334613(caster, target, data)
end
function Skill334603:tFunc_334623_334613(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 334613
	self:AddTempAttr(SkillEffect[334613], caster, target, data, "bedamage",0.6)
end
function Skill334603:tFunc_334623_334603(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 334603
	self:AddTempAttr(SkillEffect[334603], caster, target, data, "defense",-120)
end
