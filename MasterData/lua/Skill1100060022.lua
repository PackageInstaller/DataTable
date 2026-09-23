-- 灭刃阵营角色攻击后，使敌方行动提前50%，使其攻击力下降20%，持续1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100060022 = oo.class(SkillBase)
function Skill1100060022:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100060022:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100060022
	self:AddProgress(SkillEffect[1100060022], caster, target, data, 400)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100060025
	self:AddTempAttrPercent(SkillEffect[1100060025], caster, target, data, "attack",-0.3)
end
