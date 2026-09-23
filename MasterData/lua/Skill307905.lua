-- 天赋效果307905
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307905 = oo.class(SkillBase)
function Skill307905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307905:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307905
	if self:Rand(9000) then
		self:DelBufferGroup(SkillEffect[307905], caster, self.card, data, 1,1)
	end
end
