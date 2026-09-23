-- 世界boss词条buff9
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800017 = oo.class(SkillBase)
function Skill5800017:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800017:OnBefourHurt(caster, target, data)
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
	-- 8410
	local count10 = SkillApi:BuffCount(self, caster, target,2,1,3)
	-- 8411
	local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
	-- 5800107
	self:AddTempAttr(SkillEffect[5800107], caster, self.card, data, "damage2",math.min((count11)*0.1,1))
end
