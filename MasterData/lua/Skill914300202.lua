-- 蜘蛛召唤物1给敌方技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914300202 = oo.class(SkillBase)
function Skill914300202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914300202:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914300213
	local r = self.card:Rand(5)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300209
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300209], caster, target, data, 914300204)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300210
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300210], caster, target, data, 914300205)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300211
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300211], caster, target, data, 914300206)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300212
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300212], caster, target, data, 914300207)
	elseif 5 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300215
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300215], caster, target, data, 914300208)
	end
end
