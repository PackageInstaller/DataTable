-- 天赋效果307801
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307801 = oo.class(SkillBase)
function Skill307801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307801:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307801
	if self:Rand(3000) then
		self:DelBufferGroup(SkillEffect[307801], caster, self.card, data, 3,1)
	end
end
