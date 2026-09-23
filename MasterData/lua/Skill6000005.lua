-- 连锁阵线第一期怪物buff2（针对机神）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000005 = oo.class(SkillBase)
function Skill6000005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill6000005:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 60000051
	self:AddTempAttr(SkillEffect[60000051], caster, self.card, data, "bedamage2",-0.2)
end
