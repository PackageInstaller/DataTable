-- 真理天秤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703305 = oo.class(SkillBase)
function Skill4703305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4703305:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703306
	self:AddBuff(SkillEffect[4703306], caster, self.card, data, 4703306)
end
-- 攻击结束2
function Skill4703305:OnAttackOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8096
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8665
	local count665 = SkillApi:BuffCount(self, caster, target,3,4,4703306)
	-- 8872
	if SkillJudger:Greater(self, caster, target, true,count665,0) then
	else
		return
	end
	-- 4703305
	self:CallSkill(SkillEffect[4703305], caster, self.card, data, 703300405)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703307
	self:DelBufferTypeForce(SkillEffect[4703307], caster, self.card, data, 4703306)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4703305:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4703315
	self:AddBuff(SkillEffect[4703315], caster, self.card, data, 4703305)
end
-- 攻击结束
function Skill4703305:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8099
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.3) then
	else
		return
	end
	-- 8462
	local count62 = SkillApi:GetAttr(self, caster, target,3,"attack")
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8667
	local count667 = SkillApi:BuffCount(self, caster, target,3,4,703300301)
	-- 8877
	if SkillJudger:Greater(self, caster, target, true,count667,0) then
	else
		return
	end
	-- 703300315
	self:AddHp(SkillEffect[703300315], caster, target, data, -math.min(count67,count62*8),1)
end
