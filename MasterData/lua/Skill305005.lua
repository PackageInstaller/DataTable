-- 天赋效果305005
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305005 = oo.class(SkillBase)
function Skill305005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305005:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305005
	if self:Rand(5000) then
		local r = self.card:Rand(5)+1
		if 1 == r then
			-- 4014
			self:AddBuff(SkillEffect[4014], caster, self.card, data, 4004)
		elseif 2 == r then
			-- 4114
			self:AddBuff(SkillEffect[4114], caster, self.card, data, 4104)
		elseif 3 == r then
			-- 4214
			self:AddBuff(SkillEffect[4214], caster, self.card, data, 4204)
		elseif 4 == r then
			-- 4314
			self:AddBuff(SkillEffect[4314], caster, self.card, data, 4304)
		elseif 5 == r then
			-- 4714
			self:AddBuff(SkillEffect[4714], caster, self.card, data, 4704)
		end
	end
end
