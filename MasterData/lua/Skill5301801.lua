-- 刃齿
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5301801 = oo.class(SkillBase)
function Skill5301801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5301801:OnBefourHurt(caster, target, data)
	-- 5301813
	self:tFunc_5301813_5301801(caster, target, data)
	self:tFunc_5301813_5301811(caster, target, data)
end
function Skill5301801:tFunc_5301813_5301811(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8764
	local count764 = SkillApi:GetCount(self, caster, target,3,5301801)
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 8766
	local count766 = SkillApi:SkillLevel(self, caster, target,3,43018)
	-- 5301811
	self:AddTempAttr(SkillEffect[5301811], caster, self.card, data, "damage",0.05*(count766+1)*math.floor(count764/30))
end
function Skill5301801:tFunc_5301813_5301801(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 5301801
	self:AddBuffCount(SkillEffect[5301801], caster, self.card, data, 5301801,1,30)
end
