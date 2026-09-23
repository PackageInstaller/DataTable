-- 防御转化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325503 = oo.class(SkillBase)
function Skill325503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill325503:OnActionBegin(caster, target, data)
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
	-- 8423
	local count23 = SkillApi:GetAttr(self, caster, target,3,"defense")
	-- 325503
	self:AddTempAttr(SkillEffect[325503], caster, self.card, data, "attack",count23*06)
end
