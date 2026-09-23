-- 破坏欲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400504 = oo.class(SkillBase)
function Skill4400504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4400504:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400504
	if self:Rand(4500) then
		self:AddBuff(SkillEffect[4400504], caster, self.card, data, 4306,1)
	end
end
