-- 双子宫-卡斯托
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984020801 = oo.class(SkillBase)
function Skill984020801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill984020801:OnAttackOver(caster, target, data)
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
	-- 984020801
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 984020802
		self:AddBuff(SkillEffect[984020802], caster, self.card, data, 984020802)
	elseif 2 == r then
		-- 984020803
		self:AddBuff(SkillEffect[984020803], caster, self.card, data, 984020803)
	elseif 3 == r then
		-- 984020804
		self:AddBuff(SkillEffect[984020804], caster, self.card, data, 984020804)
	elseif 4 == r then
		-- 984020805
		self:AddBuff(SkillEffect[984020805], caster, self.card, data, 984020805)
	end
end
