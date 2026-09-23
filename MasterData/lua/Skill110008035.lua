-- 第6章小怪被动6
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008035 = oo.class(SkillBase)
function Skill110008035:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束2
function Skill110008035:OnAttackOver2(caster, target, data)
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
	-- 110008035
	local r = self.card:Rand(4)+1
	if 1 == r then
		-- 1100080351
		self:AddBuff(SkillEffect[1100080351], caster, target, data, 5004)
	elseif 2 == r then
		-- 1100080352
		self:AddBuff(SkillEffect[1100080352], caster, target, data, 5104)
	elseif 3 == r then
		-- 1100080353
		self:AddBuff(SkillEffect[1100080353], caster, target, data, 5204)
	elseif 4 == r then
		-- 1100080354
		self:AddBuff(SkillEffect[1100080354], caster, target, data, 5304)
	end
end
