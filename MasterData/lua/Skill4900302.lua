-- 装甲武装
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900302 = oo.class(SkillBase)
function Skill4900302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900302:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305202
	if self:Rand(2000) then
		self:AddBuff(SkillEffect[305202], caster, self.card, data, 4104,2)
	end
end
