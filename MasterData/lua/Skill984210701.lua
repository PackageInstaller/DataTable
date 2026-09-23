-- 狮子座狂暴形态被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984210701 = oo.class(SkillBase)
function Skill984210701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill984210701:OnActionOver(caster, target, data)
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
	-- 984210701
	self:AddBuff(SkillEffect[984210701], caster, self.card, data, 984210701)
end
