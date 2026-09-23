-- 肉鸽角色气象角色使用大招后有40%概率提前100%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100040071 = oo.class(SkillBase)
function Skill1100040071:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100040071:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 1100040071
	if self:Rand(4000) then
		self:AddProgress(SkillEffect[1100040071], caster, self.card, data, 1000)
	end
end
