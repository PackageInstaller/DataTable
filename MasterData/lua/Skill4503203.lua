-- 哈托利
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503203 = oo.class(SkillBase)
function Skill4503203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4503203:OnBefourHurt(caster, target, data)
	-- 4503203
	self:tFunc_4503203_4503212(caster, target, data)
	self:tFunc_4503203_4503222(caster, target, data)
end
function Skill4503203:tFunc_4503203_4503212(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 4503212
	self:AddTempAttr(SkillEffect[4503212], caster, self.card, data, "bedamage",-(count76-1)*0.04)
end
function Skill4503203:tFunc_4503203_4503222(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8478
	local count78 = SkillApi:DeathCount(self, caster, target,3)
	-- 4503222
	self:AddTempAttr(SkillEffect[4503222], caster, self.card, data, "damage",count78*0.08)
end
