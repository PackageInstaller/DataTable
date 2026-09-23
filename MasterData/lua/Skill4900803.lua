-- 冰翼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4900803 = oo.class(SkillBase)
function Skill4900803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4900803:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305703
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[305703], caster, self.card, data, 6104,1)
	end
end
