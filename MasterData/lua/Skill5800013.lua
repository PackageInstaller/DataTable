-- 世界boss词条buff7
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800013 = oo.class(SkillBase)
function Skill5800013:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill5800013:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 5800059
	local r = self.card:Rand(9)+1
	if 1 == r then
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
		-- 5800051
		self:AddBuff(SkillEffect[5800051], caster, self.card, data, 5800051)
	elseif 2 == r then
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
		-- 5800052
		self:AddBuff(SkillEffect[5800052], caster, self.card, data, 5800052)
	elseif 3 == r then
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
		-- 5800053
		self:AddBuff(SkillEffect[5800053], caster, self.card, data, 5800053)
	elseif 4 == r then
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
		-- 5800054
		self:AddBuff(SkillEffect[5800054], caster, self.card, data, 5800054)
	elseif 5 == r then
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
		-- 5800055
		self:AddBuff(SkillEffect[5800055], caster, self.card, data, 5800055)
	elseif 6 == r then
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
		-- 5800056
		self:AddBuff(SkillEffect[5800056], caster, self.card, data, 5800056)
	elseif 7 == r then
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
		-- 5800057
		self:AddBuff(SkillEffect[5800057], caster, self.card, data, 5800057)
	elseif 8 == r then
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
		-- 5800058
		self:AddBuff(SkillEffect[5800058], caster, self.card, data, 5800058)
	elseif 9 == r then
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
		-- 5800065
		self:AddBuff(SkillEffect[5800065], caster, self.card, data, 5800065)
	end
end
