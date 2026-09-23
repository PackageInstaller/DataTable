-- 缇尔锋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334604 = oo.class(SkillBase)
function Skill334604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334604:OnBefourHurt(caster, target, data)
	-- 334624
	self:tFunc_334624_334604(caster, target, data)
	self:tFunc_334624_334614(caster, target, data)
end
function Skill334604:tFunc_334624_334614(caster, target, data)
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
	-- 334614
	self:AddTempAttr(SkillEffect[334614], caster, target, data, "bedamage",0.8)
end
function Skill334604:tFunc_334624_334604(caster, target, data)
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
	-- 334604
	self:AddTempAttr(SkillEffect[334604], caster, target, data, "defense",-160)
end
