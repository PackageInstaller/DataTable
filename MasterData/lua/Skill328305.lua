-- 巴德兰兹天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328305 = oo.class(SkillBase)
function Skill328305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill328305:OnBefourHurt(caster, target, data)
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
	-- 8411
	local count11 = SkillApi:BuffCount(self, caster, target,1,1,2)
	-- 328305
	self:AddTempAttr(SkillEffect[328305], caster, self.card, data, "damage",count11*0.05)
end
