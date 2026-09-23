-- 状态置换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319902 = oo.class(SkillBase)
function Skill319902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill319902:OnAttackOver(caster, target, data)
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
	-- 319902
	if self:Rand(4000) then
		self:StealBuff(SkillEffect[319902], caster, target, data, 2,1)
		-- 319912
		if self:Rand(4000) then
			self:TransferBuff(SkillEffect[319912], caster, target, data, 3,1)
		end
	end
end
