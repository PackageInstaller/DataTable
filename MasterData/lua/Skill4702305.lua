-- 弹药填装
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4702305 = oo.class(SkillBase)
function Skill4702305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4702305:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4702305
	if self:Rand(5000) then
		self:AddSp(SkillEffect[4702305], caster, self.card, data, 20)
	end
end
