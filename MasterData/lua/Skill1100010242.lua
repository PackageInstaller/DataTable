-- 每减少10%HP，受治疗效果提升6%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010242 = oo.class(SkillBase)
function Skill1100010242:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010242:OnAfterHurt(caster, target, data)
	-- 8344
	local sign4 = SkillApi:GetValue(self, caster, self.card,3,"sign4")
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010242
	self:AddBuff(SkillEffect[1100010242], caster, self.card, data, 1100010242)
end
-- 治疗时
function Skill1100010242:OnCure(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 11000102420
	self:AddBuff(SkillEffect[11000102420], caster, self.card, data, 1100010242)
end
