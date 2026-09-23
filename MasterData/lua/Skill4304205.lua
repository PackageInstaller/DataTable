-- 喵之爪
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304205 = oo.class(SkillBase)
function Skill4304205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4304205:OnAttackOver(caster, target, data)
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
	-- 8629
	local count629 = SkillApi:GetNP(self, caster, target,4)
	-- 8829
	if SkillJudger:Greater(self, caster, target, true,count629,4) then
	else
		return
	end
	-- 4304205
	if self:Rand(4000) then
		self:AddNp(SkillEffect[4304205], caster, target, data, -5)
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
		-- 8629
		local count629 = SkillApi:GetNP(self, caster, target,4)
		-- 8829
		if SkillJudger:Greater(self, caster, target, true,count629,4) then
		else
			return
		end
		-- 4304206
		self:AddNp(SkillEffect[4304206], caster, self.card, data, 5)
		-- 8631
		local count631 = SkillApi:SkillLevel(self, caster, target,3,3271)
		-- 8831
		if SkillJudger:Greater(self, caster, target, true,count631,0) then
		else
			return
		end
		-- 4304207
		self:AddProgress(SkillEffect[4304207], caster, self.card, data, count631*40)
		-- 8257
		if SkillJudger:HasSummoner(self, caster, self.card, true) then
		else
			return
		end
		-- 4304208
		self:AddProgress(SkillEffect[4304208], caster, self.card.oSummoner, data, count631*40)
	end
end
-- 行动结束
function Skill4304205:OnActionOver(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8633
	local count633 = SkillApi:GetDamage(self, caster, target,1)
	-- 4801902
	self:AddHp(SkillEffect[4801902], caster, self.card, data, math.floor(count633*0.15))
end
