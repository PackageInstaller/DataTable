-- 凌冽兵刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317904 = oo.class(SkillBase)
function Skill317904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill317904:OnActionOver(caster, target, data)
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
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 317904
	self:AddTempAttr(SkillEffect[317904], caster, self.card, data, "damage",0.4)
end
