-- 防御转化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill9028 = oo.class(SkillBase)
function Skill9028:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill9028:OnBefourHurt(caster, target, data)
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
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 9028
	self:AddTempAttr(SkillEffect[9028], caster, self.card, data, "attack",count23*2.5)
end
