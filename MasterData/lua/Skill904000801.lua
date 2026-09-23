-- 反射
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill904000801 = oo.class(SkillBase)
function Skill904000801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill904000801:OnAddBuff(caster, target, data, buffer)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8572
	self:ReflectBuff(SkillEffect[8572], caster, target, data, 2,1,5000,2)
end
