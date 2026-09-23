-- 沉稳进击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315305 = oo.class(SkillBase)
function Skill315305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill315305:OnActionOver(caster, target, data)
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
	-- 315305
	self:AddBuff(SkillEffect[315305], caster, self.card, data, 315305)
end
