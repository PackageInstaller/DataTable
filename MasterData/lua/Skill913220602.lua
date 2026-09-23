-- 刃 天使被动技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913220602 = oo.class(SkillBase)
function Skill913220602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 拉条时
function Skill913220602:OnAddProgress(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 913220603
	self:CallSkill(SkillEffect[913220603], caster, target, data, 913220201)
end
