-- 冷酷追击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319105 = oo.class(SkillBase)
function Skill319105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill319105:OnActionOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8096
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8678
	local count678 = SkillApi:SkillLevel(self, caster, target,3,7009002)
	-- 319105
	self:CallSkill(SkillEffect[319105], caster, self.card, data, 700900200+count678)
end
