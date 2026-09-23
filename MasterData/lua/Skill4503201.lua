-- 哈托利
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503201 = oo.class(SkillBase)
function Skill4503201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4503201:OnBefourHurt(caster, target, data)
	-- 4503201
	self:tFunc_4503201_4503211(caster, target, data)
	self:tFunc_4503201_4503221(caster, target, data)
end
function Skill4503201:tFunc_4503201_4503221(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8478
	local count78 = SkillApi:DeathCount(self, caster, target,3)
	-- 4503221
	self:AddTempAttr(SkillEffect[4503221], caster, self.card, data, "damage",count78*0.04)
end
function Skill4503201:tFunc_4503201_4503211(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 4503211
	self:AddTempAttr(SkillEffect[4503211], caster, self.card, data, "bedamage",-(count76-1)*0.02)
end
