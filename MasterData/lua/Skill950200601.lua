-- 2技能反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950200601 = oo.class(SkillBase)
function Skill950200601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill950200601:OnAttackOver(caster, target, data)
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
	-- 950200701
	if self:Rand(8000) then
		local r = self.card:Rand(4)+1
		if 1 == r then
			-- 950200702
			self:AddBuff(SkillEffect[950200702], caster, target, data, 950200702)
		elseif 2 == r then
			-- 950200703
			self:AddBuff(SkillEffect[950200703], caster, target, data, 950200703)
		elseif 3 == r then
			-- 950200704
			self:AddBuff(SkillEffect[950200704], caster, target, data, 950200704)
		elseif 4 == r then
			-- 950200705
			self:AddBuff(SkillEffect[950200705], caster, target, data, 950200705)
		end
	end
end
