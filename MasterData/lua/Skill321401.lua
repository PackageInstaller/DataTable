-- 应急反应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321401 = oo.class(SkillBase)
function Skill321401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill321401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 321401
	self:AddBuff(SkillEffect[321401], caster, self.card, data, 321401)
end
