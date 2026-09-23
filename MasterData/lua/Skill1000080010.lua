-- 乱序第一期词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000080010 = oo.class(SkillBase)
function Skill1000080010:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill1000080010:OnAttackBegin(caster, target, data)
	-- 1000080010
	self:AddBuff(SkillEffect[1000080010], caster, self.card, data, 1000080010)
end
-- 伤害后
function Skill1000080010:OnAfterHurt(caster, target, data)
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
	-- 1000080020
	if self:Rand(6000) then
		self:BeatAgain(SkillEffect[1000080020], caster, target, data, nil)
	end
end
