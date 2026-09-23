-- 蜘蛛召唤物2给自身技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914400201 = oo.class(SkillBase)
function Skill914400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914400201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914400208
	local r = self.card:Rand(5)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400204
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400204], caster, target, data, 914400204)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400205
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400205], caster, target, data, 914400205)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400206
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400206], caster, target, data, 914400206)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914400207
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914400207], caster, target, data, 914400207)
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
