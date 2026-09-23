-- 天赋效果308401
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308401 = oo.class(SkillBase)
function Skill308401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill308401:OnBefourHurt(caster, target, data)
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
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8110
	if SkillJudger:Greater(self, caster, self.card, true,count27,0) then
	else
		return
	end
	-- 308401
	self:AddTempAttr(SkillEffect[308401], caster, self.card, data, "damage",0.1)
end
