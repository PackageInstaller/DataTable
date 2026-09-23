-- 状态置换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319901 = oo.class(SkillBase)
function Skill319901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill319901:OnAttackOver(caster, target, data)
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
	-- 319901
	if self:Rand(2000) then
		self:StealBuff(SkillEffect[319901], caster, target, data, 2,1)
		-- 319911
		if self:Rand(2000) then
			self:TransferBuff(SkillEffect[319911], caster, target, data, 3,1)
		end
	end
end
