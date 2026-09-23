-- 天赋效果307904
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307904 = oo.class(SkillBase)
function Skill307904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307904:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307904
	if self:Rand(7500) then
		self:DelBufferGroup(SkillEffect[307904], caster, self.card, data, 1,1)
	end
end
