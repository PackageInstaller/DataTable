-- 坍陨天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330104 = oo.class(SkillBase)
function Skill330104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill330104:OnBefourHurt(caster, target, data)
	-- 330104
	self:tFunc_330104_330114(caster, target, data)
	self:tFunc_330104_330124(caster, target, data)
end
function Skill330104:tFunc_330104_330114(caster, target, data)
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
	-- 330114
	self:AddTempAttr(SkillEffect[330114], caster, self.card, data, "damage",0.25)
end
function Skill330104:tFunc_330104_330124(caster, target, data)
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
	-- 330124
	self:AddTempAttr(SkillEffect[330124], caster, caster, data, "damage",0.25)
end
