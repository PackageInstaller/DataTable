-- 虚数天灾困难模式buff4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6300024 = oo.class(SkillBase)
function Skill6300024:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill6300024:OnAttackOver(caster, target, data)
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
	-- 984010806
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 984010807
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984010807], caster, target, data, 984010802)
		end
	elseif 2 == r then
		-- 984010808
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984010808], caster, target, data, 984010803)
		end
	elseif 3 == r then
		-- 984010809
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984010809], caster, target, data, 984010804)
		end
	elseif 4 == r then
		-- 984010810
		if self:Rand(8000) then
			self:AddBuff(SkillEffect[984010810], caster, target, data, 984010805)
		end
	end
end
