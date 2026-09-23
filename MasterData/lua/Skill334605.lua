-- 缇尔锋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334605 = oo.class(SkillBase)
function Skill334605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334605:OnBefourHurt(caster, target, data)
	-- 334625
	self:tFunc_334625_334605(caster, target, data)
	self:tFunc_334625_334615(caster, target, data)
end
function Skill334605:tFunc_334625_334615(caster, target, data)
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
	-- 334615
	self:AddTempAttr(SkillEffect[334615], caster, target, data, "bedamage",1)
end
function Skill334605:tFunc_334625_334605(caster, target, data)
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
	-- 334605
	self:AddTempAttr(SkillEffect[334605], caster, target, data, "defense",-200)
end
