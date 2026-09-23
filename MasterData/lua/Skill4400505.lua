-- 破坏欲
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400505 = oo.class(SkillBase)
function Skill4400505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4400505:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400505
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[4400505], caster, self.card, data, 4306,1)
	end
end
