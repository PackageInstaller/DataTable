-- 应急反应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321403 = oo.class(SkillBase)
function Skill321403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill321403:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 321403
	self:AddBuff(SkillEffect[321403], caster, self.card, data, 321403)
end
