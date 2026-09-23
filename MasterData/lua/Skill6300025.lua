-- 虚数天灾困难模式buff5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6300025 = oo.class(SkillBase)
function Skill6300025:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill6300025:OnAttackOver(caster, target, data)
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
	-- 984020806
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 984020807
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984020807], caster, self.card, data, 984020802)
		end
	elseif 2 == r then
		-- 984020808
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984020808], caster, self.card, data, 984020803)
		end
	elseif 3 == r then
		-- 984020809
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984020809], caster, self.card, data, 984020804)
		end
	elseif 4 == r then
		-- 984020810
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984020810], caster, self.card, data, 984020805)
		end
	end
end
