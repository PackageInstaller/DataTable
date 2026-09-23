-- 触手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911100501 = oo.class(SkillBase)
function Skill911100501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill911100501:OnActionOver(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 911100501
	if self:Rand(5000) then
		self:Help(SkillEffect[911100501], caster, target, data, 2)
	end
end
