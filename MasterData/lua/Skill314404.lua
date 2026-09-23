-- 催化效能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314404 = oo.class(SkillBase)
function Skill314404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill314404:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 314404
	self:AddBuff(SkillEffect[314404], caster, self.card, data, 3304)
end
