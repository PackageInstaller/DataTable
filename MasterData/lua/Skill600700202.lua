-- 阵面干涉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill600700202 = oo.class(SkillBase)
function Skill600700202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill600700202:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8250
	if SkillJudger:HasBuff(self, caster, target, true,1,1,1) then
	else
		return
	end
	-- 600700202
	if self:Rand(3500) then
		self:CallSkillEx(SkillEffect[600700202], caster, target, data, 600700401)
	end
end
