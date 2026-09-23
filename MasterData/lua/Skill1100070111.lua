-- 暴击减伤1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070111 = oo.class(SkillBase)
function Skill1100070111:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击
function Skill1100070111:OnCrit(caster, target)
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
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 1100070111
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[1100070111], caster, self.card, data, 4906)
	end
end
