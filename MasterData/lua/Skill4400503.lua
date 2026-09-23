-- 破坏欲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400503 = oo.class(SkillBase)
function Skill4400503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4400503:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400503
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[4400503], caster, self.card, data, 4306,1)
	end
end
