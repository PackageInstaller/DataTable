-- 蜘蛛召唤物2给敌方技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914400202 = oo.class(SkillBase)
function Skill914400202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914400202:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914400220
	local r = self.card:Rand(5)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400209
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400209], caster, target, data, 914400204)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400210
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400210], caster, target, data, 914400205)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400211
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400211], caster, target, data, 914400206)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400212
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400212], caster, target, data, 914400207)
	elseif 5 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400221
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400221], caster, target, data, 914400208)
	end
end
