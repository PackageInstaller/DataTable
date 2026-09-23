-- 弱点洞悉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305401 = oo.class(SkillBase)
function Skill305401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305401:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305401
	if self:Rand(1000) then
		self:AddBuff(SkillEffect[305401], caster, self.card, data, 4304,1)
	end
end
