-- 缇尔锋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334601 = oo.class(SkillBase)
function Skill334601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334601:OnBefourHurt(caster, target, data)
	-- 334621
	self:tFunc_334621_334601(caster, target, data)
	self:tFunc_334621_334611(caster, target, data)
end
function Skill334601:tFunc_334621_334601(caster, target, data)
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
	-- 334601
	self:AddTempAttr(SkillEffect[334601], caster, target, data, "defense",-40)
end
function Skill334601:tFunc_334621_334611(caster, target, data)
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
	-- 334611
	self:AddTempAttr(SkillEffect[334611], caster, target, data, "bedamage",0.2)
end
