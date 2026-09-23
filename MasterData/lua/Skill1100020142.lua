-- 随机获得1个强大的效果，或者1个弱化效果（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020142 = oo.class(SkillBase)
function Skill1100020142:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill1100020142:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 11000201490
	local r = self.card:Rand(7)+1
	if 1 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 1100020141
		self:AddBuff(SkillEffect[1100020141], caster, self.card, data, 1100020141)
	elseif 2 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 1100020142
		self:AddBuff(SkillEffect[1100020142], caster, self.card, data, 1100020142)
	elseif 3 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 1100020143
		self:AddBuff(SkillEffect[1100020143], caster, self.card, data, 1100020143)
	elseif 4 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 1100020144
		self:AddBuff(SkillEffect[1100020144], caster, self.card, data, 1100020144)
	elseif 5 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 1100020146
		self:AddBuff(SkillEffect[1100020146], caster, self.card, data, 1100020146)
	elseif 6 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 1100020147
		self:AddBuff(SkillEffect[1100020147], caster, self.card, data, 1100020147)
	elseif 7 == r then
		-- 8060
		if SkillJudger:CasterIsSelf(self, caster, target, true) then
		else
			return
		end
		-- 11000201491
		self:AddBuff(SkillEffect[11000201491], caster, self.card, data, 11000201491)
	end
end
