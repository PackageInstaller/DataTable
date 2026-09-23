-- 坍陨天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330101 = oo.class(SkillBase)
function Skill330101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill330101:OnBefourHurt(caster, target, data)
	-- 330101
	self:tFunc_330101_330111(caster, target, data)
	self:tFunc_330101_330121(caster, target, data)
end
function Skill330101:tFunc_330101_330111(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8656
	local count656 = SkillApi:BuffCount(self, caster, target,2,4,4404001)
	-- 8862
	if SkillJudger:Greater(self, caster, target, true,count656,0) then
	else
		return
	end
	-- 330111
	self:AddTempAttr(SkillEffect[330111], caster, self.card, data, "damage",0.10)
end
function Skill330101:tFunc_330101_330121(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8656
	local count656 = SkillApi:BuffCount(self, caster, target,2,4,4404001)
	-- 8862
	if SkillJudger:Greater(self, caster, target, true,count656,0) then
	else
		return
	end
	-- 330121
	self:AddTempAttr(SkillEffect[330121], caster, caster, data, "damage",0.10)
end
