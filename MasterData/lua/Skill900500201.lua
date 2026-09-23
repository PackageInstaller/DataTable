-- 能量填充
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill900500201 = oo.class(SkillBase)
function Skill900500201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill900500201:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 900500203
	local B1 = SkillApi:BuffCount(self, caster, target,3,3,900500201)
	-- 900500206
	if SkillJudger:Less(self, caster, self.card, true,B1,3) then
	else
		return
	end
	-- 900500205
	self:CallOwnerSkill(SkillEffect[900500205], caster, self.card, data, 900500101)
end
