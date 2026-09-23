-- 哈托利
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503205 = oo.class(SkillBase)
function Skill4503205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4503205:OnBefourHurt(caster, target, data)
	-- 4503205
	self:tFunc_4503205_4503213(caster, target, data)
	self:tFunc_4503205_4503223(caster, target, data)
end
function Skill4503205:tFunc_4503205_4503223(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8478
	local count78 = SkillApi:DeathCount(self, caster, target,3)
	-- 4503223
	self:AddTempAttr(SkillEffect[4503223], caster, self.card, data, "damage",count78*0.12)
end
function Skill4503205:tFunc_4503205_4503213(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 4503213
	self:AddTempAttr(SkillEffect[4503213], caster, self.card, data, "bedamage",-(count76-1)*0.06)
end
