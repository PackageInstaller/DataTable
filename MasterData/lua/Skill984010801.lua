-- 双子宫-波拉克斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984010801 = oo.class(SkillBase)
function Skill984010801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill984010801:OnAttackOver(caster, target, data)
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
	-- 984010801
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 984010802
		self:AddBuff(SkillEffect[984010802], caster, target, data, 984010802)
	elseif 2 == r then
		-- 984010803
		self:AddBuff(SkillEffect[984010803], caster, target, data, 984010803)
	elseif 3 == r then
		-- 984010804
		self:AddBuff(SkillEffect[984010804], caster, target, data, 984010804)
	elseif 4 == r then
		-- 984010805
		self:AddBuff(SkillEffect[984010805], caster, target, data, 984010805)
	end
end
