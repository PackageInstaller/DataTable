-- 缇尔锋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334602 = oo.class(SkillBase)
function Skill334602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334602:OnBefourHurt(caster, target, data)
	-- 334622
	self:tFunc_334622_334602(caster, target, data)
	self:tFunc_334622_334612(caster, target, data)
end
function Skill334602:tFunc_334622_334612(caster, target, data)
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
	-- 334612
	self:AddTempAttr(SkillEffect[334612], caster, target, data, "bedamage",0.4)
end
function Skill334602:tFunc_334622_334602(caster, target, data)
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
	-- 334602
	self:AddTempAttr(SkillEffect[334602], caster, target, data, "defense",-80)
end
