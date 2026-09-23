-- 碎盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601401 = oo.class(SkillBase)
function Skill4601401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4601401:OnBefourHurt(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8440
	local count40 = SkillApi:BuffCount(self, caster, target,2,1,14)
	-- 8123
	if SkillJudger:Greater(self, caster, self.card, true,count40,0) then
	else
		return
	end
	-- 4601401
	self:LimitDamage(SkillEffect[4601401], caster, target, data, 0.04,0.48)
	-- 4601406
	self:ShowTips(SkillEffect[4601406], caster, self.card, data, 2,"碎盾",true,4601406)
end
