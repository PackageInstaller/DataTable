-- 天赋效果307605
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307605 = oo.class(SkillBase)
function Skill307605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307605:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307605
	if self:Rand(6000) then
		self:DelBuff(SkillEffect[307605], caster, self.card, data, 3003,2)
	end
end
