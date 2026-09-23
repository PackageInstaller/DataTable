-- 第6章小怪被动3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008032 = oo.class(SkillBase)
function Skill110008032:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill110008032:OnAttackOver(caster, target, data)
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
	-- 110008032
	if self:Rand(5000) then
		local targets = SkillFilter:Rand(self, caster, target, 3)
		for i,target in ipairs(targets) do
			self:AddProgress(SkillEffect[110008032], caster, target, data, 400)
		end
	end
end
-- 行动结束
function Skill110008032:OnActionOver(caster, target, data)
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
	-- 1100080321
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[1100080321], caster, caster, data, 1001)
	end
end
