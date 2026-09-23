-- 装甲武装
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900301 = oo.class(SkillBase)
function Skill4900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900301:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305201
	if self:Rand(1000) then
		self:AddBuff(SkillEffect[305201], caster, self.card, data, 4104,2)
	end
end
