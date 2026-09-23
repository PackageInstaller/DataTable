-- 驱动推进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900404 = oo.class(SkillBase)
function Skill4900404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900404:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305304
	if self:Rand(2500) then
		self:AddBuff(SkillEffect[305304], caster, self.card, data, 4204)
	end
end
