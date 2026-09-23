-- 音律跃动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317104 = oo.class(SkillBase)
function Skill317104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill317104:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 317104
	if self:Rand(4000) then
		self:AddProgress(SkillEffect[317104], caster, self.card, data, 200)
	end
end
