-- 荷载抵压
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4600601 = oo.class(SkillBase)
function Skill4600601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4600601:OnBefourHurt(caster, target, data)
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
	-- 8444
	local count44 = SkillApi:BuffCount(self, caster, target,2,4,3)
	-- 8125
	if SkillJudger:Greater(self, caster, self.card, true,count44,0) then
	else
		return
	end
	-- 4600601
	self:AddTempAttr(SkillEffect[4600601], caster, self.card, data, "damage",0.2)
end
