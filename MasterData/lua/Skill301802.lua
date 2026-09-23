-- 感知充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301802 = oo.class(SkillBase)
function Skill301802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill301802:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301802
	if self:Rand(3000) then
		self:AddNp(SkillEffect[301802], caster, self.card, data, 10)
	end
end
