-- 蜘蛛召唤物1给自身技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914300201 = oo.class(SkillBase)
function Skill914300201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914300201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 914300208
	local r = self.card:Rand(9)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300204
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300204], caster, target, data, 914300204)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300205
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300205], caster, target, data, 914300205)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300206
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300206], caster, target, data, 914300206)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300207
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300207], caster, target, data, 914300207)
	elseif 5 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300214
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300214], caster, target, data, 914300208)
	elseif 6 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300207
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300207], caster, target, data, 914300207)
	elseif 7 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300207
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300207], caster, target, data, 914300207)
	elseif 8 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300207
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300207], caster, target, data, 914300207)
	elseif 9 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 914300207
		self.order = self.order + 1
		self:AddBuff(SkillEffect[914300207], caster, target, data, 914300207)
	end
end
