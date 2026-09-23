-- 狮子座普通形态被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984200701 = oo.class(SkillBase)
function Skill984200701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill984200701:OnActionOver(caster, target, data)
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
	-- 984200701
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[984200701], caster, target, data, 984200701)
	end
end
