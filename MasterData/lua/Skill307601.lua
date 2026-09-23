-- 天赋效果307601
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307601 = oo.class(SkillBase)
function Skill307601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307601:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307601
	if self:Rand(2000) then
		self:DelBuff(SkillEffect[307601], caster, self.card, data, 3003,2)
	end
end
