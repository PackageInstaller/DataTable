-- 天赋效果307803
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill307803 = oo.class(SkillBase)
function Skill307803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill307803:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 307803
	if self:Rand(6000) then
		self:DelBufferGroup(SkillEffect[307803], caster, self.card, data, 3,1)
	end
end
